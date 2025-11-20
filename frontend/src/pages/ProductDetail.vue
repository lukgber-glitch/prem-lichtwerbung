<template>
  <div class="min-h-screen bg-background">
    <div v-if="loading" class="container mx-auto px-6 py-12 text-center">
      <div class="text-xl text-text-muted">Loading product...</div>
    </div>
    
    <div v-else-if="error" class="container mx-auto px-6 py-12 text-center">
      <div class="text-red-600 text-xl">{{ error }}</div>
    </div>
    
    <div v-else-if="product" class="container mx-auto px-6 py-12">
      
      <!-- Breadcrumbs -->
      <nav class="mb-8 text-sm text-text-muted">
        <router-link to="/" class="hover:text-primary transition-colors cursor-pointer">Home</router-link>
        <span class="mx-2">/</span>
        <router-link to="/products" class="hover:text-primary transition-colors cursor-pointer">Products</router-link>
        <span class="mx-2">/</span>
        <span class="text-text-main">{{ product.name }}</span>
      </nav>
      
      <!-- Product Layout -->
      <div class="grid md:grid-cols-2 gap-12 mb-12">
        
        <!-- Left: Images -->
        <div>
          <div class="aspect-square bg-surface rounded-xl mb-4 flex items-center justify-center border border-primary/20">
            <span class="text-9xl">💡</span>
          </div>
          <div class="grid grid-cols-4 gap-2">
            <div class="aspect-square bg-surface rounded-lg border border-surface-alt"></div>
            <div class="aspect-square bg-surface rounded-lg border border-surface-alt"></div>
            <div class="aspect-square bg-surface rounded-lg border border-surface-alt"></div>
            <div class="aspect-square bg-surface rounded-lg border border-surface-alt"></div>
          </div>
        </div>
        
        <!-- Right: Info -->
        <div>
          <h1 class="text-4xl font-heading font-bold text-text-main mb-4">{{ product.name }}</h1>
          
          <div class="flex items-baseline gap-4 mb-6">
            <span class="text-5xl font-bold text-primary">
              €{{ Number(product.price).toFixed(2) }}
            </span>
            <span v-if="product.compare_at_price" class="text-2xl text-text-muted line-through">
              €{{ Number(product.compare_at_price).toFixed(2) }}
            </span>
          </div>
          
          <p class="text-text-muted mb-6">{{ product.description }}</p>
          
          <div class="mb-6">
            <span class="inline-block px-4 py-2 bg-primary/10 text-primary border border-primary/30 rounded-full text-sm font-semibold mr-2">
              {{ product.illumination_type || 'LED' }} Illuminated
            </span>
            <span v-if="product.customizable" class="inline-block px-4 py-2 bg-accent/10 text-accent border border-accent/30 rounded-full text-sm font-bold">
              ✨ Customizable
            </span>
          </div>
          
          <!-- Stock Status -->
          <div class="mb-6">
            <span v-if="product.stock > 0" class="text-green-400 font-semibold">
              ✓ In Stock ({{ product.stock }} available)
            </span>
            <span v-else class="text-red-400 font-semibold">
              ✗ Out of Stock
            </span>
          </div>
          
          <!-- Add to Cart -->
          <div class="mb-8">
            <div class="flex items-center gap-4 mb-4">
              <label class="text-text-main font-semibold">Quantity:</label>
              <input 
                v-model.number="quantity"
                type="number" 
                min="1" 
                :max="product.stock"
                class="w-20 px-4 py-2 border border-surface-alt rounded-lg bg-surface text-text-main"
              />
            </div>
            
            <button 
              @click="addToCart"
              :disabled="product.stock === 0"
              class="w-full px-8 py-4 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary disabled:bg-text-muted disabled:cursor-not-allowed cursor-pointer"
            >
              {{ product.stock > 0 ? `⚡ Add to Cart - €${(product.price * quantity).toFixed(2)}` : 'Out of Stock' }}
            </button>
          </div>
          
        </div>
      </div>
      
      <!-- Terminal Bundle Special CTA -->
      <div v-if="product?.slug === 'pos-terminal-menu-board-bundle'" 
           class="bg-surface border-2 border-primary p-8 rounded-lg my-8">
        <div class="flex items-start gap-4">
          <div class="text-4xl">💼</div>
          <div class="flex-1">
            <h3 class="text-2xl font-heading font-bold text-text-main mb-3">
              Complete POS Terminal Bundle
            </h3>
            <p class="text-lg text-text-muted mb-4">
              Save <span class="text-3xl font-bold text-primary">20%</span> on this complete hardware + signage solution
            </p>
            <ul class="text-text-main mb-6 space-y-2">
              <li>✓ POS terminal with touchscreen</li>
              <li>✓ LED-backlit menu board (120x80cm)</li>
              <li>✓ Installation included (€300 value)</li>
              <li>✓ Software setup & training</li>
              <li>✓ 3-year warranty</li>
            </ul>
            <div class="flex gap-4 flex-wrap">
              <ButtonGlow variant="primary" class="text-lg">
                Get Bundle for €1,899
              </ButtonGlow>
              <ButtonGlow variant="secondary" @click="openQuoteModal">
                Request Quote
              </ButtonGlow>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Technical Specs -->
      <div class="border-t-2 border-primary/20 pt-12">
        <h2 class="text-4xl font-heading font-bold text-text-main mb-6">Technical Specifications</h2>
        <div class="grid md:grid-cols-2 gap-6">
          <div>
            <h3 class="font-semibold text-text-main mb-2">Dimensions</h3>
            <p class="text-text-muted">
              {{ product.dimensions_width_cm || 100 }}cm × 
              {{ product.dimensions_height_cm || 70 }}cm × 
              {{ product.dimensions_depth_cm || 8 }}cm
            </p>
          </div>
          <div>
            <h3 class="font-semibold text-text-main mb-2">Power Consumption</h3>
            <p class="text-text-muted">{{ product.power_consumption_watts || 45 }}W</p>
          </div>
          <div>
            <h3 class="font-semibold text-text-main mb-2">IP Rating</h3>
            <p class="text-text-muted">{{ product.ip_rating || 'IP44' }} (weather-resistant)</p>
          </div>
          <div>
            <h3 class="font-semibold text-text-main mb-2">Lead Time</h3>
            <p class="text-text-muted">{{ product.lead_time_days || 7 }}-{{ (product.lead_time_days || 7) + 7 }} days</p>
          </div>
          <div>
            <h3 class="font-semibold text-text-main mb-2">Material</h3>
            <p class="text-text-muted">{{ product.material || 'Premium acrylic with aluminum frame' }}</p>
          </div>
          <div>
            <h3 class="font-semibold text-text-main mb-2">Illumination Type</h3>
            <p class="text-text-muted">{{ product.illumination_type || 'LED' }}</p>
          </div>
        </div>
      </div>
      
    </div>
    
    <QuoteRequestModal :is-open="showQuoteModal" :prefilled-product="product?.name" @close="showQuoteModal = false" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import QuoteRequestModal from '@/components/modals/QuoteRequestModal.vue'

const route = useRoute()
const router = useRouter()

const product = ref<any>(null)
const loading = ref(true)
const error = ref('')
const quantity = ref(1)
const showQuoteModal = ref(false)

const fetchProduct = async () => {
  try {
    loading.value = true
    const productId = route.params.id
    const response = await fetch(`http://localhost:8055/items/products/${productId}`)
    
    if (!response.ok) {
      throw new Error('Product not found')
    }
    
    const data = await response.json()
    product.value = data.data
  } catch (e: any) {
    error.value = e.message
  } finally {
    loading.value = false
  }
}

const addToCart = () => {
  alert(`Added ${quantity.value}x ${product.value.name} to cart!`)
  // TODO: Implement actual cart logic with Pinia store
}

const openQuoteModal = () => {
  showQuoteModal.value = true
}

onMounted(() => {
  fetchProduct()
})
</script>
