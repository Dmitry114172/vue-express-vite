import express from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import connection from './database.js';
import dotenv from 'dotenv';

dotenv.config();
const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET;

// Вход пользователя
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'Имя пользователя и пароль обязательны' });
  }

  try {
    const [user] = await connection.query('SELECT * FROM users WHERE username = ?', [username]);
    if (user.length === 0) {
      return res.status(401).json({ error: 'Неправильные имя пользователя или пароль' });
    }

    const isPasswordValid = bcrypt.compareSync(password, user[0].password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Неправильные имя пользователя или пароль' });
    }

    // Генерация токена
    const token = jwt.sign(
      { username: user[0].username, role: user[0].role },
      JWT_SECRET,
      { expiresIn: '1h' }
    );

    // Возвращаем токен и роль пользователя
    res.json({
      message: 'Вход выполнен успешно',
      token,
      user: { role: user[0].role } // Убедитесь, что роль возвращается правильно
    });
  } catch (error) {
    console.error('Ошибка при входе пользователя:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

export default router;
