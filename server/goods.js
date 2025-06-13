import express from 'express';
import connection from './database.js';
import multer from 'multer';
import path from 'node:path';
import fs from 'node:fs/promises';
import { fileURLToPath } from 'url';
import { v4 as uuidv4 } from 'uuid';
import { authMiddleware, adminMiddleware } from './middleware/auth.js';
import { validateProduct, validateId, validateResults } from './middleware/validation.js';
const router = express.Router();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const IMAGE_UPLOAD_PATH = path.join(__dirname, '../public/assets/image');
// Настройка хранилища для multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    fs.mkdir(IMAGE_UPLOAD_PATH, { recursive: true })
      .then(() => cb(null, IMAGE_UPLOAD_PATH))
      .catch(err => cb(err));
  },
  filename: (req, file, cb) => {
    const uniqueName = `${uuidv4()}${path.extname(file.originalname)}`;
    cb(null, uniqueName);
  }
});
const upload = multer({
  storage,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB
    files: 5 // максимум 5 файлов
  },
  fileFilter: (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/webp'];
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Неподдерживаемый тип файла'));
    }
  }
});
// Вспомогательная функция для удаления файла изображения
const deleteImageFile = async (filename) => {
  try {
    const filePath = path.join(IMAGE_UPLOAD_PATH, filename);
    await fs.unlink(filePath);
    return true;
  } catch (error) {
    console.error(`Ошибка при удалении файла ${filename}:`, error);
    return false;
  }
};
// Получение списка товаров (публичный доступ)
router.get('/', async (req, res) => {
  const categoryId = req.query.categoryId;
  try {
    const query = `
      SELECT p.id, p.vendor, p.title, p.short_description, p.description, p.price, p.technical_specifications, 
             GROUP_CONCAT(i.image_url) AS images
      FROM products p
      LEFT JOIN images i ON p.id = i.product_id
      ${categoryId ? 'WHERE p.category_id = ?' : ''}
      GROUP BY p.id
    `;
    const params = categoryId ? [categoryId] : [];
    const [rows] = await connection.query(query, params);
    res.json(rows);
  } catch (error) {
    console.error('Ошибка при получении товаров:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});
// Получение конкретного товара (публичный доступ)
router.get('/:id', validateId, validateResults, async (req, res) => {
  const productId = req.params.id;
  try {
    const [productRows] = await connection.query(`
      SELECT p.id, p.vendor, p.title, p.short_description, p.description, p.price, p.technical_specifications, 
             p.category_id, 
             GROUP_CONCAT(i.image_url) AS images
      FROM products p
      LEFT JOIN images i ON p.id = i.product_id
      WHERE p.id = ?
      GROUP BY p.id
    `, [productId]);
    
    if (productRows.length === 0) {
      return res.status(404).json({ error: 'Товар не найден' });
    }
    
    const product = productRows[0];
    const [categoryRows] = await connection.query('SELECT * FROM categories WHERE id = ?', [product.category_id]);
    product.category = categoryRows.length > 0 ? categoryRows[0] : null;
    res.json(product);
  } catch (error) {
    console.error('Ошибка при получении товара:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});
// Добавление товара (только для админов)
router.post('/', 
  adminMiddleware,
  upload.array('images', 5),
  validateProduct,
  validateResults,
  async (req, res) => {
    try {
      const { title, vendor, price, category_id, short_description, description, technical_specifications } = req.body;
      
      const [result] = await connection.query(
        'INSERT INTO products (title, vendor, price, category_id, short_description, description, technical_specifications) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [title, vendor, price, category_id, short_description, description, technical_specifications]
      );

      // Сохранение изображений
      if (req.files && req.files.length > 0) {
        const imageValues = req.files.map(file => [result.insertId, file.filename]);
        await connection.query('INSERT INTO images (product_id, image_url) VALUES ?', [imageValues]);
      }

      res.status(201).json({ id: result.insertId, message: 'Товар успешно добавлен' });
    } catch (error) {
      console.error('Ошибка при добавлении товара:', error);
      res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
  }
);
// Обновление товара (только для админов)
router.put('/:id',
  adminMiddleware,
  upload.array('images', 5),
  validateId,
  validateProduct,
  validateResults,
  async (req, res) => {
    try {
      const { title, vendor, price, category_id, short_description, description, technical_specifications } = req.body;
      
      await connection.query(
        'UPDATE products SET title = ?, vendor = ?, price = ?, category_id = ?, short_description = ?, description = ?, technical_specifications = ? WHERE id = ?',
        [title, vendor, price, category_id, short_description, description, technical_specifications, req.params.id]
      );

      // Сохранение новых изображений
      if (req.files && req.files.length > 0) {
        const imageValues = req.files.map(file => [req.params.id, file.filename]);
        await connection.query('INSERT INTO images (product_id, image_url) VALUES ?', [imageValues]);
      }

      res.json({ message: 'Товар успешно обновлен' });
    } catch (error) {
      console.error('Ошибка при обновлении товара:', error);
      res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
  }
);
// Удаление товара (только для админов)
router.delete('/:id',
  adminMiddleware,
  validateId,
  validateResults,
  async (req, res) => {
    try {
      // Сначала удаляем все изображения товара
      await connection.query('DELETE FROM images WHERE product_id = ?', [req.params.id]);
      // Затем удаляем сам товар
      await connection.query('DELETE FROM products WHERE id = ?', [req.params.id]);
      res.json({ message: 'Товар успешно удален' });
    } catch (error) {
      console.error('Ошибка при удалении товара:', error);
      res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
  }
);
// Удаление изображения товара (только для админов)
router.delete('/:id/images/:imageName',
  adminMiddleware,
  validateId,
  validateResults,
  async (req, res) => {
    try {
      await connection.query('DELETE FROM images WHERE product_id = ? AND image_url = ?', 
        [req.params.id, req.params.imageName]);
      res.json({ message: 'Изображение успешно удалено' });
    } catch (error) {
      console.error('Ошибка при удалении изображения:', error);
      res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
  }
);
export default router;