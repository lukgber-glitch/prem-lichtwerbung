<template>
  <div>
    <!-- Breadcrumbs -->
    <nav class="bg-brand-gray-light py-4">
      <div class="container mx-auto px-4">
        <ol class="flex items-center space-x-2 text-sm">
          <li>
            <router-link to="/" class="text-brand-navy hover:text-brand-blue transition-colors">
              Home
            </router-link>
          </li>
          <li class="text-gray-400">/</li>
          <li>
            <router-link to="/products" class="text-brand-navy hover:text-brand-blue transition-colors">
              Products
            </router-link>
          </li>
          <li class="text-gray-400">/</li>
          <li class="text-brand-gray-dark font-semibold">{{ product?.name || 'Loading...' }}</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
      <!-- Loading State -->
      <div v-if="loading" class="text-center py-20">
        <div class="inline-block animate-spin rounded-full h-16 w-16 border-4 border-brand-blue border-t-transparent"></div>
        <p class="text-gray-600 mt-4 text-lg">Loading product details...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="text-center py-20">
        <p class="text-red-600 text-xl mb-4">{{ error }}</p>
        <p class="text-gray-600 mb-6">The product you're looking for could not be found.</p>
        <ButtonGlow variant="primary" @click="$router.push('/products')">
          Back to Products
        </ButtonGlow>
      </div>

      <!-- Product Details -->
      <div v-else-if="product" class="max-w-7xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 mb-12">
          <!-- LEFT COLUMN - IMAGE GALLERY -->
          <div class="space-y-4">
            <!-- Main Image -->
            <div class="relative aspect-square bg-white rounded-lg overflow-hidden shadow-lg group">
              <img 
                :src="currentImage"
                :alt="product.name"
                class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
              />
              
              <!-- Day/Night Toggle -->
              <div v-if="product.day_image && product.night_image" class="absolute top-4 right-4 bg-white rounded-lg shadow-lg p-2 flex gap-2">
                <button 
                  @click="showDayImage = true"
                  :class="[
                    'px-4 py-2 rounded-lg transition-all text-sm font-semibold',
                    showDayImage ? 'bg-brand-blue text-white' : 'text-gray-600 hover:bg-gray-100'
                  ]"
                >
                  ☀️ Day
                </button>
                <button 
                  @click="showDayImage = false"
                  :class="[
                    'px-4 py-2 rounded-lg transition-all text-sm font-semibold',
                    !showDayImage ? 'bg-brand-navy text-white' : 'text-gray-600 hover:bg-gray-100'
                  ]"
                >
                  🌙 Night
                </button>
              </div>

              <!-- Fullscreen Button -->
              <button 
                @click="showFullscreen = true"
                class="absolute bottom-4 right-4 bg-white bg-opacity-90 hover:bg-opacity-100 rounded-lg p-3 shadow-lg transition-all"
                aria-label="View fullscreen"
              >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4" />
                </svg>
              </button>
            </div>

            <!-- Thumbnail Gallery -->
            <div v-if="allImages.length > 1" class="grid grid-cols-5 gap-2">
              <button 
                v-for="(img, index) in allImages"
                :key="index"
                @click="selectImage(img, index)"
                :class="[
                  'aspect-square rounded-lg overflow-hidden border-2 transition-all',
                  selectedImageIndex === index ? 'border-brand-blue shadow-glow-blue' : 'border-gray-200 hover:border-brand-blue'
                ]"
              >
                <img :src="img" :alt="`${product.name} - Image ${index + 1}`" class="w-full h-full object-cover" />
              </button>
            </div>

            <!-- Video Embed -->
            <div v-if="product.video_url" class="aspect-video rounded-lg overflow-hidden shadow-lg">
              <iframe 
                :src="getEmbedUrl(product.video_url)"
                class="w-full h-full"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
              ></iframe>
            </div>
          </div>

          <!-- RIGHT COLUMN - PRODUCT INFO -->
          <div class="space-y-6">
            <!-- Product Name -->
            <h1 class="text-4xl md:text-5xl font-bold font-accent text-brand-navy">
              {{ product.name }}
            </h1>

            <!-- Price -->
            <div class="flex items-baseline gap-4 flex-wrap">
              <span class="text-5xl font-bold text-brand-blue">€{{ product.price }}</span>
              <span v-if="product.compare_at_price" class="text-2xl text-gray-400 line-through">
                €{{ product.compare_at_price }}
              </span>
              <span v-if="product.compare_at_price" class="px-3 py-1 bg-brand-pink text-white rounded-full text-sm font-semibold">
                Save €{{ (product.compare_at_price - product.price).toFixed(2) }}
              </span>
            </div>

            <!-- Stock & Lead Time Badges -->
            <div class="flex flex-wrap gap-3">
              <span 
                v-if="product.stock && product.stock > 0"
                class="inline-flex items-center px-4 py-2 bg-green-100 text-green-800 rounded-full text-sm font-semibold"
              >
                <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                In Stock
              </span>
              <span v-else class="inline-flex items-center px-4 py-2 bg-red-100 text-red-800 rounded-full text-sm font-semibold">
                <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
                Out of Stock
              </span>

              <span v-if="product.lead_time_days" class="inline-flex items-center px-4 py-2 bg-brand-blue bg-opacity-10 text-brand-navy rounded-full text-sm font-semibold">
                ⏱️ Ready in {{ product.lead_time_days }}-{{ product.lead_time_days + 3 }} days
              </span>
            </div>

            <!-- Description -->
            <div class="prose prose-lg">
              <p class="text-gray-700 leading-relaxed">{{ product.description }}</p>
            </div>

            <!-- Product Badges -->
            <div class="flex flex-wrap gap-2">
              <span v-if="product.illumination_type" class="px-3 py-1 bg-brand-yellow bg-opacity-20 text-brand-gray-dark rounded-lg text-sm font-medium">
                💡 {{ product.illumination_type }}
              </span>
              <span v-if="product.mounting_type" class="px-3 py-1 bg-brand-blue bg-opacity-10 text-brand-navy rounded-lg text-sm font-medium">
                🔧 {{ product.mounting_type }}
              </span>
              <template v-if="product.suitable_for && product.suitable_for.length > 0">
                <span 
                  v-for="location in product.suitable_for" 
                  :key="location"
                  class="px-3 py-1 bg-brand-pink bg-opacity-10 text-brand-pink rounded-lg text-sm font-medium"
                >
                  📍 {{ location }}
                </span>
              </template>
            </div>

            <!-- Terminal Bundle Special CTA (Hardcoded for pos-terminal-menu-board-bundle) -->
            <div 
              v-if="product.slug === 'pos-terminal-menu-board-bundle'" 
              class="bg-gradient-to-r from-brand-blue to-brand-pink p-8 rounded-lg shadow-glow-blue my-8"
            >
              <h3 class="text-3xl font-accent font-bold text-white mb-4">
                🔥 Limited Time Offer: Hardware + Software Bundle
              </h3>
              <p class="text-lg text-brand-warm mb-6">
                Save <span class="text-4xl font-bold text-brand-yellow">20%</span> when you combine our POS terminal with illuminated signage!
              </p>
              <ul class="text-white mb-6 space-y-2">
                <li>✅ Complete POS terminal with touchscreen</li>
                <li>✅ Custom LED-backlit menu board (120x80cm)</li>
                <li>✅ FREE installation (€300 value)</li>
                <li>✅ FREE software setup & training</li>
                <li>✅ 3-year warranty on hardware</li>
              </ul>
              <div class="flex gap-4">
                <ButtonGlow variant="accent" class="text-lg">
                  Get This Bundle for €1,899
                </ButtonGlow>
                <ButtonGlow variant="secondary">
                  Request Custom Quote
                </ButtonGlow>
              </div>
            </div>

            <!-- Customization Section -->
            <div v-if="product.customizable" class="bg-brand-gray-light rounded-lg p-6">
              <h3 class="text-2xl font-bold mb-4 font-accent text-brand-navy">Customize Your Sign</h3>
              <PriceCalculator 
                :product="product"
                :base-price="product.price"
                @add-to-cart="handleCustomAddToCart"
                @request-quote="showQuoteModal = true"
              />
            </div>

            <!-- Add to Cart Section -->
            <div class="bg-white rounded-lg border-2 border-brand-blue p-6 space-y-4">
              <!-- Quantity Selector -->
              <div>
                <label class="block text-sm font-semibold mb-2 text-brand-navy">Quantity</label>
                <div class="flex items-center gap-3">
                  <button 
                    @click="quantity > 1 && quantity--"
                    class="w-12 h-12 border-2 border-gray-300 rounded-lg hover:bg-gray-100 font-bold text-xl transition-all"
                    :disabled="quantity <= 1"
                  >
                    −
                  </button>
                  <input 
                    v-model.number="quantity" 
                    type="number" 
                    min="1" 
                    class="w-20 h-12 text-center border-2 border-gray-300 rounded-lg text-xl font-semibold"
                  />
                  <button 
                    @click="quantity++"
                    class="w-12 h-12 border-2 border-gray-300 rounded-lg hover:bg-gray-100 font-bold text-xl transition-all"
                  >
                    +
                  </button>
                </div>
              </div>

              <!-- Installation Checkbox -->
              <div v-if="product.installation_price" class="flex items-center">
                <input 
                  v-model="includeInstallation"
                  type="checkbox" 
                  id="installation"
                  class="w-5 h-5 text-brand-blue border-gray-300 rounded focus:ring-brand-blue"
                />
                <label for="installation" class="ml-3 text-gray-700">
                  Add Professional Installation 
                  <span class="font-semibold text-brand-navy">+€{{ product.installation_price }}</span>
                </label>
              </div>

              <!-- Total Price -->
              <div class="pt-4 border-t border-gray-200">
                <div class="flex justify-between items-center mb-4">
                  <span class="text-lg text-gray-600">Total:</span>
                  <span class="text-3xl font-bold text-brand-blue">€{{ totalPrice.toFixed(2) }}</span>
                </div>

                <!-- Action Buttons -->
                <div class="space-y-3">
                  <ButtonGlow 
                    variant="primary" 
                    @click="handleAddToCart"
                    :disabled="!product.stock || product.stock <= 0"
                    class="w-full text-lg py-4"
                  >
                    Add to Cart
                  </ButtonGlow>
                  <ButtonGlow 
                    variant="secondary" 
                    @click="addToWishlist"
                    class="w-full text-lg py-4"
                  >
                    ♥ Add to Wishlist
                  </ButtonGlow>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Tabbed Sections -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden mb-12">
          <!-- Tab Headers -->
          <div class="flex border-b">
            <button 
              v-for="tab in tabs"
              :key="tab.id"
              @click="activeTab = tab.id"
              :class="[
                'flex-1 px-6 py-4 font-semibold transition-all',
                activeTab === tab.id 
                  ? 'bg-brand-blue text-white' 
                  : 'bg-gray-50 text-gray-600 hover:bg-gray-100'
              ]"
            >
              {{ tab.label }}
            </button>
          </div>

          <!-- Tab Content -->
          <div class="p-8">
            <!-- Technical Specs Tab -->
            <div v-if="activeTab === 'specs'" class="space-y-4">
              <h3 class="text-2xl font-bold mb-6 font-accent">Technical Specifications</h3>
              <table class="w-full">
                <tbody class="divide-y divide-gray-200">
                  <tr v-if="product.dimensions_width_cm">
                    <td class="py-3 text-gray-600 font-medium">Dimensions (W × H × D)</td>
                    <td class="py-3 text-brand-navy font-semibold">
                      {{ product.dimensions_width_cm }}cm × {{ product.dimensions_height_cm }}cm × {{ product.dimensions_depth_cm }}cm
                    </td>
                  </tr>
                  <tr v-if="product.power_consumption_watts">
                    <td class="py-3 text-gray-600 font-medium">Power Consumption</td>
                    <td class="py-3 text-brand-navy font-semibold">{{ product.power_consumption_watts }}W</td>
                  </tr>
                  <tr v-if="product.ip_rating">
                    <td class="py-3 text-gray-600 font-medium">IP Rating</td>
                    <td class="py-3 text-brand-navy font-semibold">{{ product.ip_rating }}</td>
                  </tr>
                  <tr v-if="product.material">
                    <td class="py-3 text-gray-600 font-medium">Material</td>
                    <td class="py-3 text-brand-navy font-semibold">{{ product.material }}</td>
                  </tr>
                  <tr v-if="product.weight">
                    <td class="py-3 text-gray-600 font-medium">Weight</td>
                    <td class="py-3 text-brand-navy font-semibold">{{ product.weight }}kg</td>
                  </tr>
                  <tr v-if="product.power_supply_included !== null">
                    <td class="py-3 text-gray-600 font-medium">Power Supply Included</td>
                    <td class="py-3 text-brand-navy font-semibold">{{ product.power_supply_included ? 'Yes' : 'No' }}</td>
                  </tr>
                </tbody>
              </table>

              <div v-if="product.technical_sheet_pdf" class="mt-6">
                <ButtonGlow variant="secondary" @click="downloadPDF">
                  📄 Download Technical Sheet (PDF)
                </ButtonGlow>
              </div>
            </div>

            <!-- Installation & Delivery Tab -->
            <div v-if="activeTab === 'installation'" class="space-y-6">
              <h3 class="text-2xl font-bold mb-6 font-accent">Installation & Delivery</h3>
              
              <div class="prose prose-lg max-w-none">
                <h4 class="text-xl font-semibold text-brand-navy">Delivery Information</h4>
                <ul class="space-y-2">
                  <li>Lead time: {{ product.lead_time_days }}-{{ product.lead_time_days + 3 }} business days</li>
                  <li>Shipping cost: {{ product.shipping_price > 0 ? `€${product.shipping_price}` : 'FREE' }}</li>
                  <li>We ship throughout Europe</li>
                  <li>Track your order status online</li>
                </ul>

                <h4 class="text-xl font-semibold text-brand-navy mt-6">Installation Guide</h4>
                <p>This product requires professional installation for optimal performance and safety.</p>
                <ul class="space-y-2">
                  <li>Mounting hardware included</li>
                  <li>Professional installation recommended</li>
                  <li>Installation service available: €{{ product.installation_price || 0 }}</li>
                  <li>Electrical work must be performed by licensed electrician</li>
                </ul>
              </div>
            </div>

            <!-- Reviews Tab -->
            <div v-if="activeTab === 'reviews'" class="space-y-6">
              <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl font-bold font-accent">Customer Reviews</h3>
                <ButtonGlow variant="secondary" @click="showReviewModal = true">
                  Write a Review
                </ButtonGlow>
              </div>

              <div class="bg-brand-gray-light rounded-lg p-6 text-center">
                <p class="text-gray-600">No reviews yet. Be the first to review this product!</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Related Products -->
        <div class="mb-12">
          <h2 class="text-3xl font-bold mb-8 font-accent text-brand-navy">You May Also Like</h2>
          <div v-if="relatedProducts.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <ProductCard 
              v-for="relatedProduct in relatedProducts"
              :key="relatedProduct.id"
              :product="relatedProduct"
            />
          </div>
          <div v-else class="text-center py-12 text-gray-500">
            No related products available
          </div>
        </div>
      </div>
    </div>

    <!-- Fullscreen Image Modal -->
    <Transition name="fade">
      <div 
        v-if="showFullscreen"
        class="fixed inset-0 z-50 bg-black bg-opacity-95 flex items-center justify-center p-4"
        @click="showFullscreen = false"
      >
        <button 
          class="absolute top-4 right-4 text-white hover:text-brand-blue transition-colors"
          @click="showFullscreen = false"
        >
          <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        <img 
          :src="currentImage"
          :alt="product?.name"
          class="max-w-full max-h-full object-contain"
          @click.stop
        />
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import ProductCard from '@/components/products/ProductCard.vue'
import PriceCalculator from '@/components/products/PriceCalculator.vue'
import { getProducts } from '@/api/products'
import { useCartStore } from '@/store/cart'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()

