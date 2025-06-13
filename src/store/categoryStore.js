// src/store/categoryStore.js
import { defineStore } from 'pinia';
import { fetchCategories, fetchCategory } from '@/controller/apiController';

export const useCategoryStore = defineStore('category', {
  state: () => ({
    categories: [],
    selectedCategory: null,
    isLoading: false,
    error: null
  }),
  actions: {
    async loadAllCategories() {
      this.isLoading = true;
      this.error = null;
      try {
        this.categories = await fetchCategories();
      } catch (error) {
        this.error = error;
        console.error('Ошибка загрузки категорий:', error);
        this.categories = [];
      } finally {
        this.isLoading = false;
      }
    },
    async loadCategoryById(categoryId) {
      this.isLoading = true;
      this.error = null;
      try {
        this.selectedCategory = await fetchCategory(categoryId);
      } catch (error) {
        this.error = error;
        console.error('Ошибка загрузки категории:', error);
        this.selectedCategory = null;
      } finally {
        this.isLoading = false;
      }
    },
    resetSelectedCategory() {
      this.selectedCategory = null;
    }
  },
  getters: {
    hasCategories: (state) => state.categories.length > 0,
    selectedCategoryName: (state) => state.selectedCategory?.name || ''
  }
});