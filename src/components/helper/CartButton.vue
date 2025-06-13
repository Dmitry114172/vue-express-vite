vue
<template>
  <button class="basket" @click="addToCart" :disabled="isInCart">
    {{ isInCart ? 'В корзине' : 'В корзину' }}
  </button>
</template>
<script setup>
import { useCartStore } from '../../store/cartStore';
import { ref, watch } from 'vue';
// Получаем свойства от родительского компонента
const props = defineProps({
  item: {
    type: Object,
    required: true,
  },
});
// Используем хранилище корзины
const cartStore = useCartStore();
// Локальное состояние для отслеживания, находится ли товар в корзине
const isInCart = ref(false);
// Метод для добавления товара в корзину
const addToCart = () => {
  cartStore.addToCart(props.item);
  isInCart.value = true; // Устанавливаем, что товар в корзине
};
// Проверяем, находится ли товар в корзине при инициализации
watch(() => cartStore.items, (newItems) => {
  isInCart.value = newItems.some(item => item.id === props.item.id);
});
</script>
<style scoped>
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
.basket:hover {
  background-color: #1215f3; 
}
.basket:disabled {
  background-color: #ccc; /* Цвет для отключенной кнопки */
  cursor: not-allowed; /* Изменение курсора для отключенной кнопки */
}
</style>
