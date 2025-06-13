<template>
  <div class="container-fluid px-4" style="max-width: 1770px;">
    <div v-if="categoryStore.isLoading" class="loading text-center py-5">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Загрузка...</span>
      </div>
    </div>
    <div v-else-if="categoryStore.error" class="error alert alert-danger text-center">
      Ошибка: {{ categoryStore.error.message }}
    </div>
    <template v-else>
      <h1 class="mb-4 text-center">Товары в категории: {{ categoryStore.selectedCategoryName }}</h1>
      
      <div v-if="goods.length === 0" class="empty-category alert alert-info text-center">
        В этой категории пока нет товаров
      </div>
      <template v-else>
        <div class="row g-4">
          <div 
            v-for="item in visibleGoods" 
            :key="item.id" 
            class="col-12 col-sm-6 col-md-4 col-lg-3"
          >
            <div class="card h-100 border-0">
              <div class="image-container">
                <ProductSwiper 
                  :images="item.images || []" 
                  class="card-img-top img-fluid w-100"
                />
              </div>
              
              <div class="card-body d-flex flex-column p-3">
                <router-link 
                  :to="{ name: 'ProductPage', params: { id: item.id } }"
                  class="text-decoration-none text-dark"
                >
                  <h2 class="card-title fs-6 fw-normal mb-2 line-clamp-2">
                    {{ item.title }} <span class="text-muted" v-if="item.vendor">({{ item.vendor }})</span>
                  </h2>
                </router-link>
                
                <div class="mt-auto pt-2">
                  <p class="card-text text-danger fw-bold mb-2" v-if="item.price">
                    {{ formatPrice(item.price) }} ₽
                  </p>
                  
                  <CartButton :item="item" class="w-100" />
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div v-if="hasMoreGoods" class="text-center mt-4">
          <button 
            @click="loadMore"
            class="btn btn-outline-primary px-4 py-2"
            :disabled="isLoading"
          >
            <span v-if="!isLoading">Показать еще</span>
            <span v-else class="spinner-border spinner-border-sm"></span>
          </button>
        </div>
      </template>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { useRoute } from 'vue-router';
import { useCategoryStore } from '@/store/categoryStore';
import ProductSwiper from "@/components/helper/ProductSwiper.vue";
import CartButton from '@/components/helper/CartButton.vue';
import { fetchGoods } from "@/controller/apiController";

const route = useRoute();
const categoryStore = useCategoryStore();
const goods = ref([]);
const visibleCount = ref(8);
const isLoading = ref(false);
const error = ref(null);

// Загрузка товаров при изменении категории
watch(() => route.params.id, async (categoryId) => {
  try {
    isLoading.value = true;
    error.value = null;
    
    if (categoryId) {
      await categoryStore.loadCategoryById(categoryId);
      goods.value = await fetchGoods(categoryId);
    } else {
      categoryStore.resetSelectedCategory();
      goods.value = [];
    }
    
    visibleCount.value = 8; // Сброс счетчика при смене категории
  } catch (err) {
    error.value = err;
    console.error('Ошибка при загрузке товаров:', err);
  } finally {
    isLoading.value = false;
  }
}, { immediate: true });

const visibleGoods = computed(() => goods.value.slice(0, visibleCount.value));
const hasMoreGoods = computed(() => visibleCount.value < goods.value.length);

const loadMore = () => {
  isLoading.value = true;
  setTimeout(() => {
    visibleCount.value += 8;
    isLoading.value = false;
  }, 300);
};

const formatPrice = (price) => {
  return price ? price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ') : '0';
};
</script>

<style scoped>
.image-container {
  width: 100%;
  aspect-ratio: 1/1;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
  overflow: hidden;
}

.card-img-top {
  object-fit: contain;
  height: 100%;
  width: 100%;
  padding: 15px;
}

.line-clamp-2 {
  display: -webkit-box;
  
  -webkit-box-orient: vertical;
  overflow: hidden;
  min-height: 2.8em;
}

.card {
  transition: all 0.3s ease;
  background: #fff;
  border-radius: 8px !important;
  overflow: hidden;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.card-body {
  border-top: 1px solid #eee;
}

.loading {
  min-height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>