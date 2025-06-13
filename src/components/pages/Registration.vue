vue
<template>
  <div class="registration-container">
    <h2>Регистрация</h2>
    <form @submit.prevent="registerUser">
      <div class="form-group">
        <label for="username">Имя пользователя:</label>
        <input
          type="text"
          id="username"
          v-model="username"
          required
          placeholder="Введите имя пользователя"
        />
      </div>
      <div class="form-group">
        <label for="password">Пароль:</label>
        <input
          type="password"
          id="password"
          v-model="password"
          required
          placeholder="Введите пароль"
        />
      </div>
      <div class="form-group">
        <label for="confirmPassword">Подтвердите пароль:</label>
        <input
          type="password"
          id="confirmPassword"
          v-model="confirmPassword"
          required
          placeholder="Подтвердите пароль"
        />
      </div>
      <button type="submit" class="register-btn">Зарегистрироваться</button>
    </form>
    <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    <p v-if="successMessage" class="success-message">{{ successMessage }}</p>
  </div>
</template>
<script setup>
import { ref } from "vue";
const username = ref("");
const password = ref("");
const confirmPassword = ref("");
const errorMessage = ref("");
const successMessage = ref("");
const registerUser = async () => {
  // Проверка на совпадение паролей
  if (password.value !== confirmPassword.value) {
    errorMessage.value = "Пароли не совпадают";
    return;
  }
  try {
    const response = await fetch("http://localhost:5171/api/register", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        username: username.value,
        password: password.value,
      }),
    });
    // Проверка успешности ответа
    if (!response.ok) {
      const data = await response.json();
      throw new Error(data.error || "Ошибка регистрации");
    }
    // Успешная регистрация
    successMessage.value = "Регистрация прошла успешно!";
    errorMessage.value = "";
  } catch (error) {
    // Обработка ошибок
    errorMessage.value = error.message;
  }
};
</script>
<style scoped>
.registration-container {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  background-color: #f9f9f9;
}
.form-group {
  margin-bottom: 15px;
}
label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}
input {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.register-btn {
  width: 100%;
  padding: 10px;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
.register-btn:hover {
  background-color: #218838;
}
.error-message {
  color: red;
  margin-top: 10px;
}
.success-message {
  color: green;
  margin-top: 10px;
}
</style>