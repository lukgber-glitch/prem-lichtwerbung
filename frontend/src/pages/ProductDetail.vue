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
          <!-- Main Image -->
          <div class="aspect-square bg-surface rounded-xl mb-4 overflow-hidden border border-primary/20">
            <img 
              :src="displayImage" 
              :alt="product.name"
              class="w-full h-full object-cover"
            />
          </div>
          
          <!-- Thumbnail Gallery -->
          <div class="grid grid-cols-4 gap-2">
            <div 
              v-if="product.primary_image"
              @click="currentImage = product.primary_image"
              class="aspect-square bg-surface rounded-lg border cursor-pointer overflow-hidden hover:border-primary transition-colors"
              :class="currentImage === product.primary_image ? 'border-primary' : 'border-surface-alt'"
            >
              <img :src="primaryImageUrl" :alt="product.name" class="w-full h-full object-cover" />
            </div>
            <div 
              v-if="product.day_image"
              @click="currentImage = product.day_image"
              class="aspect-square bg-surface rounded-lg border cursor-pointer overflow-hidden hover:border-primary transition-colors"
              :class="currentImage === product.day_image ? 'border-primary' : 'border-surface-alt'"
            >
              <img :src="dayImageUrl" :alt="`${product.name} - Day`" class="w-full h-full object-cover" />
            </div>
            <div 
              v-if="product.night_image"
              @click="currentImage = product.night_image"
              class="aspect-square bg-surface rounded-lg border cursor-pointer overflow-hidden hover:border-primary transition-colors"
              :class="currentImage === product.night_image ? 'border-primary' : 'border-surface-alt'"
            >
              <img :src="nightImageUrl" :alt="`${product.name} - Night`" class="w-full h-full object-cover" />
            </div>
            <div 
              v-if="product.after_image"
              @click="currentImage = product.after_image"
              class="aspect-square bg-surface rounded-lg border cursor-pointer overflow-hidden hover:border-primary transition-colors"
              :class="currentImage === product.after_image ? 'border-primary' : 'border-surface-alt'"
            >
              <img :src="afterImageUrl" :alt="`${product.name} - After`" class="w-full h-full object-cover" />
            </div>
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
          
          <!-- Terminal Demo Button -->
          <div v-if="isTerminalProduct" class="mb-6 p-6 bg-gradient-to-r from-blue-600/10 to-cyan-500/10 border-2 border-blue-500/30 rounded-xl">
            <h3 class="text-xl font-bold text-text-main mb-2">🖥️ Interactive Demo Available</h3>
            <p class="text-text-muted mb-4">Experience the complete 13-screen POS terminal system in action. Test the customer journey from pump selection to payment completion.</p>
            <router-link 
              to="/terminal-demo" 
              class="inline-block px-8 py-4 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold rounded-lg hover:shadow-xl hover:scale-105 transition-all duration-300 cursor-pointer"
            >
              ▶️ Try Interactive Demo
            </router-link>
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
      
      <!-- Interactive POS Terminal (for terminal bundle product) -->
      <div v-if="product?.slug === 'pos-terminal-menu-board-bundle'" class="my-8">
        <POSTerminal 
          :product="product"
          @add-to-cart="handleTerminalAddToCart"
          @complete="handleTerminalComplete"
        />
      </div>
      
      <!-- Day/Night Switcher -->
      <div v-if="product.day_image && product.night_image" class="my-12">
        <h2 class="text-3xl font-heading font-bold text-text-main mb-4">View in Different Lighting</h2>
        <p class="text-lg text-text-muted mb-6">
          See how this illuminated sign looks during the day and when illuminated at night
        </p>
        <DayNightSwitcher
          :day-image="dayImageUrl"
          :night-image="nightImageUrl"
        />
      </div>

      <!-- Before/After Slider -->
      <div v-if="product.before_image && product.after_image" class="my-12">
        <h2 class="text-3xl font-heading font-bold text-text-main mb-4">See the Transformation</h2>
        <p class="text-lg text-text-muted mb-6">
          Drag the slider to compare before and after installation
        </p>
        <BeforeAfterSlider
          :before-image="beforeImageUrl"
          :after-image="afterImageUrl"
        />
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
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import QuoteRequestModal from '@/components/modals/QuoteRequestModal.vue'
import POSTerminal from '@/components/terminal/POSTerminal.vue'
import DayNightSwitcher from '@/components/ui/DayNightSwitcher.vue'
import BeforeAfterSlider from '@/components/ui/BeforeAfterSlider.vue'

const route = useRoute()
const router = useRouter()

const product = ref<any>(null)
const loading = ref(true)
const error = ref('')
const quantity = ref(1)
const showQuoteModal = ref(false)
const currentImage = ref<string | null>(null)

// Helper to convert UUID to Directus assets URL
const getImageUrl = (imageValue: string | undefined | null): string => {
  if (!imageValue) return '/placeholder-product.jpg'
  
  const directusUrl = 'http://localhost:8055'
  
  // Check if it's a UUID (format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
  if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(imageValue)) {
    return `${directusUrl}/assets/${imageValue}`
  }
  
  // Otherwise return as-is (legacy path or URL)
  return imageValue
}

// Computed properties for image URLs
const primaryImageUrl = computed(() => getImageUrl(product.value?.primary_image))
const dayImageUrl = computed(() => getImageUrl(product.value?.day_image))
const nightImageUrl = computed(() => getImageUrl(product.value?.night_image))
const beforeImageUrl = computed(() => getImageUrl(product.value?.before_image))
const afterImageUrl = computed(() => getImageUrl(product.value?.after_image))

// Display image - uses currentImage if set, otherwise primary image
const displayImage = computed(() => {
  if (currentImage.value) {
    return getImageUrl(currentImage.value)
  }
  return primaryImageUrl.value
})

// Detect if this is the terminal product
const isTerminalProduct = computed(() => {
  if (!product.value) return false
  return product.value.slug === 'pos-terminal-gas-station' || 
         product.value.sku?.includes('TERM')
})

const fetchProduct = async () => {
  try {
    loading.value = true
    const productSlug = route.params.slug
    const fields = [
      'id', 'slug', 'name', 'name_de', 'description', 'description_de',
      'price', 'compare_at_price', 'stock', 'customizable', 'illumination_type',
      'lead_time_days', 'primary_image', 'day_image', 'night_image',
      'before_image', 'after_image', 'dimensions_width_cm', 'dimensions_height_cm',
      'dimensions_depth_cm', 'power_consumption_watts', 'ip_rating', 'material',
      'material_de'
    ].join(',')
    
    const response = await fetch(`http://localhost:8055/items/products?filter[slug][_eq]=${productSlug}&fields=${fields}`)
    
    if (!response.ok) {
      throw new Error('Product not found')
    }
    
    const data = await response.json()
    if (data.data && data.data.length > 0) {
      product.value = data.data[0]
    } else {
      throw new Error('Product not found')
    }
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

const handleTerminalAddToCart = (orderData: any) => {
  console.log('Terminal order:', orderData)
  alert(`✅ Terminal Order Complete!\n\nOrder #${orderData.orderNumber}\nTotal: €${orderData.total.toFixed(2)}\n\nProducts added to cart!`)
  // TODO: Implement actual cart logic with Pinia store
}

const handleTerminalComplete = (orderData: any) => {
  console.log('Terminal transaction completed:', orderData)
  // Optionally redirect or show additional confirmation
}

onMounted(() => {
  fetchProduct()
})
</script>
