<template>
  <div class="login-container">
    <h2><i class="bi bi-box-arrow-in-right"></i> Вход</h2>
    <form @submit.prevent="handleLogin" class="login-form">
      <div class="input-group mb-3">
        <span class="input-group-text"><i class="bi bi-person"></i></span>
        <input
          type="text"
          v-model="username"
          placeholder="Имя пользователя"
          required
          class="form-control"
        />
      </div>
      
      <div class="input-group mb-3">
        <span class="input-group-text"><i class="bi bi-lock"></i></span>
        <input
          type="password"
          v-model="password"
          placeholder="Пароль"
          required
          class="form-control"
        />
      </div>
      
      <button type="submit" class="btn btn-primary w-100">
        <i class="bi bi-box-arrow-in-right me-2"></i>Войти
      </button>
      
      <div class="mt-3 text-center">
        Нет аккаунта? <router-link to="/register">Зарегистрируйтесь</router-link>
      </div>
    </form>
    
    <div v-if="errorMessage" class="alert alert-danger mt-3">
      {{ errorMessage }}
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/store/userStore';

const username = ref('');
const password = ref('');
const errorMessage = ref('');
const router = useRouter();
const userStore = useUserStore();

const handleLogin = async () => {
  try {
    errorMessage.value = '';
    
    const response = await fetch('http://localhost:5171/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        username: username.value,
        password: password.value,
      }),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || 'Ошибка при входе');
    }

    const data = await response.json();
    
    // Сохраняем токен
    localStorage.setItem('token', data.token);
    
    // Обновляем состояние пользователя через userStore
    userStore.login({
      username: data.user.username,
      role: data.user.role
    });

    // Перенаправляем в зависимости от роли
    const redirectPath = data.user.role === 'admin' ? '/admin' : '/';
    router.push(redirectPath);
    
  } catch (error) {
    errorMessage.value = error.message || 'Ошибка сервера. Пожалуйста, попробуйте позже.';
    console.error('Login error:', error);
  }
};
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 50px auto;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  background-color: #fff;
}

h2 {
  text-align: center;
  margin-bottom: 25px;
  color: #333;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.login-form {
  margin-top: 20px;
}

.input-group-text {
  background-color: #f8f9fa;
}

.alert {
  padding: 10px;
  border-radius: 5px;
  text-align: center;
}

.btn-primary {
  padding: 10px;
  font-weight: 500;
  transition: all 0.3s;
}

.btn-primary:hover {
  background-color: #0b5ed7;
  transform: translateY(-2px);
}

.text-center a {
  color: #0d6efd;
  text-decoration: none;
  font-weight: 500;
}

.text-center a:hover {
  text-decoration: underline;
}
</style>