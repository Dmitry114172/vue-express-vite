import express from 'express';
import connection from './database.js';
const router = express.Router();

// Получение всех категорий
router.get('/', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT * FROM categories');
    res.json(rows);
  } catch (error) {
    console.error('Ошибка при получении категорий:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

// Получение категории по ID
router.get('/:id', async (req, res) => {
  const categoryId = req.params.id;
  try {
    const [rows] = await connection.query('SELECT * FROM categories WHERE id = ?', [categoryId]);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Категория не найдена' });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error('Ошибка при получении категории:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

// Создание новой категории
router.post('/', async (req, res) => {
  const { name } = req.body;
  if (!name) {
    return res.status(400).json({ error: 'Название категории обязательно' });
  }
  try {
    const [result] = await connection.query('INSERT INTO categories (name) VALUES (?)', [name]);
    const categoryId = result.insertId;
    res.status(201).json({ message: 'Категория успешно добавлена', categoryId });
  } catch (error) {
    console.error('Ошибка при добавлении категории:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

// Обновление категории
router.put('/:id', async (req, res) => {
  const categoryId = req.params.id;
  const { name } = req.body;
  if (!name) {
    return res.status(400).json({ error: 'Название категории обязательно' });
  }
  try {
    const [result] = await connection.query('UPDATE categories SET name = ? WHERE id = ?', [name, categoryId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Категория не найдена' });
    }
    res.json({ message: 'Категория успешно обновлена' });
  } catch (error) {
    console.error('Ошибка при обновлении категории:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

// Удаление категории
router.delete('/:id', async (req, res) => {
  const categoryId = req.params.id;
  try {
    const [result] = await connection.query('DELETE FROM categories WHERE id = ?', [categoryId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Категория не найдена' });
    }
    res.json({ message: 'Категория успешно удалена' });
  } catch (error) {
    console.error('Ошибка при удалении категории:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

export default router;
