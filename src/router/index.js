import LoginPage from '@/components/pages/LoginPage.vue';
import ProductList from '@/components/pages/ProductList.vue';
import Registration from "@/components/pages/Registration.vue";
import AdminDashboard from '@/components/pages/AdminDashboard.vue';
import ProductPage from '@/components/pages/ProductPage.vue';
import CategoriesPage from '@/components/pages/CategoriesPage.vue';
import AdminProducts from '@/components/pages/AdminProducts.vue';
import CategoryGoods from '@/components/pages/CategoryGoods.vue'; // Импортируем компонент CategoryGoods
import Home from '@/components/pages/Home.vue';
import Cart from '@/components/pages/Cart.vue';
import UserProfile from '@/components/pages/UserProfile.vue';
// Функция для проверки авторизации
const isAuthenticated = () => {
  const user = JSON.parse(localStorage.getItem('user')); // Предполагается, что информация о пользователе хранится в localStorage
  return user && user.role === 'admin'; // Проверяем, есть ли у пользователя роль администратора
};
const routes = [
    {
    path: '/',
    redirect: '/Home' // или component: Home
  },
  {
    path: '/Home',
    name: 'Home',
    component: Home,
  },
  {
    path: '/product',
    name: 'ProductList',
    component: ProductList,
  },
  {
    path: '/register',
    name: 'Register',
    component: Registration,
  },
  {
    path: '/login',
    name: 'LoginPage',
    component: LoginPage,
  },
  {
    path: '/product/:id',
    name: 'ProductPage',
    component: ProductPage,
  },
  {
    path: '/category/:id',
    name: 'CategoryGoods',
    component: CategoryGoods
  },
   {
    path: '/cart',
    name: 'Cart',
    component: Cart,
  },
  {
    path: '/admin',
    name: 'AdminDashboard',
    component: AdminDashboard,
    beforeEnter: (to, from, next) => {
      if (isAuthenticated()) {
        next(); // Если пользователь авторизован как администратор, продолжаем
      } else {
        next({ name: 'LoginPage' }); // Иначе перенаправляем на страницу входа
      }
    },
  },
    {
    path: '/admin/adminproducts',
    name: 'AdminProducts',
    component: AdminProducts,
  },
  {
    path: '/profile',
    name: 'UserProfile',
    component: UserProfile,
    meta: { requiresAuth: true }
  },
];
export default routes;