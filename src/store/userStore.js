// src/store/userStore.js
import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useUserStore = defineStore('user', () => {
  const user = ref(null);
  
  // Загружаем пользователя из localStorage при инициализации
  const storedUser = localStorage.getItem('user');
  if (storedUser) {
    user.value = JSON.parse(storedUser);
  }
  
  const login = (userData) => {
    user.value = userData;
    localStorage.setItem('user', JSON.stringify(userData));
  };
  
  const logout = () => {
    user.value = null;
    localStorage.removeItem('user');
    localStorage.removeItem('token');
  };
  
  return { user, login, logout };
});