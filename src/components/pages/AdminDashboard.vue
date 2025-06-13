<template>
  <div class="dashboard">
    <div class="dashboard__nav">
      <nav class="navs">
        <li class="navs__item">
          <a class="nav-link" @click.prevent="showComponent('products')">Товары</a>
        </li>
        <li class="navs__item">
          <a class="nav-link" @click.prevent="showComponent('categories')">Категории</a>
        </li>
        <li class="navs__item">
          <a class="nav-link" @click.prevent="showComponent('users')">Пользователи</a>
        </li>
      </nav>
    </div>
    <div class="dashboard__content">
      <h1>Панель управления</h1>
      <p>Общее количество пользователей: {{ totalUsers }}</p>
      <p>Общее количество категорий: {{ totalCategories }}</p>
      <p>Общее количество товаров: {{ totalGoods }}</p>
      
      <!-- Условный рендеринг для отображения нужного компонента -->
      <AdminProducts v-if="activeComponent === 'products'" />
      <AdminCategories v-if="activeComponent === 'categories'" />
      <AdminUsers v-if="activeComponent === 'users'" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import AdminCategories from "./AdminCategories.vue";
import AdminProducts from "./AdminProducts.vue";
import AdminUsers from "./AdminUsers.vue";
import { 
  fetchGoods, 
  fetchCategories 
} from "@/controller/apiController";

// Состояние
const users = ref([]);
const categories = ref([]);
const products = ref([]);
const activeComponent = ref('products'); // По умолчанию отображаем товары

// Вычисляемые свойства
const totalUsers = computed(() => users.value.length);
const totalCategories = computed(() => categories.value.length);
const totalGoods = computed(() => products.value.length);

// Методы
const showComponent = (component) => {
  activeComponent.value = component;
};

const fetchUsers = async () => {
  try {
    const response = await fetch(`${import.meta.env.VITE_API_BASE_URL}/users`);
    if (!response.ok) throw new Error("Ошибка получения пользователей");
    users.value = await response.json();
  } catch (error) {
    console.error("Ошибка при получении пользователей:", error);
    users.value = [];
  }
};

const fetchAllCategories = async () => {
  try {
    categories.value = await fetchCategories();
  } catch (error) {
    console.error("Ошибка при получении категорий:", error);
    categories.value = [];
  }
};

const fetchAllGoods = async () => {
  try {
    products.value = await fetchGoods();
  } catch (error) {
    console.error("Ошибка при получении товаров:", error);
    products.value = [];
  }
};

// Инициализация
onMounted(() => {
  fetchUsers();
  fetchAllCategories();
  fetchAllGoods();
});
</script>

<style scoped>
.dashboard {
  display: flex;
  min-height: 100vh;
}

.dashboard__nav {
  width: 250px;
  background-color: #f5f5f5;
  padding: 20px;
}

.navs {
  list-style: none;
  padding: 0;
  margin: 0;
}

.navs__item {
  margin-bottom: 10px;
}

.nav-link {
  display: block;
  padding: 8px 12px;
  color: #333;
  text-decoration: none;
  cursor: pointer;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.nav-link:hover {
  background-color: #e0e0e0;
}

.dashboard__content {
  flex: 1;
  padding: 20px;
}
</style>



<style scoped>
.dashboard {
  display: grid;
  grid-template-columns: 1fr 4fr; /* Устанавливаем 1fr для навигации и 4fr для содержимого */
  height: 100vh; /* Занять всю высоту окна */
}

.dashboard__nav {
  background-color: #f4f4f4; /* Светлый фон для навигации */
  padding: 20px; /* Отступы для навигации */
  border-right: 1px solid #ccc; /* Разделитель между навигацией и содержимым */
}

.navs {
  list-style: none; /* Удаление маркеров списка */
  padding: 0; /* Удаление отступов */
  margin: 0; /* Удаление внешних отступов */
}

.navs__item {
  margin: 10px 0; /* Отступы между элементами навигации */
  padding: 10px; /* Внутренние отступы для элементов навигации */
  cursor: pointer; /* Курсор указывает, что элемент кликабельный */
  transition: background-color 0.3s; /* Плавный переход цвета фона */
}

.navs__item:hover {
  background-color: #e0e0e0; /* Изменение цвета фона при наведении */
}

.dashboard__content {
  padding: 20px; /* Отступы для содержимого */
  background-color: #fff; /* Белый фон для содержимого */
  overflow-y: auto; /* Прокрутка содержимого, если оно превышает высоту */
}

h1 {
  margin-bottom: 20px; /* Отступ снизу для заголовка */
  font-size: 24px; /* Размер шрифта заголовка */
}

p {
  margin: 10px 0; /* Отступы между параграфами */
  font-size: 18px; /* Размер шрифта для параграфов */
}
</style>
