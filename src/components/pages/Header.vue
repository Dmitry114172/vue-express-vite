<template>
  <header class="bg-light shadow-sm sticky-top">
    <div class="container">
      <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
          <router-link class="navbar-brand fw-bold fs-3" to="/Home">Магазин</router-link>
          
          <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNav"
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="navbar-toggler-icon"></span>
          </button>
          
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
              <li class="nav-item">
                <router-link class="nav-link" active-class="active" to="/Home">
                  <i class="bi bi-house-door me-1"></i>Главная
                </router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" active-class="active" to="/product">
                  <i class="bi bi-box-seam me-1"></i>Товары
                </router-link>
              </li>
              <li class="nav-item dropdown">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <i class="bi bi-list-ul me-1"></i>Каталог
                </a>
                <ul class="dropdown-menu">
                  <li v-if="categoryStore.categories.length">
                    <router-link
                      v-for="category in categoryStore.categories"
                      :key="category.id"
                      class="dropdown-item"
                      :to="`/category/${category.id}`"
                    >
                      <i class="bi bi-tag me-2"></i>{{ category.name }}
                    </router-link>
                  </li>
                  <li v-else>
                    <span class="dropdown-item text-muted">
                      <i class="bi bi-exclamation-circle me-2"></i>Нет категорий
                    </span>
                  </li>
                </ul>
              </li>
            </ul>
            
            <div class="d-flex align-items-center">
              <ProductFilter class="me-3" />
              
              <div class="position-relative me-3">
                <router-link to="/cart" class="btn btn-outline-dark position-relative">
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                    <path d="M6 2L3 6V20C3 20.5304 3.21071 21.0391 3.58579 21.4142C3.96086 21.7893 4.46957 22 5 22H19C19.5304 22 20.0391 21.7893 20.4142 21.4142C20.7893 21.0391 21 20.5304 21 20V6L18 2H6Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M3 6H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M16 10C16 11.0609 15.5786 12.0783 14.8284 12.8284C14.0783 13.5786 13.0609 14 12 14C10.9391 14 9.92172 13.5786 9.17157 12.8284C8.42143 12.0783 8 11.0609 8 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  <span 
                    v-if="cartStore.count > 0"
                    class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary"
                  >
                    {{ cartStore.count }}
                  </span>
                </router-link>
              </div>
              
              <div class="dropdown">
                <a
                  class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center"
                  href="#"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                    <path d="M20 21V19C20 17.9391 19.5786 16.9217 18.8284 16.1716C18.0783 15.4214 17.0609 15 16 15H8C6.93913 15 5.92172 15.4214 5.17157 16.1716C4.42143 16.9217 4 17.9391 4 19V21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  <template v-if="userStore.user">
                    <span class="d-none d-lg-inline">{{ userStore.user.username }}</span>
                  </template>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                  <template v-if="userStore.user">
                    <li v-if="userStore.user.role === 'admin'">
                      <router-link class="dropdown-item" to="/admin">
                        <i class="bi bi-speedometer2 me-2"></i>Админ панель
                      </router-link>
                    </li>
                    <li>
                      <router-link class="dropdown-item" to="/profile">
                        <i class="bi bi-person me-2"></i>Профиль
                      </router-link>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                      <button class="dropdown-item text-danger" @click="logout">
                        <i class="bi bi-box-arrow-right me-2"></i>Выйти
                      </button>
                    </li>
                  </template>
                  <template v-else>
                    <li>
                      <router-link class="dropdown-item" to="/login">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Войти
                      </router-link>
                    </li>
                    <li>
                      <router-link class="dropdown-item" to="/register">
                        <i class="bi bi-person-plus me-2"></i>Регистрация
                      </router-link>
                    </li>
                  </template>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </nav>
    </div>
  </header>
</template>
<script setup>
import { onMounted } from "vue";
import { useCategoryStore } from "@/store/categoryStore";
import { useCartStore } from "@/store/cartStore";
import { useUserStore } from "@/store/userStore";
import { useRouter } from 'vue-router';
import ProductFilter from '@/components/helper/ProductFilter.vue';

const categoryStore = useCategoryStore();
const cartStore = useCartStore();
const userStore = useUserStore();
const router = useRouter();

const logout = () => {
  userStore.logout();
  router.push('/login');
};

onMounted(async () => {
  await categoryStore.loadAllCategories();
});
</script>

<style scoped>
.navbar {
  padding: 1rem 0;
}

.navbar-brand {
  color: var(--bs-primary);
}

.nav-link {
  font-weight: 500;
  display: flex;
  align-items: center;
}

.nav-link.active {
  color: var(--bs-primary) !important;
  font-weight: 600;
}

.dropdown-menu {
  min-width: 200px;
}

.badge {
  font-size: 0.7rem;
  padding: 0.25rem 0.4rem;
}

/* Улучшаем внешний вид иконок */
.bi {
  vertical-align: middle;
}
</style>