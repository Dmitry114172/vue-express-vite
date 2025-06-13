<template>
  <button 
    v-if="hasMoreItems" 
    @click="loadMore" 
    class="load-more-btn"
    :disabled="isLoading"
  >
    <span v-if="!isLoading">Показать ещё</span>
    <span v-else>Загрузка...</span>
  </button>
</template>

<script setup>
const props = defineProps({
  hasMoreItems: {
    type: Boolean,
    required: true
  },
  isLoading: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['load-more'])

const loadMore = () => {
  emit('load-more')
}
</script>

<style scoped>
.load-more-btn {
  display: block;
  margin: 20px auto;
  padding: 10px 20px;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

.load-more-btn:hover {
  background-color: #3aa876;
}

.load-more-btn:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}
</style>