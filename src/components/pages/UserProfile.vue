<template>
    <div>
      <h2>Личный кабинет пользователя</h2>
      <p>Добро пожаловать, пользователь!</p>
      <button @click="logout">Выйти</button>
    </div>
  </template>
  
  <script setup>
  import { useRouter } from 'vue-router';
  
  const router = useRouter();
  
  const logout = () => {
    localStorage.removeItem('user');
    router.push('/');
  };
  </script>
  