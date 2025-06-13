vue
<template>
  <div>
    <Header  />
    <router-view />
  </div>
</template>
<script>
import { ref, onMounted } from 'vue';
import Header from './components/pages/Header.vue';
export default {
  name: 'App',
  components: {
    Header
  },
  setup() {
    const categories = ref([]);
    // Удаляем функцию fetchCategories из App.vue, если она уже есть в Header.vue
    return {
      categories
    };
  }
};
</script>