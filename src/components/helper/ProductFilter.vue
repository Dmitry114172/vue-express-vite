<template>
  <div class="search-container">
    <input
      v-model="searchQuery"
      @input="handleSearch"
      class="search-input"
      type="text"
      placeholder="Поиск товаров..."
      aria-label="Поиск по сайту"
      ref="searchInput"
      :disabled="isLoading"
    />
    <button 
      class="search-button" 
      @click="performSearch"
      :disabled="isLoading"
    >
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11 19C15.4183 19 19 15.4183 19 11C19 6.58172 15.4183 3 11 3C6.58172 3 3 6.58172 3 11C3 15.4183 6.58172 19 11 19Z" stroke="currentColor" stroke-width="2"/>
        <path d="M21 21L16.65 16.65" stroke="currentColor" stroke-width="2"/>
      </svg>
    </button>
    
    <div v-if="searchResults.length > 0" class="search-results">
      <div
        v-for="product in searchResults"
        :key="product.id"
        class="search-result-item"
        @click="navigateToProduct(product.id)"
      >
        {{ product.title }} - {{ formatPrice(product.price) }} ₽
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { fetchGoods } from '@/controller/apiController';

const route = useRoute();
const router = useRouter();
const searchQuery = ref('');
const searchResults = ref([]);
const searchInput = ref(null);
const isLoading = ref(false);

const handleSearch = async () => {
  if (searchQuery.value.length < 2) {
    searchResults.value = [];
    return;
  }
  
  try {
    isLoading.value = true;
    const allProducts = await fetchGoods();
    const filteredProducts = allProducts.filter(product => 
      product?.title?.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
    
    if (filteredProducts.length === 1) {
      await navigateToProduct(filteredProducts[0].id);
      return;
    }
    
    searchResults.value = filteredProducts.slice(0, 5);
  } catch (error) {
    console.error('Ошибка поиска:', error);
    searchResults.value = [];
  } finally {
    isLoading.value = false;
  }
};

watch(() => route.path, (newPath) => {
  if (newPath !== '/') {
    searchResults.value = [];
    searchQuery.value = '';
  }
}, { immediate: true });

const navigateToProduct = async (productId) => {
  try {
    isLoading.value = true;
    const allProducts = await fetchGoods();
    const productExists = allProducts.some(product => product.id === productId);
    
    if (productExists) {
      searchResults.value = [];
      searchQuery.value = '';
      await router.push({ name: 'ProductPage', params: { id: productId } });
    } else {
      console.error('Товар не найден');
    }
  } catch (error) {
    console.error('Ошибка при навигации:', error);
  } finally {
    isLoading.value = false;
  }
};

const performSearch = async () => {
  if (searchQuery.value.trim()) {
    await handleSearch();
  }
};

const formatPrice = (price) => {
  return new Intl.NumberFormat('ru-RU').format(price);
};

onMounted(() => {
  if (searchInput.value) {
    searchInput.value.focus();
  }
});
</script>

<style scoped>
.search-container {
  position: relative;
  margin: 0 15px;
}

.search-input {
  padding: 8px 15px;
  border: 1px solid #ddd;
  border-radius: 20px;
  width: 200px;
  transition: all 0.3s;
}

.search-input:focus {
  width: 250px;
  outline: none;
  border-color: #646cff;
}

.search-button {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
}

.search-results {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #eee;
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  z-index: 1000;
  margin-top: 5px;
}

.search-result-item {
  display: block;
  padding: 8px 15px;
  color: #333;
  text-decoration: none;
}

.search-result-item:hover {
  background-color: #f5f5f5;
}
</style>