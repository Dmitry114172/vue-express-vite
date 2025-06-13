import { body, param, validationResult } from 'express-validator';

export const validateProduct = [
  body('title').trim().notEmpty().withMessage('Название товара обязательно').isLength({ max: 255 }),
  body('vendor').trim().notEmpty().withMessage('Производитель обязателен').isLength({ max: 100 }),
  body('price').isFloat({ min: 0 }).withMessage('Цена должна быть положительным числом'),
  body('category_id').isInt({ min: 1 }).withMessage('Неверный ID категории'),
  body('short_description').optional().trim().isLength({ max: 500 }),
  body('description').optional().trim(),
  body('technical_specifications').optional().trim(),
];

export const validateCategory = [
  body('name').trim().notEmpty().withMessage('Название категории обязательно').isLength({ max: 100 }),
];

export const validateId = [
  param('id').isInt({ min: 1 }).withMessage('Неверный ID'),
];

export const validateResults = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
}; 