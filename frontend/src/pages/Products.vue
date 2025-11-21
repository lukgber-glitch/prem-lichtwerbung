<template>
  <div class="min-h-screen bg-white">
    
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-black overflow-hidden px-6">
      <div class="max-w-content mx-auto text-center">
        <h1 class="text-7xl md:text-9xl font-heading font-black text-white leading-none tracking-tighter">
          Work
        </h1>
      </div>
    </section>
    
    <!-- PRODUCTS GRID - Minimal Asymmetric Layout -->
    <section class="py-44 bg-white">
      <div class="max-w-content mx-auto px-6 md:px-32">
        
        <!-- Loading State -->
        <div v-if="loading" class="text-center py-20">
          <div class="text-xl font-light text-black">Loading...</div>
        </div>
        
        <!-- Error State -->
        <div v-else-if="error" class="text-center py-20">
          <div class="text-xl font-light text-black">{{ error }}</div>
        </div>
        
        <!-- Empty State -->
        <div v-else-if="products.length === 0" class="text-center py-20">
          <p class="text-xl font-light text-black">No products available</p>
        </div>
        
        <!-- Products Grid - Asymmetric 2-3 columns -->
        <div v-else class="grid md:grid-cols-2 lg:grid-cols-3 gap-x-12 gap-y-20">
          <ProductCard 
            v-for="product in products" 
            :key="product.id"
            :product="product"
          />
        </div>
        
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import ProductCard from '@/components/products/ProductCard.vue'

const products = ref<any[]>([])
const loading = ref(true)
const error = ref('')

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
  fetchProducts()
})
</script>
