<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8">All Products</h1>
    
    <!-- Filter Section -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-8">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-xl font-semibold">Filters</h2>
        <button 
          v-if="activeFilterCount > 0"
          @click="clearFilters" 
          class="text-sm text-primary-600 hover:text-primary-700 font-medium"
        >
          Clear Filters ({{ activeFilterCount }})
        </button>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <!-- Category Filter -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Category</label>
          <select 
            v-model="filters.category_id" 
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          >
            <option :value="undefined">All Categories</option>
            <option 
              v-for="category in productsStore.categories" 
              :key="category.id" 
              :value="category.id"
            >
              {{ category.name }}
            </option>
          </select>
        </div>

        <!-- Price Range Filter -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Min Price</label>
          <input 
            v-model.number="filters.min_price" 
            type="number" 
            min="0" 
            step="0.01"
            placeholder="$0.00"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          />
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Max Price</label>
          <input 
            v-model.number="filters.max_price" 
            type="number" 
            min="0" 
            step="0.01"
            placeholder="$9999.99"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          />
        </div>

        <!-- Search Filter -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
          <input 
            v-model="filters.search" 
            type="text" 
            placeholder="Search products..."
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          />
        </div>
      </div>

      <!-- Featured Only Checkbox -->
      <div class="mt-4">
        <label class="flex items-center cursor-pointer">
          <input 
            v-model="filters.featured" 
            type="checkbox" 
            class="w-4 h-4 text-primary-600 border-gray-300 rounded focus:ring-primary-500"
          />
          <span class="ml-2 text-sm text-gray-700">Show featured products only</span>
        </label>
      </div>
    </div>
    
    <!-- Loading State -->
    <div v-if="productsStore.loading" class="text-center py-12">
      <div class="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
      <p class="text-gray-600 mt-4">Loading products...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="productsStore.error" class="text-center py-12">
      <p class="text-red-600 mb-4">{{ productsStore.error }}</p>
      <button @click="loadProducts" class="btn-primary">
        Try Again
      </button>
    </div>

    <!-- Empty State -->
    <div v-else-if="productsStore.products.length === 0" class="text-center py-12">
      <p class="text-gray-600">No products match your filters.</p>
      <button v-if="activeFilterCount > 0" @click="clearFilters" class="btn-secondary mt-4">
        Clear Filters
      </button>
    </div>

    <!-- Products Grid -->
    <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      <div 
        v-for="product in productsStore.products" 
        :key="product.id"
        class="card hover:shadow-lg transition-shadow duration-200"
      >
        <div class="aspect-square bg-gray-200 flex items-center justify-center">
          <span class="text-gray-400">No Image</span>
        </div>
        <div class="p-4">
          <h3 class="font-semibold text-lg mb-2 line-clamp-2">{{ product.name }}</h3>
          <p class="text-gray-600 text-sm mb-3 line-clamp-2">{{ product.description }}</p>
          <div class="flex items-center justify-between mb-4">
            <div>
              <span class="text-2xl font-bold text-primary-600">${{ product.price }}</span>
              <span v-if="product.compare_at_price" class="text-sm text-gray-500 line-through ml-2">
                ${{ product.compare_at_price }}
              </span>
            </div>
          </div>
          <div class="flex gap-2">
            <router-link 
              :to="`/products/${product.slug}`" 
              class="flex-1 text-center btn-secondary text-sm"
            >
              View Details
            </router-link>
            <button 
              @click="addToCart(product)" 
              class="flex-1 btn-primary text-sm"
            >
              Add to Cart
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onMounted } from 'vue'
import { useProductsStore } from '@/store/products'
import { useCartStore } from '@/store/cart'
import type { Product } from '@/types'
import type { ProductFilter } from '@/api/products'

const productsStore = useProductsStore()
const cartStore = useCartStore()

// Filter state
const filters = ref<ProductFilter>({
  category_id: undefined,
  search: '',
  featured: undefined,
  min_price: undefined,
  max_price: undefined
})

// Debounce timeout for search
let searchDebounceTimeout: ReturnType<typeof setTimeout> | null = null

// Computed: Active filter count
const activeFilterCount = computed(() => {
  let count = 0
  if (filters.value.category_id) count++
  if (filters.value.search && filters.value.search.trim() !== '') count++
  if (filters.value.featured) count++
  if (filters.value.min_price !== undefined && filters.value.min_price > 0) count++
  if (filters.value.max_price !== undefined && filters.value.max_price > 0) count++
  return count
})

// Load products with current filters
const loadProducts = async () => {
  console.log('🔄 loadProducts() called with filter state:', filters.value)
  
  const filterToApply: ProductFilter = {}
  
  if (filters.value.category_id) {
    filterToApply.category_id = filters.value.category_id
  }
  
  if (filters.value.search && filters.value.search.trim() !== '') {
    filterToApply.search = filters.value.search.trim()
  }
  
  if (filters.value.featured) {
    filterToApply.featured = true
  }
  
  if (filters.value.min_price !== undefined && filters.value.min_price > 0) {
    filterToApply.min_price = Number(filters.value.min_price)
  }
  
  if (filters.value.max_price !== undefined && filters.value.max_price > 0) {
    filterToApply.max_price = Number(filters.value.max_price)
  }
  
  console.log('📦 Applying filters to API:', filterToApply)
  await productsStore.fetchProducts(filterToApply)
  console.log('✅ Products loaded:', productsStore.products.length)
}

// Clear all filters
const clearFilters = () => {
  filters.value = {
    category_id: undefined,
    search: '',
    featured: undefined,
    min_price: undefined,
    max_price: undefined
  }
}

// Watch filters with debouncing for search
watch(() => filters.value.search, (newValue, oldValue) => {
  console.log('🔍 Search filter changed:', oldValue, '->', newValue)
  if (searchDebounceTimeout) {
    clearTimeout(searchDebounceTimeout)
  }
  searchDebounceTimeout = setTimeout(() => {
    console.log('⏱️ Search debounce completed, loading products...')
    loadProducts()
  }, 300)
})

// Watch other filters (immediate trigger)
watch(() => filters.value.category_id, (newValue, oldValue) => {
  console.log('📂 Category filter changed:', oldValue, '->', newValue)
  loadProducts()
})

watch(() => filters.value.featured, (newValue, oldValue) => {
  console.log('⭐ Featured filter changed:', oldValue, '->', newValue)
  loadProducts()
})

watch(() => filters.value.min_price, (newValue, oldValue) => {
  console.log('💰 Min price filter changed:', oldValue, '->', newValue)
  loadProducts()
})

watch(() => filters.value.max_price, (newValue, oldValue) => {
  console.log('💰 Max price filter changed:', oldValue, '->', newValue)
  loadProducts()
})

// Add to cart function
const addToCart = (product: Product) => {
  cartStore.addItem(product, 1)
}

// On mount: fetch categories and initial products
onMounted(async () => {
  await productsStore.fetchCategories()
  await loadProducts()
})
</script>
