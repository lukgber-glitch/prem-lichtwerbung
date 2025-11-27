<template>
  <div class="min-h-screen bg-white">
    <!-- Hero Section -->
    <section class="bg-dark-bg text-white relative overflow-hidden">
      <div class="max-w-content mx-auto px-6 py-32 md:py-40">
        <div class="text-center">
          <h1 class="text-6xl md:text-7xl font-bold mb-8">{{ pageContent?.hero?.title }}</h1>
          <p class="text-xl md:text-2xl font-light max-w-3xl mx-auto">
            {{ pageContent?.hero?.subtitle }}
          </p>
        </div>
      </div>
    </section>

    <!-- Filters Section -->
    <section class="py-20 bg-light-bg border-b border-gray-200">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-2xl font-bold uppercase tracking-wide mb-12 text-gray-900">{{ pageContent?.filters?.filterProducts }}</h2>

        <!-- Category Filter -->
        <div class="mb-8">
          <h3 class="text-sm font-medium text-gray-700 mb-4 uppercase tracking-wider">{{ pageContent?.filters?.category }}</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="category in categories" 
              :key="category.value"
              @click="selectedCategory = category.value"
              class="px-6 py-3 text-sm font-medium border transition-all duration-500 cursor-pointer"
              :class="selectedCategory === category.value 
                ? 'bg-primary text-white border-primary' 
                : 'bg-transparent text-gray-900 border-gray-300 hover:border-primary'"
            >
              {{ t(category.label) }}
            </button>
          </div>
        </div>

        <!-- Illumination Type Filter -->
        <div class="mb-8">
          <h3 class="text-sm font-medium text-gray-700 mb-4 uppercase tracking-wider">{{ pageContent?.filters?.illumination }}</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="type in illuminationTypes" 
              :key="type.value"
              @click="selectedIllumination = type.value"
              class="px-6 py-3 text-sm font-medium border transition-all duration-500 cursor-pointer"
              :class="selectedIllumination === type.value 
                ? 'bg-primary text-white border-primary' 
                : 'bg-transparent text-gray-900 border-gray-300 hover:border-primary'"
            >
              {{ t(type.label) }}
            </button>
          </div>
        </div>

        <!-- Price Range Filter -->
        <div class="mb-8">
          <h3 class="text-sm font-medium text-gray-700 mb-4 uppercase tracking-wider">{{ pageContent?.filters?.priceRange }}</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="range in priceRanges" 
              :key="range.label"
              @click="selectedPriceRange = range"
              class="px-6 py-3 text-sm font-medium border transition-all duration-500 cursor-pointer"
              :class="selectedPriceRange === range 
                ? 'bg-primary text-white border-primary' 
                : 'bg-transparent text-gray-900 border-gray-300 hover:border-primary'"
            >
              {{ t(range.label) }}
            </button>
          </div>
        </div>

        <!-- Results Count -->
        <div class="text-sm text-gray-700">
          {{ filteredProducts.length }} {{ filteredProducts.length === 1 ? t('products.productFound') : t('products.productsFound') }}
        </div>
      </div>
    </section>

    <!-- Products Grid -->
    <section class="py-20 bg-white">
      <div class="max-w-content mx-auto px-6">
        <!-- Loading State -->
        <div v-if="loading" class="text-center py-20">
          <div class="text-xl text-gray-900">{{ pageContent?.messages?.loading }}</div>
        </div>

        <!-- Error State -->
        <div v-else-if="error" class="text-center py-20">
          <div class="text-xl text-gray-900">{{ error }}</div>
        </div>

        <!-- Empty State -->
        <div v-else-if="filteredProducts.length === 0" class="text-center py-20">
          <p class="text-xl text-gray-900 mb-8">{{ pageContent?.messages?.noProductsMatchFilters }}</p>
          <button 
            @click="resetFilters"
            class="px-12 py-4 border-2 border-primary bg-primary text-white hover:bg-primary-dark transition-all duration-500 font-medium"
          >
            {{ pageContent?.messages?.resetFilters }}
          </button>
        </div>

        <!-- Products Grid -->
        <div v-else class="grid md:grid-cols-2 lg:grid-cols-3 gap-12">
          <ProductCard 
            v-for="product in filteredProducts" 
            :key="product.id"
            :product="product"
          />
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { usePageContent } from '@/composables/usePageContent'
import ProductCard from '@/components/products/ProductCard.vue'

