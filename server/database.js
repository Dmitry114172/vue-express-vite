// src/database.js
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();
// Создание подключения к базе данных
const connection = await mysql.createConnection({
    host: process.env.HOST, // Хост базы данных
    user: process.env.USER,      // Имя пользователя
    password: process.env.PASS, // Пароль
    database: process.env.DB   // Имя базы данных
});

console.log('Connected to the MySQL database.');

export default connection;
