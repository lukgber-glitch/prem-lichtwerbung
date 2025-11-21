<template>
  <div
    class="bg-white rounded-lg shadow-md overflow-hidden transition-all duration-300 hover:shadow-glow-blue flex flex-col h-full group"
  >
    <!-- Image Container with Day/Night Toggle -->
    <router-link :to="`/products/${product.slug}`" class="relative block overflow-hidden bg-brand-gray-light">
      <img
        :src="currentImage"
        :alt="product.name"
        loading="lazy"
        class="w-full h-64 object-cover transition-opacity duration-300"
        @mouseenter="showNightImage = true"
        @mouseleave="showNightImage = false"
      />
      
      <!-- Shimmer overlay on hover -->
      <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
        <div class="animate-shimmer w-full h-full"></div>
      </div>
      
      <!-- Electric sparks in corners -->
      <div class="absolute top-2 left-2 w-2 h-2 bg-brand-blue rounded-full opacity-0 group-hover:opacity-100 animate-spark"></div>
      <div class="absolute top-2 right-2 w-2 h-2 bg-brand-pink rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.3s;"></div>
      <div class="absolute bottom-2 left-2 w-2 h-2 bg-brand-yellow rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.6s;"></div>
      <div class="absolute bottom-2 right-2 w-2 h-2 bg-brand-blue rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.9s;"></div>
      
      <!-- Badges Container -->
      <div class="absolute top-3 left-3 flex flex-col gap-2">
        <!-- Customizable Badge -->
        <span
          v-if="product.customizable"
          class="bg-brand-yellow text-brand-navy px-3 py-1 rounded-full text-xs font-bold uppercase"
        >
          Customizable
        </span>
        
        <!-- Stock Status -->
        <span
          v-if="product.stock <= 5 && product.stock > 0"
          class="bg-orange-500 text-white px-3 py-1 rounded-full text-xs font-bold"
        >
          Only {{ product.stock }} left
        </span>
        <span
          v-else-if="product.stock === 0"
          class="bg-red-500 text-white px-3 py-1 rounded-full text-xs font-bold"
        >
          Out of Stock
        </span>
      </div>

      <!-- Illumination Type Badge -->
      <div class="absolute top-3 right-3">
        <span
          class="bg-brand-navy bg-opacity-90 text-brand-blue px-3 py-1 rounded-full text-xs font-semibold"
        >
          {{ product.illumination_type }}
        </span>
      </div>
    </router-link>

    <!-- Product Info -->
    <div class="p-4 flex flex-col flex-grow">
      <!-- Product Name -->
      <router-link :to="`/products/${product.slug}`" class="hover:text-brand-blue transition-colors">
        <h3 class="font-accent font-bold text-lg mb-2 line-clamp-2">
          {{ productName }}
        </h3>
      </router-link>

      <!-- Description -->
      <p class="text-brand-gray-dark text-sm mb-3 line-clamp-2 flex-grow">
        {{ productDescription }}
      </p>

      <!-- Lead Time -->
      <div class="flex items-center gap-2 mb-3 text-sm text-brand-gray-dark">
        <Clock :size="16" :stroke-width="2" />
        <span>Ready in {{ product.lead_time_days }} days</span>
      </div>

      <!-- Price -->
      <div class="mb-4">
        <div class="flex items-baseline gap-2">
          <span class="text-2xl font-bold text-brand-blue">
            €{{ product.price.toFixed(2) }}
          </span>
          <span
            v-if="product.compare_at_price"
            class="text-sm text-gray-500 line-through"
          >
            €{{ product.compare_at_price.toFixed(2) }}
          </span>
        </div>
        <p v-if="product.compare_at_price" class="text-xs text-green-600 font-semibold mt-1">
          Save €{{ (product.compare_at_price - product.price).toFixed(2) }}
        </p>
      </div>

      <!-- Add to Cart Button -->
      <ButtonGlow
        variant="primary"
        :class="['w-full', { 'animate-glow-pulse': product.stock > 0 }]"
        :disabled="product.stock === 0"
        @click="addToCart"
      >
        {{ product.stock === 0 ? 'Out of Stock' : 'Add to Cart' }}
      </ButtonGlow>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { Clock } from 'lucide-vue-next'
import ButtonGlow from '../ui/ButtonGlow.vue'

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
const showNightImage = ref(false)

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

const addToCart = () => {
  if (props.product.stock > 0) {
    // TODO: Implement add to cart functionality
    console.log('Add to cart:', props.product.id)
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
