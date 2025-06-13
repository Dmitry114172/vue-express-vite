export const fetchCategories = async () => {
  try {
    const response = await fetch('http://localhost:5171/api/categories'); // Убедитесь, что URL правильный
    if (!response.ok) {
      throw new Error('Сетевая ошибка: ответ не был успешным');
    }
    const data = await response.json(); // Получаем все категории
    return data; // Возвращаем данные категорий
  } catch (error) {
    console.error('Ошибка при получении категорий:', error);
    return []; // Возвращаем пустой массив в случае ошибки
  }
};


