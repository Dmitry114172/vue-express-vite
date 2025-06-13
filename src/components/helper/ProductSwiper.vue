<script setup>
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Pagination } from 'swiper/modules'
import 'swiper/swiper-bundle.css'
import { ref, watch, onMounted } from 'vue'

const modules = [Pagination]
const props = defineProps({
  images: {
    type: Array,
    required: true
  }
})

const resolvedImagePaths = ref([])

const getImagePath = (imageUrl) => {
  if (!imageUrl) return ''
  
  // Если URL уже абсолютный
  if (imageUrl.startsWith('http') || imageUrl.startsWith('/')) {
    return imageUrl
  }
  
  // Для изображений в public/assets/image/
  return `/assets/image/${imageUrl}`
}

onMounted(() => processImages())
watch(() => props.images, () => processImages(), { immediate: true })

function processImages() {
  if (!props.images || !Array.isArray(props.images)) {
    resolvedImagePaths.value = []
    return
  }
  
  resolvedImagePaths.value = props.images
    .filter(img => img?.image_url)
    .map(img => getImagePath(img.image_url))
}

const onSwiper = (swiper) => {
  console.log(swiper)
}

const onSlideChange = () => {
  console.log("slide change")
}
</script>

<template>
  <Swiper
    :modules="modules"
    :slides-per-view="1"
    :pagination="{ clickable: true, dynamicBullets: true }"
    @swiper="onSwiper"
    @slideChange="onSlideChange"
    class="product-swiper"
  >
    <SwiperSlide v-for="(path, index) in resolvedImagePaths" :key="index">
      <img
        :src="path"
        alt="Product Image"
        class="product-swiper__image"
        @error="console.error('Failed to load image:', path)"
      />
    </SwiperSlide>
  </Swiper>
</template>

<style scoped>
.product-swiper {
  max-width: 400px;
  max-height: 100%;
}

.product-swiper__image {
  max-height: 300px;
  width: 100%;
  object-fit: contain;
}

:deep(.swiper-pagination-bullet) {
  width: 8px;
  height: 8px;
  background-color: #ccc;
  opacity: 1;
}

:deep(.swiper-pagination-bullet-active) {
  background-color: #000;
}
</style>