<template>
  <div class="admin-panel">
    <h2>Административная панель</h2>
    <p>Привет, администратор!</p>
    <button class="btn__del" @click="logout">Выйти</button>
    <div class="product-form">
      <h3>{{ newProduct.id ? 'Редактировать категорию' : 'Добавить новую категорию' }}</h3>
      <input v-model="newProduct.title" placeholder="Название категории" />
      <button @click="addOrUpdateCategory">{{ newProduct.id ? 'Обновить категорию' : 'Добавить категорию' }}</button>
    </div>
    <ul class="product-list">
      <li v-for="category in categories" :key="category.id" class="product-item">
        <span>{{ category.name }}</span>
        <div class="product-actions">
          <button @click="editCategory(category)" class="btn__red">Редактировать</button>
          <button class="btn__del" @click="confirmDeleteCategory(category.id)">Удалить</button>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const newProduct = ref({ id: null, title: '' });
const categories = ref([]);

const fetchCategories = async () => {
  const response = await fetch('http://localhost:5171/api/categories');
  categories.value = await response.json();
};

const logout = () => {
  localStorage.removeItem('authToken');
  localStorage.removeItem('user');
  router.push('/login');
  console.log('Выход из системы');
};

const addOrUpdateCategory = async () => {
  const categoryData = { name: newProduct.value.title };

  try {
    let response;
    if (newProduct.value.id) {
      response = await fetch(`http://localhost:5171/api/categories/${newProduct.value.id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(categoryData),
      });
      alert('Категория обновлена');
    } else {
      response = await fetch('http://localhost:5171/api/categories', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(categoryData),
      });
      alert('Категория добавлена');
    }

    if (!response.ok) {
      throw new Error('Ошибка при добавлении/обновлении категории');
    }
    fetchCategories(); // Обновляем список категорий после операции
    resetForm(); // Сбрасываем форму после добавления/обновления
  } catch (error) {
    console.error('Ошибка:', error);
  }
};

const editCategory = (category) => {
  newProduct.value = { id: category.id, title: category.name };
};

const confirmDeleteCategory = async (id) => {
  if (confirm('Вы уверены, что хотите удалить эту категорию?')) {
    try {
      const response = await fetch(`http://localhost:5171/api/categories/${id}`, {
        method: 'DELETE',
      });

      if (!response.ok) {
        throw new Error('Ошибка при удалении категории');
      }
      alert('Категория удалена');
      fetchCategories(); // Обновляем список категорий после удаления
    } catch (error) {
      console.error('Ошибка:', error);
    }
  }
};

const resetForm = () => {
  newProduct.value = { id: null, title: '' }; // Сбрасываем поля формы
};

onMounted(fetchCategories); // Загружаем категории при монтировании компонента
</script>

<style scoped> 
.admin-panel { 
  max-width: 1400px; 
  margin: 0 auto; 
  padding: 20px; 
  background: #f8f9fa; 
  border-radius: 8px; 
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); 
} 
h2 { 
  text-align: center; 
  color: #343a40; 
} 
.product-form, 
.modal-content { 
  margin: 20px 0; 
  padding: 20px; 
  background: #ffffff; 
  border-radius: 8px; 
  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.15); 
} 
.product-form input, 
.product-form textarea, 
.product-form select { 
  width: 100%; 
  padding: 10px; 
  margin: 10px 0; 
  border: 1px solid #ced4da; 
  border-radius: 4px; 
  font-size: 16px; 
} 

.product-form button { 
  width: 100%; 
  padding: 10px; 
  background: green; 
  color: #ffffff; 
  border: none; 
  border-radius: 4px; 
  font-size: 16px; 
  cursor: pointer; 
  transition: background 0.3s; 
} 
.product-form button:hover { 
  background: #65e454; 
} 
.product-list { 
  list-style: none; 
  padding: 0; 
} 
.product-item { 
  display: flex; 
  justify-content: space-between; 
  align-items: center; 
  padding: 10px; 
  margin: 10px 0; 
  background: #f1f1f1; 
  border-radius: 4px; 
} 
.btn__del { 
  background: crimson; 
  color: #fff; 
  border: none; 
  border-radius: 4px; 
  padding: 5px 10px; 
  cursor: pointer; 
  margin-left: 5px; 
  transition: background 0.3s; 
} 
.btn__del:hover { 
  background: #d37b7b; 
} 
.modal { 
  position: fixed; 
  top: 0; 
  left: 0; 
  width: 100%; 
  height: 100%; 
  background: rgba(0, 0, 0, 0.5); 
  display: flex; 
  justify-content: center; 
  align-items: center; 
  z-index: 100 
} 

.btn__red {
  background: rgb(0, 81, 255); 
  color: #fff; 
  border: none; 
  border-radius: 4px; 
  padding: 5px 10px; 
  cursor: pointer; 
  margin-left: 5px; 
  transition: background-color 0.3s; 
}
.btn__red:hover{
    background-color: #1215f3; 
  }
</style>
