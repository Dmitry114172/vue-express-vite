<template>
  <div class="user-panel">
    <h2>Пользователи</h2>
    <ul>
      <li v-for="user in users" :key="user.id">{{ user.name }}</li>
    </ul>
    <button @click="logout">Выйти</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const users = ref([]);

const fetchUsers = async () => {
  try {
    const response = await fetch('http://localhost:5171/api/users');
    if (!response.ok) {
      throw new Error('Ошибка получения пользователей');
    }
    const data = await response.json();
    users.value = data;
  } catch (error) {
    console.error('Ошибка при получении пользователей:', error);
  }
};

const logout = () => {
  localStorage.removeItem('authToken');
  localStorage.removeItem('user');
  console.log('Выход из системы');
};

onMounted(fetchUsers);
</script>

<style scoped>

</style>
