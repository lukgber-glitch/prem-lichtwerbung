<template>
  <div
    class="bg-white border border-black/10 overflow-hidden transition-all duration-800 hover:border-black flex flex-col h-full group"
  >
    <!-- Image Container with Day/Night Toggle -->
    <router-link :to="`/products/${product.slug}`" class="relative block overflow-hidden bg-white">
      <img
        :src="currentImage"
        :alt="product.name"
        loading="lazy"
        class="w-full h-64 object-cover transition-all duration-800 group-hover:opacity-90"
        @mouseenter="showNightImage = true"
        @mouseleave="showNightImage = false"
      />
      
      <!-- Minimal Overlay on Hover -->
      <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition-opacity duration-800 pointer-events-none"></div>
      
      <!-- Stock Status Badge - Minimal -->
      <div class="absolute top-4 left-4">
        <span
          v-if="product.stock === 0"
          class="bg-black text-white px-4 py-2 text-xs font-light uppercase tracking-wider"
        >
          Out of Stock
        </span>
      </div>
    </router-link>

    <!-- Product Info -->
    <div class="p-6 flex flex-col flex-grow">
      <!-- Product Name -->
      <router-link :to="`/products/${product.slug}`" class="hover:opacity-60 transition-opacity duration-500">
        <h3 class="font-heading font-semibold text-xl text-black mb-3 leading-tight">
          {{ productName }}
        </h3>
      </router-link>

      <!-- Description -->
      <p class="text-black/60 text-sm font-light mb-4 line-clamp-2 flex-grow leading-relaxed">
        {{ productDescription }}
      </p>

      <!-- Price -->
      <div class="mb-6">
        <div class="flex items-baseline gap-3">
          <span class="text-2xl font-bold text-black">
            €{{ product.price.toFixed(2) }}
          </span>
          <span
            v-if="product.compare_at_price"
            class="text-sm text-black/40 line-through font-light"
          >
            €{{ product.compare_at_price.toFixed(2) }}
          </span>
        </div>
      </div>

      <!-- Action Buttons - Minimal -->
      <div class="flex gap-3">
        <button
          @click="handleAddToCart"
          class="flex-1 px-6 py-3 bg-black text-white text-sm font-semibold border border-black hover:bg-black/80 transition-all duration-500 cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed"
          :disabled="product.stock === 0"
        >
          {{ addedToCart ? '✓ Added' : 'Add to Cart' }}
        </button>
        <button
          @click="$router.push(`/products/${product.slug}`)"
          class="flex-1 px-6 py-3 bg-transparent text-black text-sm font-semibold border border-black hover:bg-black hover:text-white transition-all duration-500 cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed"
          :disabled="product.stock === 0"
        >
          {{ product.stock === 0 ? 'Out of Stock' : 'View Details' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useCart } from '@/composables/useCart'

interface Product {
  id: number
  slug: string
  name: string
  name_de?: string
  description: string
  description_de?: string
  price: number
  compare_at_price?: number
  stock: number
  customizable: boolean
  illumination_type: string
  lead_time_days: number
  day_image?: string
  night_image?: string
}

const props = defineProps<{
  product: Product
}>()

const router = useRouter()
const { locale } = useI18n()
const { addToCart } = useCart()
const showNightImage = ref(false)
const addedToCart = ref(false)

// Locale-aware computed properties
const productName = computed(() => {
  return locale.value === 'de' && props.product.name_de 
    ? props.product.name_de 
    : props.product.name
})

const productDescription = computed(() => {
  return locale.value === 'de' && props.product.description_de 
    ? props.product.description_de 
    : props.product.description
})

const currentImage = computed(() => {
  const directusUrl = 'http://localhost:8055'
  
  // Helper to check if value is UUID and convert to assets URL
  const getImageUrl = (imageValue: string | undefined) => {
    if (!imageValue) return null
    // Check if it's a UUID (format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
    if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(imageValue)) {
      return `${directusUrl}/assets/${imageValue}`
    }
    // Otherwise return as-is (legacy path or URL)
    return imageValue
  }
  
  if (showNightImage.value && props.product.night_image) {
    return getImageUrl(props.product.night_image) || '/placeholder-product.jpg'
  }
  return getImageUrl(props.product.day_image) || '/placeholder-product.jpg'
})

const handleAddToCart = () => {
  if (props.product.stock > 0) {
    addToCart({
      id: props.product.id,
      name: productName.value,
      price: props.product.price,
      image: props.product.day_image,
      slug: props.product.slug
    }, 1)
    
    // Show visual feedback
    addedToCart.value = true
    setTimeout(() => {
      addedToCart.value = false
    }, 2000)
  }
}
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