// State
const product = ref<any>(null)
const loading = ref(false)
const error = ref<string | null>(null)
const quantity = ref(1)
const includeInstallation = ref(false)
const showDayImage = ref(true)
const showFullscreen = ref(false)
const activeTab = ref('specs')
const relatedProducts = ref<any[]>([])
const selectedImageIndex = ref(0)
const showQuoteModal = ref(false)
const showReviewModal = ref(false)

// Tabs
const tabs = [
  { id: 'specs', label: 'Technical Specs' },
  { id: 'installation', label: 'Installation & Delivery' },
  { id: 'reviews', label: 'Reviews' }
]

// Computed
const currentImage = computed(() => {
  if (product.value) {
    const images = allImages.value
    if (images.length > 0 && selectedImageIndex.value < images.length) {
      return images[selectedImageIndex.value]
    }
    
    if (showDayImage.value && product.value.day_image) {
      return product.value.day_image
    } else if (!showDayImage.value && product.value.night_image) {
      return product.value.night_image
    } else if (product.value.image) {
      return product.value.image
    }
  }
  return 'https://via.placeholder.com/600x600/F5F5F5/999999?text=No+Image'
})

const allImages = computed(() => {
  const images: string[] = []
  if (product.value) {
    if (product.value.day_image) images.push(product.value.day_image)
    if (product.value.night_image) images.push(product.value.night_image)
    if (product.value.image && !images.includes(product.value.image)) {
      images.push(product.value.image)
    }
    // Add gallery images if available
    if (product.value.gallery && Array.isArray(product.value.gallery)) {
      product.value.gallery.forEach((img: any) => {
        if (typeof img === 'string' && !images.includes(img)) {
          images.push(img)
        }
      })
    }
  }
  return images
})

