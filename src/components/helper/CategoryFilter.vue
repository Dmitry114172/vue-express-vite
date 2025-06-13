<template>
  <div class="category-filter">
    <select v-model="selectedCategoryId" @change="onCategoryChange" class="filter-select">
      <option value="">Все категории</option>
      <option 
        v-for="category in categoryStore.categories" 
        :key="category.id" 
        :value="category.id"
      >
        {{ category.name }}
      </option>
    </select>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useCategoryStore } from '@/store/categoryStore';

const router = useRouter();
const categoryStore = useCategoryStore();
const selectedCategoryId = ref('');

onMounted(async () => {
  if (categoryStore.categories.length === 0) {
    await categoryStore.loadAllCategories();
  }
});

const onCategoryChange = () => {
  if (selectedCategoryId.value) {
    router.push(`/category/${selectedCategoryId.value}`);
  } else {
    router.push('/product');
  }
};
</script>

<style scoped>
.category-filter {
  margin: 20px 0;
}

.filter-select {
  padding: 8px 12px;
  border-radius: 4px;
  border: 1px solid #ddd;
  font-size: 16px;
}
</style>