// src/store/cartStore.js
import { defineStore } from 'pinia';
import { ref, computed } from 'vue';

const CART_KEY = 'cart';

export const useCartStore = defineStore('cart', () => {
  // Используем ref вместо reactive для массива товаров
  const items = ref(JSON.parse(localStorage.getItem(CART_KEY)) || []);

  // Сохранение корзины в localStorage
  const saveCart = () => {
    localStorage.setItem(CART_KEY, JSON.stringify(items.value));
  };

  // Добавление товара в корзину
  const addToCart = (product) => {
    const existingItem = items.value.find(item => item.id === product.id);
    
    if (existingItem) {
      existingItem.quantity += 1;
    } else {
      items.value.push({
        ...product,
        quantity: 1
      });
    }
    
    saveCart();
  };

  // Удаление товара из корзины
  const removeFromCart = (productId) => {
    items.value = items.value.filter(item => item.id !== productId);
    saveCart();
  };

  // Увеличение количества товара
  const incrementItem = (productId) => {
    const item = items.value.find(item => item.id === productId);
    if (item) {
      item.quantity += 1;
      saveCart();
    }
  };

  // Уменьшение количества товара
  const decrementItem = (productId) => {
    const item = items.value.find(item => item.id === productId);
    if (item) {
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        removeFromCart(productId);
      }
      saveCart();
    }
  };

  // Очистка корзины
  const clearCart = () => {
    items.value = [];
    localStorage.removeItem(CART_KEY);
  };

  // Общее количество товаров (computed)
  const count = computed(() => {
    return items.value.reduce((total, item) => total + item.quantity, 0);
  });

  // Общая стоимость (computed)
  const totalPrice = computed(() => {
    return items.value.reduce((sum, item) => sum + (item.price * item.quantity), 0);
  });

  return {
    items,
    count,
    totalPrice,
    addToCart,
    removeFromCart,
    incrementItem,
    decrementItem,
    clearCart
  };
});