const totalPrice = computed(() => {
  let total = product.value?.price * quantity.value || 0
  if (includeInstallation.value && product.value?.installation_price) {
    total += product.value.installation_price
  }
  return total
})

// Methods
const loadProduct = async (slug: string) => {
  loading.value = true
  error.value = null
  
  try {
    const response = await getProducts({
      filter: { slug: { _eq: slug }, status: { _eq: 'published' } },
      limit: 1
    })
    
    if (response.data && response.data.length > 0) {
      product.value = response.data[0]
      await loadRelatedProducts()
    } else {
      error.value = 'Product not found'
    }
  } catch (err: any) {
    error.value = err.message || 'Failed to load product'
  } finally {
    loading.value = false
  }
}

const loadRelatedProducts = async () => {
  if (!product.value) return
  
  try {
    const response = await getProducts({
      filter: {
        status: { _eq: 'published' },
        id: { _neq: product.value.id },
        _or: [
          { illumination_type: { _eq: product.value.illumination_type } },
          { mounting_type: { _eq: product.value.mounting_type } }
        ]
      },
      limit: 4,
      sort: ['-featured', '-date_created']
    })
    
    relatedProducts.value = response.data
  } catch (err) {
    console.error('Failed to load related products:', err)
  }
}

const selectImage = (img: string, index: number) => {
  selectedImageIndex.value = index
  
  // Update day/night toggle if applicable
  if (product.value) {
    if (img === product.value.day_image) {
      showDayImage.value = true
    } else if (img === product.value.night_image) {
      showDayImage.value = false
    }
  }
}

