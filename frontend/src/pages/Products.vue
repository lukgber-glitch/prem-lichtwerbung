<template>
  <div class="min-h-screen bg-omnicom-bg page-products">
    
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-omnicom-black overflow-hidden px-6">
      <div class="noise-texture"></div>
      <div class="max-w-content mx-auto text-center">
        <h1 class="text-7xl md:text-9xl font-heading font-black text-omnicom-text-light leading-none tracking-[-0.03em]">
          Work
        </h1>
      </div>
    </section>
    
    <!-- FILTERS SECTION - Omnicom Minimal with Accent Line -->
    <section class="py-20 bg-omnicom-bg-alt border-b border-omnicom-gray-300/25">
      <div class="max-w-content mx-auto px-6 md:px-32">
        
        <!-- Decorative Accent Line -->
        <OmnicomAccentLine size="md" class="mb-8" />
        
        <!-- Section Label -->
        <p class="text-xs uppercase tracking-[0.2em] font-semibold text-omnicom-muted mb-12">Filter Products</p>
        
        <!-- Category Filter -->
        <div class="mb-12">
          <h3 class="text-sm font-light text-omnicom-muted mb-4 uppercase tracking-wider">Category</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="category in categories" 
              :key="category"
              @click="selectedCategory = category"
              class="px-6 py-3 text-sm font-semibold border transition-all duration-500 cursor-pointer"
              :class="selectedCategory === category 
                ? 'bg-omnicom-black text-omnicom-text-light border-omnicom-black' 
                : 'bg-transparent text-omnicom-text border-omnicom-gray-300 hover:border-omnicom-black'"
            >
              {{ category }}
            </button>
          </div>
        </div>
        
        <!-- Illumination Type Filter -->
        <div class="mb-12">
          <h3 class="text-sm font-light text-omnicom-muted mb-4 uppercase tracking-wider">Illumination</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="type in illuminationTypes" 
              :key="type"
              @click="selectedIllumination = type"
              class="px-6 py-3 text-sm font-semibold border transition-all duration-500 cursor-pointer"
              :class="selectedIllumination === type 
                ? 'bg-omnicom-black text-omnicom-text-light border-omnicom-black' 
                : 'bg-transparent text-omnicom-text border-omnicom-gray-300 hover:border-omnicom-black'"
            >
              {{ type }}
            </button>
          </div>
        </div>
        
        <!-- Price Range Filter -->
        <div class="mb-12">
          <h3 class="text-sm font-light text-omnicom-muted mb-4 uppercase tracking-wider">Price Range</h3>
          <div class="flex flex-wrap gap-3">
            <button 
              v-for="range in priceRanges" 
              :key="range.label"
              @click="selectedPriceRange = range"
              class="px-6 py-3 text-sm font-semibold border transition-all duration-500 cursor-pointer"
              :class="selectedPriceRange === range 
                ? 'bg-omnicom-black text-omnicom-text-light border-omnicom-black' 
                : 'bg-transparent text-omnicom-text border-omnicom-gray-300 hover:border-omnicom-black'"
            >
              {{ range.label }}
            </button>
          </div>
        </div>
        
        <!-- Results Count -->
        <div class="text-sm font-light text-omnicom-muted">
          {{ filteredProducts.length }} {{ filteredProducts.length === 1 ? 'product' : 'products' }} found
        </div>
        
      </div>
    </section>
    
    <!-- PRODUCTS GRID - Minimal Asymmetric Layout -->
    <section class="py-44 bg-omnicom-bg">
      <div class="max-w-content mx-auto px-6 md:px-32">
        
        <!-- Loading State -->
        <div v-if="loading" class="text-center py-20">
          <div class="text-xl font-light text-omnicom-text">Loading...</div>
        </div>
        
        <!-- Error State -->
        <div v-else-if="error" class="text-center py-20">
          <div class="text-xl font-light text-omnicom-text">{{ error }}</div>
        </div>
        
        <!-- Empty State -->
        <div v-else-if="filteredProducts.length === 0" class="text-center py-20">
          <p class="text-xl font-light text-omnicom-text">No products match your filters</p>
          <button 
            @click="resetFilters"
            class="mt-8 px-8 py-4 bg-transparent text-omnicom-text text-sm font-semibold border-2 border-omnicom-black hover:bg-omnicom-black hover:text-omnicom-white transition-all duration-500 cursor-pointer"
          >
            Reset Filters
          </button>
        </div>
        
        <!-- Products Grid - Asymmetric 2-3 columns -->
        <div v-else class="grid md:grid-cols-2 lg:grid-cols-3 gap-x-12 gap-y-20">
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
import ProductCard from '@/components/products/ProductCard.vue'
import OmnicomAccentLine from '@/components/ui/OmnicomAccentLine.vue'
import { useScrollAnimation } from '@/composables/useScrollAnimation'

const products = ref<any[]>([])
const loading = ref(true)
const error = ref('')

// Filter options
const categories = ['All', 'Lightboxes', 'Channel Letters', 'Neon', 'Pylons', 'Windows', 'Terminal']
const illuminationTypes = ['All', 'LED', 'Neon']
const priceRanges = [
  { label: 'All', min: 0, max: Infinity },
  { label: '< €500', min: 0, max: 500 },
  { label: '€500 - €1000', min: 500, max: 1000 },
  { label: '> €1000', min: 1000, max: Infinity }
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
    const fields = [
      'id', 'slug', 'name', 'name_de', 'description', 'description_de',
      'price', 'compare_at_price', 'stock', 'customizable', 'illumination_type',
      'lead_time_days', 'primary_image', 'day_image', 'night_image',
      'before_image', 'after_image'
    ].join(',')
    
    const response = await fetch(`http://localhost:8055/items/products?fields=${fields}`)
    
    if (!response.ok) {
      throw new Error('Failed to fetch products')
    }
    
    const data = await response.json()
    products.value = (data.data || []).map((product: any) => ({
      ...product,
      price: Number(product.price) || 0,
      compare_at_price: product.compare_at_price ? Number(product.compare_at_price) : undefined
    }))
  } catch (e: any) {
    error.value = e.message
    products.value = []
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  const { animateOnScroll } = useScrollAnimation()
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  if (!reduce) {
    animateOnScroll('.accent-line', { y: 40, duration: 0.8 })
    animateOnScroll('h1', { y: 40, duration: 1.0 })
    animateOnScroll('h2', { y: 40, duration: 0.9 })
    animateOnScroll('p', { y: 30, duration: 0.8 })
    animateOnScroll('button', { y: 20, duration: 0.7 })
  }
  fetchProducts()
})
</script>
