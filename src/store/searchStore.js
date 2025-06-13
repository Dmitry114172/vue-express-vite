import { defineStore } from 'pinia';
import { fetchGoods } from '@/controller/apiController';

export const useSearchStore = defineStore('search', {
  state: () => ({
    searchQuery: '',
    searchResults: [],
    isLoading: false,
    error: null
  }),
  actions: {
    async searchProducts(query) {
      try {
        this.searchQuery = query;
        this.isLoading = true;
        this.error = null;

        if (query.length < 2) {
          this.searchResults = [];
          return;
        }

        const allProducts = await fetchGoods();
        this.searchResults = allProducts
          .filter(product => 
            product?.title?.toLowerCase().includes(query.toLowerCase())
          )
          .slice(0, 5);
      } catch (error) {
        this.error = error;
        console.error('Search error:', error);
        this.searchResults = [];
      } finally {
        this.isLoading = false;
      }
    },
    clearResults() {
      this.searchResults = [];
    }
  }
});