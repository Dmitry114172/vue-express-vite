// server/users.js
import express from 'express';

const router = express.Router();

// Пример данных пользователей (в реальном приложении данные будут из базы данных)
let users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', email: 'jane@example.com' },
];

// Получить всех пользователей
router.get('/', (req, res) => {
  res.json(users);
});

// Получить пользователя по ID
router.get('/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).send('Пользователь не найден');
  res.json(user);
});

// Создать нового пользователя
router.post('/', (req, res) => {
  const { name, email } = req.body;
  const newUser  = {
    id: users.length + 1,
    name,
    email,
  };
  users.push(newUser );
  res.status(201).json(newUser );
});

// Обновить пользователя по ID
router.put('/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).send('Пользователь не найден');

  const { name, email } = req.body;
  user.name = name;
  user.email = email;

  res.json(user);
});

// Удалить пользователя по ID
router.delete('/:id', (req, res) => {
  const userIndex = users.findIndex(u => u.id === parseInt(req.params.id));
  if (userIndex === -1) return res.status(404).send('Пользователь не найден');

  users.splice(userIndex, 1);
  res.status(204).send();
});

export default router;
