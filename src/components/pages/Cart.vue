<template>
  <main class="content container">
    <div class="content__top">
      <ul class="breadcrumbs">
        <li class="breadcrumbs__item">
          <router-link class="breadcrumbs__link" to="/Product">Каталог</router-link>
          <span> / </span>
        </li>
        <li class="breadcrumbs__item">
          <span class="breadcrumbs__link">Корзина</span>
        </li>
      </ul>
      <h1 class="content__title">Корзина</h1>
      <span class="content__info">Всего товаров: {{ cartStore.count }}</span>
    </div>

    <section class="cart">
      <div v-if="cartStore.items.length === 0" class="cart__empty">
        <p>Ваша корзина пуста</p>
        <router-link to="/product" class="button button--primary">
          Вернуться к покупкам
        </router-link>
      </div>

      <template v-else>
        <ul class="cart__list">
          <li v-for="item in cartStore.items" :key="item.id" class="cart__item product">
            <div class="product__pic">
              <ProductSwiper 
                :images="item.images || [{ image_url: item.image }]" 
                :show-pagination="false"
              />
            </div>
            
            <div class="product__info">
              <h3 class="product__title">{{ item.title }}</h3>
              <p class="product__price">Цена: {{ formatPrice(item.price) }} ₽</p>
              
              <div class="product__counter form__counter">
                <button 
                  type="button" 
                  @click="cartStore.decrementItem(item.id)"
                  aria-label="Уменьшить количество"
                >
                  -
                </button>
                <input 
                  type="text" 
                  :value="item.quantity" 
                  readonly
                  aria-label="Количество товара"
                >
                <button 
                  type="button" 
                  @click="cartStore.incrementItem(item.id)"
                  aria-label="Увеличить количество"
                >
                  +
                </button>
              </div>
            </div>

            <div class="product__total">
              <b class="product__price-total">
                {{ formatPrice(item.price * item.quantity) }} ₽
              </b>
              <button 
                class="product__del button-del" 
                type="button" 
                @click="cartStore.removeFromCart(item.id)"
                aria-label="Удалить товар"
              >
                Удалить
              </button>
            </div>
          </li>
        </ul>

        <div class="cart__block">
          <p class="cart__desc">
            Мы посчитаем стоимость доставки на следующем этапе
          </p>
          <p class="cart__price">
            Итого: <span>{{ formatPrice(cartStore.totalPrice) }} ₽</span>
          </p>
          <button 
            class="cart__button button button--primary" 
            type="button" 
            @click="checkout"
          >
            Оформить заказ
          </button>
        </div>
      </template>
    </section>
  </main>
</template>

<script setup>
import { useCartStore } from '@/store/cartStore';
import ProductSwiper from '@/components/helper/ProductSwiper.vue';

const cartStore = useCartStore();

const formatPrice = (price) => {
  return new Intl.NumberFormat('ru-RU').format(price);
};

const checkout = () => {
  console.log('Оформление заказа:', cartStore.items);
  alert('Заказ оформлен!');
  cartStore.clearCart();
};
</script>

<style scoped>
.content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.content__top {
  margin-bottom: 30px;
}
.product__pic {
height: 100px;
}
.breadcrumbs {
  list-style: none;
  padding: 0;
  margin: 0 0 20px 0;
  display: flex;
  align-items: center;
  font-size: 14px;
}

.breadcrumbs__item {
  display: flex;
  align-items: center;
}

.breadcrumbs__link {
  color: #2e3cfa;
  text-decoration: none;
}

.breadcrumbs__link:hover {
  text-decoration: underline;
}

.content__title {
  font-size: 28px;
  margin: 0 0 10px 0;
}

.content__info {
  color: #666;
  font-size: 16px;
}

.cart__list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.cart__item {
  display: grid;
  grid-template-columns: 120px 1fr auto;
  gap: 20px;
  align-items: center;
  padding: 20px 0;
  border-bottom: 1px solid #eee;
}

.product__pic {
  
  height: 200px;
  overflow: hidden;
  border-radius: 4px;
}

.product__info {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.product__title {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
}

.product__price {
  margin: 0;
  color: #333;
  font-size: 16px;
}

.product__counter {
  display: flex;
  align-items: center;
  gap: 5px;
  margin-top: 10px;
}

.product__counter button {
  width: 30px;
  height: 30px;
  background: #2e3cfa;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.product__counter input {
  width: 40px;
  height: 30px;
  text-align: center;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.product__total {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 10px;
}

.product__price-total {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.product__del {
  background-color: #f44336;
  border: none;
  color: white;
  cursor: pointer;
  padding: 5px 15px;
  border-radius: 4px;
  font-size: 14px;
  transition: background-color 0.2s;
}

.product__del:hover {
  background-color: #d32f2f;
}

.cart__block {
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #eee;
  text-align: right;
}

.cart__desc {
  margin: 0 0 10px 0;
  color: #666;
  font-size: 14px;
}

.cart__price {
  margin: 0;
  font-size: 18px;
}

.cart__price span {
  font-weight: 600;
  font-size: 22px;
  color: #2e3cfa;
}

.cart__button {
  margin-top: 20px;
  padding: 12px 24px;
  color: white;
  background-color: #2e3cfa;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.cart__button:hover {
  background-color: #1a27c9;
}

.cart__empty {
  text-align: center;
  padding: 40px 0;
}

.cart__empty p {
  font-size: 18px;
  margin-bottom: 20px;
  color: #666;
}

.button--primary {
  display: inline-block;
  padding: 10px 20px;
  background-color: #2e3cfa;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.button--primary:hover {
  background-color: #1a27c9;
}
</style>