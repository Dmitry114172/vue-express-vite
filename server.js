import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import register from './server/register.js'; // Обновите путь в соответствии с вашей структурой
import goodsRouter from './server/goods.js';
import usersRouter from './server/users.js';
import categoriesRouter from './server/categories.js';
import dotenv from 'dotenv';
const app = express();
dotenv.config();
console.log('JWT_SECRET:', process.env.JWT_SECRET); // Проверка переменной окружения
app.use(cors());
app.use(bodyParser.json());
app.use('/api', register);
app.use('/api/goods', goodsRouter);
app.use('/api/categories', categoriesRouter);
app.use('/api/users', usersRouter);
const port = process.env.PORT ;
// Start http server
app.listen(port, () => {
  console.log(`Server started at http://localhost:${port}`);
});