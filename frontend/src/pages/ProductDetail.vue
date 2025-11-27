<template>
  <div class="min-h-screen bg-white">
    
    <!-- Loading State -->
    <div v-if="loading" class="min-h-screen flex items-center justify-center">
      <div class="text-xl font-light text-black">{{ t('productDetail.loading') }}</div>
    </div>
    
    <!-- Error State -->
    <div v-else-if="error" class="min-h-screen flex items-center justify-center">
      <div class="text-xl font-light text-black">{{ error }}</div>
    </div>
    
    <!-- Product Display - Omnicom Cinematic -->
    <div v-else-if="product">
      
      <!-- HERO SECTION - Full Screen Product Image -->
      <section class="relative min-h-screen flex items-center justify-center bg-black overflow-hidden">
        
        <!-- Background Image - Full Bleed -->
        <div class="absolute inset-0">
          <img 
            :src="displayImage" 
            :alt="product.name"
            class="w-full h-full object-cover opacity-90"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent"></div>
        </div>
        
        <!-- Product Name Overlay - Massive Typography -->
        <div class="relative z-10 text-center px-6 max-w-content mx-auto">
          <h1 class="text-7xl md:text-9xl font-heading font-black text-white mb-8 leading-none tracking-tighter">
            {{ product.name }}
          </h1>
          <p class="text-xl md:text-2xl text-white/80 font-light max-w-2xl mx-auto leading-relaxed">
            {{ product.description }}
          </p>
        </div>
        
        <!-- Price Floating Corner -->
        <div class="absolute top-32 right-6 md:right-32 z-20 text-right">
          <div class="text-5xl md:text-6xl font-black text-white mb-2">
            €{{ Number(product.price).toFixed(2) }}
          </div>
          <div v-if="product.compare_at_price" class="text-xl text-white/60 font-light line-through">
            €{{ Number(product.compare_at_price).toFixed(2) }}
          </div>
        </div>
        
        <!-- Scroll Down Indicator -->
        <div class="absolute bottom-12 left-1/2 -translate-x-1/2 z-20">
          <div class="text-white/60 text-sm font-light animate-bounce">{{ t('productDetail.scroll') }}</div>
        </div>
        
      </section>
      
      <!-- IMAGE GALLERY - Full Bleed Slideshow -->
      <section v-if="hasMultipleImages" class="relative h-screen bg-black">
        <div class="absolute inset-0">
          <img 
            :src="displayImage" 
            :alt="product.name"
            class="w-full h-full object-cover"
          />
        </div>
        
        <!-- Navigation Arrows - Minimal -->
        <div class="absolute inset-0 flex items-center justify-between px-12 z-10">
          <button 
            @click="previousImage"
            class="w-16 h-16 flex items-center justify-center text-white border border-white hover:bg-white hover:text-black transition-all duration-500 cursor-pointer"
          >
            ←
          </button>
          <button 
            @click="nextImage"
            class="w-16 h-16 flex items-center justify-center text-white border border-white hover:bg-white hover:text-black transition-all duration-500 cursor-pointer"
          >
            →
          </button>
        </div>
        
        <!-- Image Indicators -->
        <div class="absolute bottom-12 left-1/2 -translate-x-1/2 flex gap-3 z-10">
          <button 
            v-for="(img, idx) in availableImages" 
            :key="idx"
            @click="currentImageIndex = idx"
            class="w-2 h-2 border border-white transition-all duration-500 cursor-pointer"
            :class="currentImageIndex === idx ? 'bg-white w-8' : 'bg-transparent'"
          ></button>
        </div>
      </section>
      
      <!-- DESCRIPTION - Minimal Single Column -->
      <section class="py-44 bg-white">
        <div class="max-w-text mx-auto px-6">
          <p class="text-lg md:text-xl text-black font-light leading-relaxed">
            {{ product.description }}
          </p>
          
          <!-- Minimal Product Info -->
          <div class="mt-16 pt-16 border-t border-black/10">
            <div class="text-sm font-light text-black/60 mb-2">{{ t('productDetail.illumination') }}</div>
            <div class="text-base text-black mb-8">{{ product.illumination_type || 'LED' }}</div>
            
            <div v-if="product.customizable" class="text-sm font-light text-black/60 mb-2">{{ t('productDetail.customization') }}</div>
            <div v-if="product.customizable" class="text-base text-black mb-8">{{ t('productDetail.availableOnRequest') }}</div>
          </div>
        </div>
      </section>
      
      <!-- TECHNICAL SPECS - Floating Minimal List -->
      <section class="py-44 bg-black">
        <div class="max-w-content mx-auto px-6 md:px-32">
          <h2 class="text-5xl md:text-6xl font-heading font-bold text-white mb-20 leading-tight">
            {{ t('productDetail.specifications') }}
          </h2>
          
          <div class="grid md:grid-cols-3 gap-x-20 gap-y-12">
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.dimensions') }}</div>
              <div class="text-lg text-white font-light">
                {{ product.dimensions_width_cm || 100 }} × 
                {{ product.dimensions_height_cm || 70 }} × 
                {{ product.dimensions_depth_cm || 8 }} cm
              </div>
            </div>
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.power') }}</div>
              <div class="text-lg text-white font-light">{{ product.power_consumption_watts || 45 }}W</div>
            </div>
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.rating') }}</div>
              <div class="text-lg text-white font-light">{{ product.ip_rating || 'IP44' }}</div>
            </div>
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.material') }}</div>
              <div class="text-lg text-white font-light">{{ product.material || 'Premium acrylic with aluminum' }}</div>
            </div>
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.leadTime') }}</div>
              <div class="text-lg text-white font-light">{{ product.lead_time_days || 7 }}-{{ (product.lead_time_days || 7) + 7 }} {{ t('productDetail.days') }}</div>
            </div>
            <div>
              <div class="text-sm font-light text-white/40 mb-3">{{ t('productDetail.stock') }}</div>
              <div class="text-lg text-white font-light">{{ product.stock > 0 ? `${product.stock} ${t('productDetail.available')}` : t('productDetail.madeToOrder') }}</div>
            </div>
          </div>
        </div>
      </section>
      
      <!-- DAY/NIGHT COMPARISON - Full Screen -->
      <section v-if="product.day_image && product.night_image" class="py-44 bg-white">
        <div class="max-w-content mx-auto px-6 md:px-32 mb-16">
          <h2 class="text-5xl md:text-6xl font-heading font-bold text-black leading-tight">
            {{ t('productDetail.dayNight') }}
          </h2>
        </div>
        <DayNightSwitcher
          :day-image="dayImageUrl"
          :night-image="nightImageUrl"
        />
      </section>

      <!-- BEFORE/AFTER - Full Screen -->
      <section v-if="product.before_image && product.after_image" class="py-44 bg-white">
        <div class="max-w-content mx-auto px-6 md:px-32 mb-16">
          <h2 class="text-5xl md:text-6xl font-heading font-bold text-black leading-tight">
            {{ t('productDetail.transformation') }}
          </h2>
        </div>
        <BeforeAfterSlider
          :before-image="beforeImageUrl"
          :after-image="afterImageUrl"
        />
      </section>
      
      <!-- TERMINAL DEMO LINK - Minimal -->
      <section v-if="isTerminalProduct" class="py-44 bg-black">
        <div class="max-w-content mx-auto px-6 md:px-32 text-center">
          <h2 class="text-5xl md:text-7xl font-heading font-black text-white mb-12 leading-none">
            {{ t('productDetail.interactiveDemo') }}
          </h2>
          <p class="text-xl text-white/60 font-light mb-16 max-w-2xl mx-auto">
            {{ t('productDetail.experienceTerminal') }}
          </p>
          <router-link 
            to="/terminal-demo" 
            class="inline-block px-16 py-6 bg-transparent text-white text-lg font-semibold border-2 border-white hover:bg-white hover:text-black transition-all duration-500 cursor-pointer"
          >
            {{ t('productDetail.tryDemo') }}
          </router-link>
        </div>
      </section>
      
      <!-- CTA SECTION - Sticky Bottom -->
      <section class="fixed bottom-0 left-0 right-0 bg-white border-t border-black/10 z-40 py-6">
        <div class="max-w-content mx-auto px-6 md:px-32 flex flex-col md:flex-row items-center justify-between gap-4">
          
          <!-- Quantity -->
          <div class="flex items-center gap-4">
            <label class="text-black font-light text-sm">{{ t('productDetail.quantity') }}</label>
            <input 
              v-model.number="quantity"
              type="number" 
              min="1" 
              :max="product.stock || 999"
              class="w-20 px-4 py-2 border border-black/20 bg-white text-black font-light"
            />
          </div>
          
          <!-- Price Total -->
          <div class="text-3xl font-bold text-black">
            €{{ (product.price * quantity).toFixed(2) }}
          </div>
          
          <!-- Add to Cart Button -->
          <button 
            @click="addToCart"
            :disabled="product.stock === 0"
            class="px-12 py-4 bg-black text-white text-base font-semibold hover:bg-white hover:text-black border-2 border-black transition-all duration-500 cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {{ addedToCart ? t('productDetail.addedToCart') : (product.stock > 0 ? t('productDetail.addToCart') : t('productDetail.requestQuote')) }}
          </button>
          
        </div>
      </section>
      
    </div>
    
    <QuoteRequestModal :is-open="showQuoteModal" :prefilled-product="product?.name" @close="showQuoteModal = false" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useCart } from '@/composables/useCart'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import QuoteRequestModal from '@/components/modals/QuoteRequestModal.vue'
