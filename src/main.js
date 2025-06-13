import { createApp } from 'vue';
import App from './App.vue';
import { createRouter, createWebHistory } from 'vue-router';
import routes from './router'; // Предполагается, что у вас есть файл router/index.js
import 'bootstrap/dist/css/bootstrap.min.css'; // Импорт CSS Bootstrap
import 'bootstrap'; // Импорт JS Bootstrap
import { createPinia } from 'pinia';

// Создание экземпляра приложения
const app = createApp(App);

// Создание маршрутизатора
const router = createRouter({
  history: createWebHistory(),
  routes,
});

// Создание хранилища Pinia
const pinia = createPinia();

// Подключение маршрутизатора и хранилища к приложению
app.use(pinia);
app.use(router);

// Монтирование приложения
app.mount('#app');
