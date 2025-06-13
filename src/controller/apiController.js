const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

// Функция для получения заголовков с токеном
const getAuthHeaders = () => {
  const token = localStorage.getItem('token');
  return {
    'Authorization': token ? `Bearer ${token}` : '',
    'Content-Type': 'application/json'
  };
};

// Функция для обработки ответа
const handleResponse = async (response) => {
  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.error || 'Произошла ошибка');
  }
  return response.json();
};

// Товары
export const fetchGoods = async (categoryId = null) => {
  try {
    const url = categoryId 
      ? `${API_BASE_URL}/goods?categoryId=${categoryId}` 
      : `${API_BASE_URL}/goods`;
    const response = await fetch(url);
    const data = await handleResponse(response);
    return data.map(item => ({
      ...item,
      images: item.images 
        ? item.images.split(",").map(url => ({ image_url: url.trim() })) 
        : [],
    }));
  } catch (error) {
    console.error("Ошибка при загрузке товаров:", error);
    throw error;
  }
};

export const fetchProduct = async (productId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/goods/${productId}`);
    const data = await handleResponse(response);
    return {
      ...data,
      images: data.images 
        ? data.images.split(",").map(url => ({ image_url: url.trim() })) 
        : [],
    };
  } catch (error) {
    console.error("Ошибка при загрузке товара:", error);
    throw error;
  }
};

export const addProduct = async (formData) => {
  try {
    const response = await fetch(`${API_BASE_URL}/goods`, {
      method: 'POST',
      headers: getAuthHeaders(),
      body: formData,
    });
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при добавлении товара:", error);
    throw error;
  }
};

export const updateProduct = async (id, formData) => {
  try {
    const response = await fetch(`${API_BASE_URL}/goods/${id}`, {
      method: 'PUT',
      headers: getAuthHeaders(),
      body: formData,
    });
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при обновлении товара:", error);
    throw error;
  }
};

export const deleteProduct = async (id) => {
  try {
    const response = await fetch(`${API_BASE_URL}/goods/${id}`, {
      method: 'DELETE',
      headers: getAuthHeaders(),
    });
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при удалении товара:", error);
    throw error;
  }
};

export const deleteProductImage = async (productId, imageName) => {
  try {
    const response = await fetch(`${API_BASE_URL}/goods/${productId}/images/${imageName}`, {
      method: 'DELETE',
      headers: getAuthHeaders(),
    });
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при удалении изображения:", error);
    throw error;
  }
};

// Категории
export const fetchCategories = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/categories`);
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при загрузке категорий:", error);
    throw error;
  }
};

export const fetchCategory = async (categoryId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/categories/${categoryId}`);
    return handleResponse(response);
  } catch (error) {
    console.error("Ошибка при загрузке категории:", error);
    throw error;
  }
};