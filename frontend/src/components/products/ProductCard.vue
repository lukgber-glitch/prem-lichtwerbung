<template>
  <div
    class="bg-white rounded-lg shadow-md overflow-hidden transition-all duration-300 hover:shadow-glow-blue flex flex-col h-full"
  >
    <!-- Image Container with Day/Night Toggle -->
    <router-link :to="`/products/${product.slug}`" class="relative block overflow-hidden bg-brand-gray-light">
      <img
        :src="currentImage"
        :alt="product.name"
        class="w-full h-64 object-cover transition-opacity duration-300"
        @mouseenter="showNightImage = true"
        @mouseleave="showNightImage = false"
      />
      
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
          {{ product.name }}
        </h3>
      </router-link>

      <!-- Description -->
      <p class="text-brand-gray-dark text-sm mb-3 line-clamp-2 flex-grow">
        {{ product.description }}
      </p>

      <!-- Lead Time -->
      <div class="flex items-center gap-2 mb-3 text-sm text-brand-gray-dark">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
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
        class="w-full"
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
import ButtonGlow from '../ui/ButtonGlow.vue'

interface Product {
  id: number
  slug: string
  name: string
  description: string
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
const showNightImage = ref(false)

const currentImage = computed(() => {
  if (showNightImage.value && props.product.night_image) {
    return props.product.night_image
  }
  return props.product.day_image || '/placeholder-product.jpg'
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