const getEmbedUrl = (url: string) => {
  if (url.includes('youtube.com/watch')) {
    const videoId = url.split('v=')[1]?.split('&')[0]
    return `https://www.youtube.com/embed/${videoId}`
  }
  return url
}

const handleAddToCart = () => {
  if (product.value) {
    const cartItem = {
      ...product.value,
      selectedOptions: {
        includeInstallation: includeInstallation.value,
        installationPrice: includeInstallation.value ? product.value.installation_price : 0
      }
    }
    cartStore.addItem(cartItem, quantity.value)
    
    // Reset
    quantity.value = 1
    includeInstallation.value = false
  }
}

const handleCustomAddToCart = (customData: any) => {
  if (product.value) {
    const cartItem = {
      ...product.value,
      selectedOptions: customData
    }
    cartStore.addItem(cartItem, 1)
  }
}

const addToWishlist = () => {
  alert('Added to wishlist! (Feature coming soon)')
}

const downloadPDF = () => {
  if (product.value?.technical_sheet_pdf) {
    window.open(product.value.technical_sheet_pdf, '_blank')
  }
}

onMounted(() => {
  const slug = route.params.slug as string
  loadProduct(slug)
})
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

.prose ul {
  list-style-type: disc;
  padding-left: 1.5rem;
}

.prose ul li {
  margin-top: 0.5rem;
}
</style>