import POSTerminal from '@/components/terminal/POSTerminal.vue'
import DayNightSwitcher from '@/components/ui/DayNightSwitcher.vue'
import BeforeAfterSlider from '@/components/ui/BeforeAfterSlider.vue'

const { t } = useI18n()
const route = useRoute()
const router = useRouter()
const { addToCart: addToCartComposable } = useCart()

const product = ref<any>(null)
const loading = ref(true)
const error = ref('')
const quantity = ref(1)
const showQuoteModal = ref(false)
const currentImage = ref<string | null>(null)
const currentImageIndex = ref(0)
const addedToCart = ref(false)

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

// Available images array for gallery
const availableImages = computed(() => {
  if (!product.value) return []
  const images = [
    product.value.primary_image,
    product.value.day_image,
    product.value.night_image,
    product.value.after_image
  ].filter(img => img !== null && img !== undefined)
  return images
})

// Check if product has multiple images
const hasMultipleImages = computed(() => availableImages.value.length > 1)

// Display image - uses currentImageIndex for gallery navigation
const displayImage = computed(() => {
  if (availableImages.value.length > 0 && currentImageIndex.value < availableImages.value.length) {
    return getImageUrl(availableImages.value[currentImageIndex.value])
  }
  return primaryImageUrl.value
})

// Detect if this is the terminal product
const isTerminalProduct = computed(() => {
  if (!product.value) return false
  return product.value.slug === 'pos-terminal-gas-station' || 
         product.value.sku?.includes('TERM')
})

// Image gallery navigation
const previousImage = () => {
  if (availableImages.value.length === 0) return
  currentImageIndex.value = (currentImageIndex.value - 1 + availableImages.value.length) % availableImages.value.length
}

const nextImage = () => {
  if (availableImages.value.length === 0) return
  currentImageIndex.value = (currentImageIndex.value + 1) % availableImages.value.length
}

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
  if (product.value) {
    addToCartComposable({
      id: product.value.id,
      name: product.value.name,
      price: product.value.price,
      image: product.value.primary_image || product.value.day_image,
      slug: product.value.slug
    }, quantity.value)
    
    // Show visual feedback
    addedToCart.value = true
    setTimeout(() => {
      addedToCart.value = false
    }, 2000)
  }
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
