<template>
  <div class="product-page" v-if="product.title">
    <nav>
      <router-link to="/">Главная</router-link>
      <span> / </span>
      <router-link v-if="category.name" :to="`/category/${category.id}`">
        {{ category.name }}
      </router-link>
      <span v-else>Загрузка категории...</span>
      <span> / </span>
      <span>{{ product.title }}</span>
    </nav>
    
    <h1>{{ product.title }} ({{ product.vendor }})</h1>
    
    <ProductSwiper :images="product.images" />
    
    <p>{{ product.short_description }}</p>
    
    <div class="product-details">
      <h3>Детали товара:</h3>
      <p>Описание: {{ product.description }}</p>
      <p>Технические характеристики: {{ product.technical_specifications }}</p>
      <p>Цена: {{ product.price }} руб.</p>
    </div>
    
    <router-link to="/product">Назад к списку товаров</router-link>
  </div>
  <div v-else>
    <p>Загрузка...</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import ProductSwiper from "@/components/helper/ProductSwiper.vue";
import { fetchProduct, fetchCategory } from "@/controller/apiController";

const route = useRoute();
const product = ref({});
const category = ref({});

onMounted(async () => {
  product.value = await fetchProduct(route.params.id);
  if (product.value.category_id) {
    category.value = await fetchCategory(product.value.category_id);
  }
});
</script>

<style scoped>
.goods-list {
  list-style: none;
  padding: 0;
}
.goods-item1 {
  margin-bottom: 20px;
}
.product__image {
  border-radius: 5px;
}
.load-more-btn {
  margin-top: 20px;
}
</style>

<style scoped>
h1 {
  font-size: 2em;
  margin-bottom: 20px;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  margin: 10px 0;
}

a {
  text-decoration: none;
  color: #007BFF;
}

a:hover {
  text-decoration: underline;
}
.basket {
   background: rgb(0, 81, 255); 
  color: #fff; 
  border: none; 
  border-radius: 4px; 
  padding: 5px 10px; 
  cursor: pointer; 
  margin-left: 5px; 
  transition: background-color 0.3s; 
}
.basket:hover{
    background-color: #1215f3; 
}
</style>
