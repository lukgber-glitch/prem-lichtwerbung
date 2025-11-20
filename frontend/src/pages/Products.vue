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
              <label class="block text-text-main font-semibold mb-2">Category</label>
              <select v-model="filters.category" class="w-full px-4 py-2 border border-surface-alt rounded-lg bg-surface-alt text-text-main">
                <option value="">All Categories</option>
                <option value="lightboxes">Lightboxes</option>
                <option value="channel-letters">Channel Letters</option>
                <option value="neon-signs">LED Neon Signs</option>
                <option value="pylons">Pylons & Totems</option>
              </select>
            </div>
            
            <button 
              @click="resetFilters"
              class="w-full px-4 py-2 bg-primary text-background font-semibold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary"
            >
              Reset Filters
            </button>
          </div>
        </aside>
        
        <!-- Products Grid -->
        <main class="md:w-3/4">
          
          <!-- Sort & View Controls -->
          <div class="flex justify-between items-center mb-6">
            <p class="text-text-muted">
              Showing {{ filteredProducts.length }} products
            </p>
            <select 
              v-model="sortBy"
              class="px-4 py-2 border-2 border-primary/20 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent bg-surface text-text-main"
              @change="sortProducts"
            >
              <option value="newest">Newest</option>
              <option value="price-low">Price: Low to High</option>
              <option value="price-high">Price: High to Low</option>
              <option value="name">Name A-Z</option>
            </select>
          </div>
          
          <!-- Loading State -->
          <div v-if="loading" class="text-center py-12">
            <div class="text-xl text-text-muted">Loading products...</div>
          </div>
          
          <!-- Error State -->
          <div v-else-if="error" class="text-center py-12">
            <div class="text-red-600 text-xl mb-4">{{ error }}</div>
            <p class="text-text-muted">Make sure Directus is running and permissions are configured.</p>
          </div>
          
          <!-- Empty State -->
          <div v-else-if="filteredProducts.length === 0" class="text-center py-12">
            <p class="text-text-muted text-xl">No products found</p>
          </div>
          
          <!-- Products Grid -->
          <div v-else class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div 
              v-for="product in filteredProducts" 
              :key="product.id"
              class="group bg-surface-alt rounded-xl border border-surface overflow-hidden hover:border-primary transition-all duration-300 cursor-pointer"
              @click="$router.push(`/products/${product.id}`)"
            >
              <!-- Product Image -->
              <div class="aspect-[4/3] bg-surface flex items-center justify-center relative overflow-hidden">
                <span class="text-8xl relative z-10 group-hover:scale-110 transition-transform duration-300">💡</span>
                
                <!-- Customizable badge -->
                <div v-if="product.customizable" class="absolute top-4 left-4 bg-accent text-background px-3 py-1 rounded-full text-xs font-bold z-10">
                  Customizable
                </div>
              </div>
              
              <!-- Product Info -->
              <div class="p-6">
                <div class="flex gap-2 mb-3">
                  <span class="inline-block bg-primary/10 text-primary px-3 py-1 rounded-full text-xs font-semibold border border-primary/20">
                    {{ product.illumination_type || 'LED' }}
                  </span>
                  <span v-if="product.lead_time_days" class="inline-block bg-surface text-text-muted px-3 py-1 rounded-full text-xs">
                    {{ product.lead_time_days }} days
                  </span>
                </div>
                
                <h3 class="font-heading text-xl font-bold text-text-main mb-2 group-hover:text-primary transition-colors line-clamp-2">
                  {{ product.name }}
                </h3>
                
                <p v-if="product.description" class="text-text-muted text-sm mb-4 line-clamp-2">
                  {{ product.description }}
                </p>
                
                <div class="flex items-baseline gap-3 mb-4">
                  <span class="text-3xl font-bold text-primary">
                    €{{ Number(product.price).toFixed(2) }}
                  </span>
                  <span v-if="product.compare_at_price" class="text-lg text-text-muted line-through">
                    €{{ Number(product.compare_at_price).toFixed(2) }}
                  </span>
                </div>
                
                <button 
                  class="w-full px-6 py-3 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary"
                  @click.stop="$router.push(`/products/${product.id}`)"
                >
                  View Details
                </button>
              </div>
            </div>
          </div>
          
        </main>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

const products = ref<any[]>([])
const loading = ref(true)
const error = ref('')
const sortBy = ref('newest')

const filters = ref({
  maxPrice: 5000,
  category: ''
})

const fetchProducts = async () => {
  try {
    loading.value = true
    const response = await fetch('http://localhost:8055/items/products')
    
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
  
  // Filter by price
  filtered = filtered.filter(p => p.price <= filters.value.maxPrice)
  
  // Filter by category (if needed)
  // Add category filtering logic here
  
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
      sorted.sort((a, b) => a.name.localeCompare(b.name))
      break
  }
  
  products.value = sorted
}

const resetFilters = () => {
  filters.value = {
    maxPrice: 5000,
    category: ''
  }
}

onMounted(() => {
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
