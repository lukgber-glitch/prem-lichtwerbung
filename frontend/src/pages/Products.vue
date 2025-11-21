<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      
      <!-- Page Header -->
      <div class="mb-8">
        <h1 class="text-5xl font-heading font-bold text-text-main mb-4">All Products</h1>
        <p class="text-xl text-text-muted">Discover our premium illuminated signage solutions</p>
      </div>
      
      <!-- Layout: Filters + Products -->
      <div class="flex flex-col md:flex-row gap-8">
        
        <!-- Filters Sidebar -->
        <aside class="md:w-1/4">
          <div class="bg-surface p-6 rounded-xl border border-primary/20 sticky top-24">
            <h3 class="text-xl font-bold text-text-main mb-4">Filters</h3>
            
            <div class="mb-6">
              <label class="block text-text-main font-semibold mb-2">Price Range</label>
              <input 
                v-model="filters.maxPrice"
                type="range" 
                min="0" 
                max="5000" 
                step="100"
                class="w-full"
              />
              <div class="flex justify-between text-sm text-text-muted">
                <span>€0</span>
                <span>€{{ filters.maxPrice }}</span>
              </div>
            </div>
            
            <div class="mb-6">
              <label class="block text-text-main font-semibold mb-3">{{ t('products.category') }}</label>
              <div class="flex flex-wrap gap-2">
                <button
                  @click="filters.category = ''"
                  :class="[
                    'px-4 py-2 rounded-lg font-medium transition-all border-2',
                    filters.category === '' 
                      ? 'bg-primary text-background border-primary' 
                      : 'bg-surface text-text-main border-primary/20 hover:border-primary/40'
                  ]"
                >
                  {{ t('products.allCategories') }}
                </button>
                <button
                  v-for="category in availableCategories"
                  :key="category.id"
                  @click="filters.category = category.id"
                  :class="[
                    'px-4 py-2 rounded-lg font-medium transition-all border-2',
                    filters.category === category.id
                      ? 'bg-primary text-background border-primary' 
                      : 'bg-surface text-text-main border-primary/20 hover:border-primary/40'
                  ]"
                >
                  {{ locale === 'de' && category.name_de ? category.name_de : category.name }}
                </button>
              </div>
            </div>
            
            <button 
              @click="resetFilters"
              class="w-full px-4 py-2 bg-primary text-background font-semibold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary"
            >
              {{ t('products.resetFilters') }}
            </button>
          </div>
        </aside>
        
        <!-- Products Grid -->
        <main class="md:w-3/4">
          
          <!-- Search Bar -->
          <div class="mb-6">
            <div class="relative">
              <input 
                v-model="searchQuery"
                type="text"
                :placeholder="t('products.searchPlaceholder')"
                class="w-full px-4 py-3 pl-12 border-2 border-primary/20 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent bg-surface text-text-main placeholder-text-muted"
              />
              <svg class="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-text-muted" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
            </div>
          </div>
          
          <!-- Sort & View Controls -->
          <div class="flex justify-between items-center mb-6">
            <p class="text-text-muted">
              {{ t('products.showing') }} {{ filteredProducts.length }} {{ t('nav.products').toLowerCase() }}
            </p>
            <select 
              v-model="sortBy"
              class="px-4 py-2 border-2 border-primary/20 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent bg-surface text-text-main"
              @change="sortProducts"
            >
              <option value="newest">{{ t('products.sortNewest2') }}</option>
              <option value="price-low">{{ t('products.sortPriceAsc') }}</option>
              <option value="price-high">{{ t('products.sortPriceDesc') }}</option>
              <option value="name">{{ t('products.sortNameAsc2') }}</option>
            </select>
          </div>
          
          <!-- Loading State -->
          <div v-if="loading" class="text-center py-12">
            <div class="text-xl text-text-muted">{{ t('products.loadingProducts') }}</div>
          </div>
          
          <!-- Error State -->
          <div v-else-if="error" class="text-center py-12">
            <div class="text-red-600 text-xl mb-4">{{ error }}</div>
            <p class="text-text-muted">{{ t('products.errorPermissions') }}</p>
          </div>
          
          <!-- Empty State -->
          <div v-else-if="filteredProducts.length === 0" class="text-center py-12">
            <p class="text-text-muted text-xl">{{ t('products.noProducts') }}</p>
          </div>
          
          <!-- Products Grid -->
          <div v-else class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            <ProductCard 
              v-for="product in filteredProducts" 
              :key="product.id"
              :product="product"
            />
          </div>
          
        </main>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import ProductCard from '@/components/products/ProductCard.vue'

const { t, locale } = useI18n()

// Helper functions for locale-aware product fields
const getProductName = (product: any) => {
  return locale.value === 'de' && product.name_de ? product.name_de : product.name
}

const getProductDescription = (product: any) => {
  return locale.value === 'de' && product.description_de ? product.description_de : product.description
}

const products = ref<any[]>([])
const availableCategories = ref<any[]>([])
const loading = ref(true)
const error = ref('')
const sortBy = ref('newest')

const filters = ref({
  maxPrice: 5000,
  category: ''
})

const searchQuery = ref('')

const fetchCategories = async () => {
  try {
    const response = await fetch('http://localhost:8055/items/categories?filter[status][_eq]=published&sort=sort')
    
    if (!response.ok) {
      throw new Error('Failed to fetch categories')
    }
    
    const data = await response.json()
    availableCategories.value = data.data || []
  } catch (e: any) {
    console.error('Failed to fetch categories:', e)
    availableCategories.value = []
  }
}

const fetchProducts = async () => {
  try {
    loading.value = true
    const fields = [
      'id', 'slug', 'name', 'name_de', 'description', 'description_de',
      'price', 'compare_at_price', 'stock', 'customizable', 'illumination_type',
      'lead_time_days', 'primary_image', 'day_image', 'night_image',
      'before_image', 'after_image',
      'categories.categories_id.id',
      'categories.categories_id.name',
      'categories.categories_id.name_de',
      'categories.categories_id.slug'
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

const filteredProducts = computed(() => {
  let filtered = [...products.value]
  
  // Filter by search query
  if (searchQuery.value.trim()) {
    const query = searchQuery.value.toLowerCase().trim()
    filtered = filtered.filter(product => {
      const nameEn = (product.name || '').toLowerCase()
      const nameDe = (product.name_de || '').toLowerCase()
      const descEn = (product.description || '').toLowerCase()
      const descDe = (product.description_de || '').toLowerCase()
      
      return nameEn.includes(query) || 
             nameDe.includes(query) || 
             descEn.includes(query) || 
             descDe.includes(query)
    })
  }
  
  // Filter by price
  filtered = filtered.filter(p => p.price <= filters.value.maxPrice)
  
  // Filter by category
  if (filters.value.category) {
    filtered = filtered.filter(product => {
      if (!product.categories || !Array.isArray(product.categories)) {
        return false
      }
      return product.categories.some((cat: any) => cat.categories_id?.id === filters.value.category)
    })
  }
  
  return filtered
})

const sortProducts = () => {
  const sorted = [...products.value]
  
  switch (sortBy.value) {
    case 'price-low':
      sorted.sort((a, b) => a.price - b.price)
      break
    case 'price-high':
      sorted.sort((a, b) => b.price - a.price)
      break
    case 'name':
      sorted.sort((a, b) => getProductName(a).localeCompare(getProductName(b)))
      break
  }
  
  products.value = sorted
}

const resetFilters = () => {
  filters.value = {
    maxPrice: 5000,
    category: ''
  }
  searchQuery.value = ''
}

onMounted(() => {
  fetchCategories()
  fetchProducts()
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
