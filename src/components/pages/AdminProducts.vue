<template>
  <div class="admin-panel container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Административная панель</h2>
      <div>
        <button class="btn btn-primary me-2" @click="openAddModal">Добавить товар</button>
        <button class="btn btn-danger" @click="logout">Выйти</button>
      </div>
    </div>

    <!-- Модальное окно для добавления/редактирования товара -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ editingProduct ? 'Редактировать товар' : 'Добавить новый товар' }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="resetForm"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Название товара*</label>
              <input v-model="currentProduct.title" class="form-control" placeholder="Название товара" required />
            </div>
            <div class="mb-3">
              <label class="form-label">Производитель*</label>
              <input v-model="currentProduct.vendor" class="form-control" placeholder="Производитель" required />
            </div>
            <div class="mb-3">
              <label class="form-label">Цена*</label>
              <input v-model.number="currentProduct.price" type="number" class="form-control" placeholder="Цена" required />
            </div>
            <div class="mb-3">
              <label class="form-label">Категория*</label>
              <select v-model.number="currentProduct.category_id" class="form-select" required>
                <option v-for="category in categories" :key="category.id" :value="category.id">
                  {{ category.name }}
                </option>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Краткое описание</label>
              <textarea v-model="currentProduct.short_description" class="form-control" placeholder="Краткое описание"></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">Описание</label>
              <textarea v-model="currentProduct.description" class="form-control" placeholder="Описание"></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">Изображения</label>
              <input type="file" class="form-control" @change="handleFileChange" multiple accept="image/*" />
              <div class="mt-3">
                <div class="d-flex flex-wrap gap-2">
                  <!-- Существующие изображения -->
                  <div v-for="(image, index) in currentProduct.images" :key="'existing-'+index" 
                       class="position-relative" style="width: 100px; height: 100px;">
                    <img :src="getImagePath(image.image_url)" alt="Превью" class="img-thumbnail h-100 w-100 object-fit-cover" />
                    <button @click="removeExistingImage(index)" 
                            class="position-absolute top-0 end-0 btn btn-sm btn-danger p-0" 
                            style="width: 20px; height: 20px; transform: translate(30%, -30%);">
                      &times;
                    </button>
                  </div>
                  <!-- Новые загруженные изображения -->
                  <div v-for="(preview, index) in newImagePreviews" :key="'new-'+index" 
                       class="position-relative" style="width: 100px; height: 100px;">
                    <img :src="preview" alt="Превью" class="img-thumbnail h-100 w-100 object-fit-cover" />
                    <button @click="removeNewImage(index)" 
                            class="position-absolute top-0 end-0 btn btn-sm btn-danger p-0" 
                            style="width: 20px; height: 20px; transform: translate(30%, -30%);">
                      &times;
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="resetForm">Отмена</button>
            <button type="button" class="btn btn-primary" @click="saveProduct">
              {{ editingProduct ? 'Обновить товар' : 'Добавить товар' }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Список товаров -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
      <div v-for="product in products" :key="product.id" class="col">
        <div class="card h-100">
          <div class="product-images" style="height: 200px;">
            <ProductSwiper :images="product.images" />
          </div>
          <div class="card-body">
            <h5 class="card-title">{{ product.title }}</h5>
            <p class="card-text text-muted">{{ product.vendor }}</p>
            <p class="card-text fw-bold">{{ formatPrice(product.price) }} ₽</p>
            <p class="card-text" v-if="getCategoryName(product.category_id)">
              <small class="text-muted">Категория: {{ getCategoryName(product.category_id) }}</small>
            </p>
          </div>
          <div class="card-footer bg-transparent">
            <div class="d-flex justify-content-between">
              <button @click="editProduct(product)" class="btn btn-sm btn-outline-primary">Редактировать</button>
              <button @click="confirmDelete(product.id)" class="btn btn-sm btn-outline-danger">Удалить</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { Modal } from 'bootstrap';
import ProductSwiper from '@/components/helper/ProductSwiper.vue';
import { 
  fetchGoods, 
  fetchProduct, 
  addProduct, 
  updateProduct, 
  deleteProduct, 
  deleteProductImage, 
  fetchCategories 
} from '@/controller/apiController';

const router = useRouter();
let productModal = null;

// Состояние
const products = ref([]);
const categories = ref([]);
const currentProduct = ref(createEmptyProduct());
const editingProduct = ref(false);
const selectedFiles = ref([]);
const newImagePreviews = ref([]);
const removedImages = ref([]);

// Инициализация модального окна
onMounted(async () => {
  const user = JSON.parse(localStorage.getItem('user'));
  if (!user || user.role !== 'admin') {
    router.push('/login');
    return;
  }
  productModal = new Modal(document.getElementById('productModal'));
  await loadData();
});

// Форматирование цены
const formatPrice = (price) => {
  return new Intl.NumberFormat('ru-RU').format(price);
};

// Создание пустого продукта
function createEmptyProduct() {
  return {
    title: '',
    vendor: '',
    price: 0,
    short_description: '',
    description: '',
    category_id: 1,
    images: []
  };
}

// Получение названия категории
const getCategoryName = (categoryId) => {
  const category = categories.value.find(c => c.id === categoryId);
  return category ? category.name : '';
};

// Загрузка данных
const loadData = async () => {
  try {
    products.value = await fetchGoods();
    categories.value = await fetchCategories();
  } catch (error) {
    console.error('Ошибка загрузки данных:', error);
    alert('Ошибка загрузки данных');
  }
};

// Открытие модального окна для добавления товара
const openAddModal = () => {
  resetForm();
  productModal.show();
};

// Обработка файлов
const handleFileChange = (event) => {
  const files = Array.from(event.target.files);
  
  // Очищаем предыдущие превью
  cleanupImagePreviews();
  
  // Создаем новые превью
  newImagePreviews.value = files.map(file => URL.createObjectURL(file));
  selectedFiles.value = files;
};

// Удаление нового изображения
const removeNewImage = (index) => {
  URL.revokeObjectURL(newImagePreviews.value[index]);
  newImagePreviews.value.splice(index, 1);
  selectedFiles.value.splice(index, 1);
};

// Удаление существующего изображения
const removeExistingImage = async (index) => {
  const imageName = currentProduct.value.images[index].image_url;
  try {
    if (editingProduct.value) {
      await deleteProductImage(currentProduct.value.id, imageName);
    }
    removedImages.value.push(imageName);
    currentProduct.value.images.splice(index, 1);
  } catch (error) {
    console.error('Ошибка при удалении изображения:', error);
    alert('Ошибка при удалении изображения');
  }
};

// Очистка превью изображений
const cleanupImagePreviews = () => {
  newImagePreviews.value.forEach(preview => {
    URL.revokeObjectURL(preview);
  });
  newImagePreviews.value = [];
};

// Редактирование продукта
const editProduct = async (product) => {
  try {
    const fullProduct = await fetchProduct(product.id);
    currentProduct.value = { 
      ...fullProduct,
      images: [...fullProduct.images]
    };
    editingProduct.value = true;
    removedImages.value = [];
    selectedFiles.value = [];
    newImagePreviews.value = [];
    productModal.show();
  } catch (error) {
    console.error('Ошибка загрузки данных товара:', error);
    alert('Ошибка загрузки данных товара');
  }
};

// Сохранение продукта
const saveProduct = async () => {
  if (!currentProduct.value.title || !currentProduct.value.vendor || 
      !currentProduct.value.price || !currentProduct.value.category_id) {
    alert('Заполните обязательные поля (помечены *)');
    return;
  }
  
  const formData = new FormData();
  
  // Добавляем поля продукта
  Object.entries(currentProduct.value).forEach(([key, value]) => {
    if (key !== 'images' && value !== null) {
      formData.append(key, value);
    }
  });
  
  // Добавляем новые изображения
  selectedFiles.value.forEach(file => {
    formData.append('images', file);
  });
  
  // Добавляем имена удаленных изображений
  if (removedImages.value.length > 0) {
    formData.append('removedImages', JSON.stringify(removedImages.value));
  }
  
  try {
    if (editingProduct.value) {
      await updateProduct(currentProduct.value.id, formData);
      alert('Товар успешно обновлен');
    } else {
      await addProduct(formData);
      alert('Товар успешно добавлен');
    }
    await loadData();
    resetForm();
    productModal.hide();
  } catch (error) {
    console.error('Ошибка сохранения товара:', error);
    alert('Ошибка сохранения товара: ' + error.message);
  }
};

// Подтверждение удаления
const confirmDelete = (productId) => {
  if (confirm('Вы уверены, что хотите удалить этот товар?')) {
    deleteProductHandler(productId);
  }
};

// Удаление продукта
const deleteProductHandler = async (productId) => {
  try {
    await deleteProduct(productId);
    await loadData();
    alert('Товар успешно удален');
  } catch (error) {
    console.error('Ошибка удаления товара:', error);
    alert('Ошибка удаления товара');
  }
};

// Сброс формы
const resetForm = () => {
  cleanupImagePreviews();
  currentProduct.value = createEmptyProduct();
  selectedFiles.value = [];
  removedImages.value = [];
  editingProduct.value = false;
};

// Получение полного пути к изображению
const getImagePath = (imageUrl) => {
  if (!imageUrl) return '';
  if (imageUrl.startsWith('http') || imageUrl.startsWith('/')) {
    return imageUrl;
  }
  return `/assets/image/${imageUrl}`;
};

// Выход из системы
const logout = () => {
  localStorage.removeItem('authToken');
  localStorage.removeItem('user');
  router.push('/login');
};
</script>

<style scoped>
.product-images {
  overflow: hidden;
}
.object-fit-cover {
  object-fit: cover;
}
</style>