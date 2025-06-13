<template>
  <div class="container product-page py-4" v-if="product.title && !isLoading">
    <!-- Хлебные крошки -->
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <router-link to="/" class="text-decoration-none">Главная</router-link>
        </li>
        <li class="breadcrumb-item" v-if="category.name">
          <router-link :to="`/category/${category.id}`" class="text-decoration-none">
            {{ category.name }}
          </router-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">
          <span class="text-truncate d-inline-block" style="max-width: 200px" :title="product.title">
            {{ product.title }}
          </span>
        </li>
      </ol>
    </nav>

    <!-- Основная информация о товаре -->
    <div class="row">
      <!-- Изображения товара -->
      <div class="col-md-6 mb-4">
        <ProductSwiper :images="product.images" />
      </div>

      <!-- Информация о товаре -->
      <div class="col-md-6">
        <h1 class="mb-3 fs-2 fw-bold">
          {{ product.title }}
          <small class="text-muted fs-5">({{ product.vendor }})</small>
        </h1>

        <p class="lead">{{ product.short_description }}</p>

        <div class="d-flex align-items-center mb-4">
          <h4 class="mb-0 me-3">{{ product.price }} руб.</h4>
          <CartButton :item="product" class="btn-lg" />
        </div>

        <router-link to="/product" class="btn btn-outline-secondary mb-4">
          ← Назад к списку товаров
        </router-link>
      </div>
    </div>

    <!-- Детали товара -->
    <div class="card mt-4">
      <div class="card-header bg-light">
        <h3 class="mb-0">Детали товара</h3>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <h5>Описание</h5>
          <p class="text-muted">{{ product.description }}</p>
        </div>
        <div>
          <h5>Технические характеристики</h5>
          <p class="text-muted">{{ product.technical_specifications }}</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Состояние загрузки -->
  <div v-else class="container py-5 text-center">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Загрузка...</span>
    </div>
    <p class="mt-3">Загрузка товара...</p>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { useRoute } from "vue-router";
import ProductSwiper from "@/components/helper/ProductSwiper.vue";
import CartButton from "@/components/helper/CartButton.vue";

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
const route = useRoute();
const product = ref({});
const category = ref({});
const isLoading = ref(true);

const fetchProduct = async (productId) => {
  try {
    isLoading.value = true;
    const response = await fetch(`${API_BASE_URL}/goods/${productId}`);
    if (!response.ok) throw new Error("Ошибка загрузки товара");
    const data = await response.json();
    return {
      ...data,
      images: data.images 
        ? data.images.split(",").map(url => ({ image_url: url.trim() })) 
        : [],
    };
  } catch (error) {
    console.error("Ошибка при загрузке товара:", error);
    return {};
  } finally {
    isLoading.value = false;
  }
};

const fetchCategory = async (categoryId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/categories/${categoryId}`);
    if (!response.ok) throw new Error("Ошибка загрузки категории");
    return await response.json();
  } catch (error) {
    console.error("Ошибка при загрузке категории:", error);
    return {};
  }
};

const loadProductData = async (productId) => {
  product.value = await fetchProduct(productId);
  if (product.value.category_id) {
    category.value = await fetchCategory(product.value.category_id);
  }
};

// Отслеживаем изменения параметров маршрута
watch(
  () => route.params.id,
  async (newId) => {
    if (newId) {
      await loadProductData(newId);
    }
  }
);

onMounted(async () => {
  const productId = route.params.id;
  if (productId) {
    await loadProductData(productId);
  }
});
</script>

<style scoped>
.product-page {
  max-width: 1200px;
}

.breadcrumb-item {
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card {
  border-radius: 0.5rem;
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.card-header {
  border-radius: 0.5rem 0.5rem 0 0 !important;
}

.card-body {
  max-height: 400px;
  overflow-y: auto;
}

.card-body::-webkit-scrollbar {
  width: 8px;
}

.card-body::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.card-body::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

.card-body::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>