const { t } = useI18n()
const { content: pageContent, loading: pageLoading, error: pageError } = usePageContent('products')

const products = ref<any[]>([])
const loading = ref(true)
const error = ref('')

// Filter options
const categories = [
  { value: 'All', label: 'products.all' },
  { value: 'Lightboxes', label: 'products.lightboxes' },
  { value: 'Channel Letters', label: 'products.channelLetters' },
  { value: 'Neon', label: 'products.neon' },
  { value: 'Pylons', label: 'products.pylons' },
  { value: 'Windows', label: 'products.windows' },
  { value: 'Terminal', label: 'products.terminal' }
]

const illuminationTypes = [
  { value: 'All', label: 'products.all' },
  { value: 'LED', label: 'products.led' },
  { value: 'Neon', label: 'products.neon' }
]

const priceRanges = [
  { label: 'products.priceAll', min: 0, max: Infinity },
  { label: 'products.priceLow', min: 0, max: 500 },
  { label: 'products.priceMid', min: 500, max: 1000 },
  { label: 'products.priceHigh', min: 1000, max: Infinity }
]

// Filter state
const selectedCategory = ref('All')
const selectedIllumination = ref('All')
const selectedPriceRange = ref(priceRanges[0])

// Filtered products computed property
const filteredProducts = computed(() => {
  return products.value.filter(product => {
    // Category filter
    if (selectedCategory.value !== 'All') {
      const productName = product.name.toLowerCase()
      const category = selectedCategory.value.toLowerCase()
      
      // Match category in product name
      if (category === 'lightboxes' && !productName.includes('lightbox')) return false
      if (category === 'channel letters' && !productName.includes('channel') && !productName.includes('letter')) return false
      if (category === 'neon' && !productName.includes('neon')) return false
      if (category === 'pylons' && !productName.includes('pylon')) return false
      if (category === 'windows' && !productName.includes('window')) return false
      if (category === 'terminal' && !productName.includes('terminal') && !productName.includes('pos')) return false
    }
    
    // Illumination type filter
    if (selectedIllumination.value !== 'All') {
      const illuminationType = product.illumination_type?.toLowerCase() || 'led'
      if (selectedIllumination.value.toLowerCase() !== illuminationType) return false
    }
    
    // Price range filter
    const price = product.price
    if (price < selectedPriceRange.value.min || price > selectedPriceRange.value.max) return false
    
    return true
  })
})

// Reset filters
const resetFilters = () => {
  selectedCategory.value = 'All'
  selectedIllumination.value = 'All'
  selectedPriceRange.value = priceRanges[0]
}

const fetchProducts = async () => {
  try {
    loading.value = true
    const directusUrl = import.meta.env.VITE_DIRECTUS_URL || 'http://localhost:8055'
    const fields = [
      'id', 'slug', 'name', 'name_de', 'description', 'description_de',
      'price', 'compare_at_price', 'stock', 'customizable', 'illumination_type',
      'lead_time_days', 'primary_image', 'day_image', 'night_image',
      'before_image', 'after_image'
    ].join(',')
    
    const response = await fetch(`${directusUrl}/items/products?fields=${fields}`)
    
    if (!response.ok) {
      throw new Error(t('products.errorFetchProducts'))
    }
    
    const data = await response.json()
    products.value = (data.data || []).map((product: any) => ({
      ...product,
      price: Number(product.price) || 0,
      compare_at_price: product.compare_at_price ? Number(product.compare_at_price) : undefined
    }))
  } catch (e: any) {
    error.value = e.message || t('products.errorFetchProducts')
    products.value = []
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchProducts()
})
</script>
