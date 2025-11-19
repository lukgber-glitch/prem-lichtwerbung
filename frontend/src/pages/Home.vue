<template>
  <div>
    <!-- Hero Section -->
    <section class="relative bg-gradient-to-br from-brand-navy via-brand-navy to-brand-blue text-brand-warm py-32 overflow-hidden">
      <!-- Animated background glow effect -->
      <div class="absolute inset-0 opacity-30">
        <div class="absolute top-1/4 left-1/4 w-96 h-96 bg-brand-blue rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-1/4 right-1/4 w-96 h-96 bg-brand-pink rounded-full blur-3xl animate-pulse" style="animation-delay: 1s;"></div>
      </div>
      
      <div class="container mx-auto px-4 text-center relative z-10">
        <h1 class="text-5xl md:text-7xl font-bold mb-6 font-accent">
          Your Brand Deserves to <span class="text-brand-blue">Shine</span>
        </h1>
        <p class="text-xl md:text-2xl mb-10 max-w-3xl mx-auto">
          Premium illuminated signage that makes you impossible to miss
        </p>
        <ButtonGlow variant="primary" @click="$router.push('/products')" class="text-lg px-10 py-4">
          Explore Products
        </ButtonGlow>
      </div>
    </section>

    <!-- Featured Products Carousel -->
    <section class="container mx-auto px-4 py-20">
      <h2 class="text-4xl font-bold mb-12 text-center font-accent text-brand-navy">
        Featured Products
      </h2>
      
      <div v-if="loading" class="text-center py-12">
        <p class="text-gray-600">Loading featured products...</p>
      </div>

      <div v-else-if="error" class="text-center py-12">
        <p class="text-red-600">{{ error }}</p>
      </div>

      <div v-else class="relative">
        <!-- Carousel Container -->
        <div class="overflow-hidden">
          <div 
            class="flex transition-transform duration-500 ease-in-out gap-6"
            :style="{ transform: `translateX(-${currentSlide * (100 / visibleProducts)}%)` }"
          >
            <div 
              v-for="product in featuredProducts" 
              :key="product.id"
              class="flex-shrink-0"
              :style="{ width: `calc(${100 / visibleProducts}% - ${(visibleProducts - 1) * 1.5 / visibleProducts}rem)` }"
            >
              <ProductCard :product="product" />
            </div>
          </div>
        </div>

        <!-- Navigation Arrows -->
        <button 
          v-if="featuredProducts.length > visibleProducts"
          @click="prevSlide"
          class="absolute left-0 top-1/2 -translate-y-1/2 -translate-x-4 bg-white shadow-lg rounded-full p-3 hover:bg-brand-blue hover:text-white transition-all duration-300 z-10"
          aria-label="Previous products"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </button>
        <button 
          v-if="featuredProducts.length > visibleProducts"
          @click="nextSlide"
          class="absolute right-0 top-1/2 -translate-y-1/2 translate-x-4 bg-white shadow-lg rounded-full p-3 hover:bg-brand-blue hover:text-white transition-all duration-300 z-10"
          aria-label="Next products"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </button>
      </div>
    </section>

    <!-- Category Grid -->
    <section class="bg-brand-gray-light py-20">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold mb-12 text-center font-accent text-brand-navy">
          Explore Our Collections
        </h2>
        
        <div v-if="loadingCategories" class="text-center py-12">
          <p class="text-gray-600">Loading categories...</p>
        </div>

        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <CategoryCard 
            v-for="category in mainCategories" 
            :key="category.id"
            :category="category"
          />
        </div>
      </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="container mx-auto px-4 py-20">
      <h2 class="text-4xl font-bold mb-16 text-center font-accent text-brand-navy">
        Why Choose Prem-Lichtwerbung
      </h2>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <!-- Quality -->
        <div class="text-center p-6 hover:shadow-glow-blue rounded-lg transition-all duration-300">
          <div class="w-20 h-20 mx-auto mb-6 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center">
            <svg class="w-10 h-10 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold mb-3 font-accent">Premium Quality</h3>
          <p class="text-gray-600">
            Highest quality materials and precision craftsmanship in every sign we create
          </p>
        </div>

        <!-- Customization -->
        <div class="text-center p-6 hover:shadow-glow-blue rounded-lg transition-all duration-300">
          <div class="w-20 h-20 mx-auto mb-6 bg-brand-pink bg-opacity-10 rounded-full flex items-center justify-center">
            <svg class="w-10 h-10 text-brand-pink" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold mb-3 font-accent">Full Customization</h3>
          <p class="text-gray-600">
            Tailor every detail to match your brand identity perfectly
          </p>
        </div>

        <!-- Fast Delivery -->
        <div class="text-center p-6 hover:shadow-glow-blue rounded-lg transition-all duration-300">
          <div class="w-20 h-20 mx-auto mb-6 bg-brand-yellow bg-opacity-20 rounded-full flex items-center justify-center">
            <svg class="w-10 h-10 text-brand-yellow" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold mb-3 font-accent">Fast Delivery</h3>
          <p class="text-gray-600">
            Quick turnaround times without compromising on quality
          </p>
        </div>

        <!-- Support -->
        <div class="text-center p-6 hover:shadow-glow-blue rounded-lg transition-all duration-300">
          <div class="w-20 h-20 mx-auto mb-6 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center">
            <svg class="w-10 h-10 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold mb-3 font-accent">Expert Support</h3>
          <p class="text-gray-600">
            Professional guidance from consultation to installation
          </p>
        </div>
      </div>
    </section>

    <!-- Case Studies Preview -->
    <section class="bg-brand-navy py-20">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold mb-4 text-center font-accent text-brand-warm">
          See Our Work in Action
        </h2>
        <p class="text-center text-brand-warm text-lg mb-12">
          Real projects, real results
        </p>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
          <!-- Project 1 -->
          <div class="bg-white rounded-lg overflow-hidden shadow-xl">
            <BeforeAfterSlider 
              before-image="https://via.placeholder.com/600x400/1a1a1a/666666?text=Before"
              after-image="https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28Illuminated%29"
            />
            <div class="p-6">
              <span class="inline-block px-3 py-1 bg-brand-blue text-white text-sm rounded-full mb-3">
                Retail Store
              </span>
              <h3 class="text-xl font-semibold mb-2 font-accent">Downtown Boutique</h3>
              <p class="text-gray-600">
                Custom LED lightbox and channel letters transformed this storefront into a nighttime landmark
              </p>
            </div>
          </div>

          <!-- Project 2 -->
          <div class="bg-white rounded-lg overflow-hidden shadow-xl">
            <BeforeAfterSlider 
              before-image="https://via.placeholder.com/600x400/1a1a1a/666666?text=Before"
              after-image="https://via.placeholder.com/600x400/FF006E/ffffff?text=After+%28Neon%29"
            />
            <div class="p-6">
              <span class="inline-block px-3 py-1 bg-brand-pink text-white text-sm rounded-full mb-3">
                Restaurant
              </span>
              <h3 class="text-xl font-semibold mb-2 font-accent">Urban Bar & Grill</h3>
              <p class="text-gray-600">
                Eye-catching LED neon signage created a vibrant atmosphere and increased foot traffic by 40%
              </p>
            </div>
          </div>

          <!-- Project 3 -->
          <div class="bg-white rounded-lg overflow-hidden shadow-xl">
            <BeforeAfterSlider 
              before-image="https://via.placeholder.com/600x400/1a1a1a/666666?text=Before"
              after-image="https://via.placeholder.com/600x400/FFD600/000000?text=After+%28Pylon%29"
            />
            <div class="p-6">
              <span class="inline-block px-3 py-1 bg-brand-yellow text-brand-navy text-sm rounded-full mb-3">
                Office Complex
              </span>
              <h3 class="text-xl font-semibold mb-2 font-accent">Business Park Gateway</h3>
              <p class="text-gray-600">
                5-meter illuminated pylon provides 24/7 visibility from the highway
              </p>
            </div>
          </div>
        </div>

        <div class="text-center">
          <ButtonGlow variant="secondary" @click="$router.push('/portfolio')">
            View All Projects
          </ButtonGlow>
        </div>
      </div>
    </section>

    <!-- Trust Badges / Statistics -->
    <section class="bg-gradient-to-r from-brand-blue to-brand-pink py-20">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12 text-center text-white">
          <div>
            <div class="text-6xl font-bold mb-3 font-accent drop-shadow-lg">15+</div>
            <div class="text-xl font-semibold mb-2">Years in Business</div>
            <p class="text-brand-warm">
              Trusted expertise in illuminated signage
            </p>
          </div>
          <div>
            <div class="text-6xl font-bold mb-3 font-accent drop-shadow-lg">500+</div>
            <div class="text-xl font-semibold mb-2">Projects Completed</div>
            <p class="text-brand-warm">
              From small signs to large installations
            </p>
          </div>
          <div>
            <div class="text-6xl font-bold mb-3 font-accent drop-shadow-lg">98%</div>
            <div class="text-xl font-semibold mb-2">Satisfied Customers</div>
            <p class="text-brand-warm">
              Quality and service you can count on
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import ProductCard from '@/components/products/ProductCard.vue'
import CategoryCard from '@/components/categories/CategoryCard.vue'
import BeforeAfterSlider from '@/components/ui/BeforeAfterSlider.vue'
import { getProducts } from '@/api/products'
import { getCategories } from '@/api/categories'

const router = useRouter()

// Featured Products Carousel
const featuredProducts = ref<any[]>([])
const loading = ref(false)
const error = ref<string | null>(null)
const currentSlide = ref(0)
const autoScrollInterval = ref<number | null>(null)

// Responsive visible products count
const visibleProducts = ref(4)

// Categories
const mainCategories = ref<any[]>([])
const loadingCategories = ref(false)

// Fetch featured products
const fetchFeaturedProducts = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await getProducts({ 
      filter: { featured: { _eq: true } },
      limit: 6,
      sort: ['-date_created']
    })
    featuredProducts.value = response.data
  } catch (err: any) {
    error.value = err.message || 'Failed to load featured products'
  } finally {
    loading.value = false
  }
}

// Fetch main parent categories (parent_id is null)
const fetchMainCategories = async () => {
  loadingCategories.value = true
  try {
    const response = await getCategories({
      filter: { parent_id: { _null: true } },
      limit: 6,
      sort: ['sort']
    })
    mainCategories.value = response.data
  } catch (err) {
    console.error('Failed to load categories:', err)
  } finally {
    loadingCategories.value = false
  }
}

// Carousel navigation
const nextSlide = () => {
  if (currentSlide.value < featuredProducts.value.length - visibleProducts.value) {
    currentSlide.value++
  } else {
    currentSlide.value = 0
  }
}

const prevSlide = () => {
  if (currentSlide.value > 0) {
    currentSlide.value--
  } else {
    currentSlide.value = Math.max(0, featuredProducts.value.length - visibleProducts.value)
  }
}

// Auto-scroll carousel every 5 seconds
const startAutoScroll = () => {
  autoScrollInterval.value = window.setInterval(() => {
    nextSlide()
  }, 5000)
}

const stopAutoScroll = () => {
  if (autoScrollInterval.value) {
    clearInterval(autoScrollInterval.value)
    autoScrollInterval.value = null
  }
}

// Update visible products based on screen size
const updateVisibleProducts = () => {
  if (window.innerWidth < 768) {
    visibleProducts.value = 1
  } else if (window.innerWidth < 1024) {
    visibleProducts.value = 2
  } else if (window.innerWidth < 1280) {
    visibleProducts.value = 3
  } else {
    visibleProducts.value = 4
  }
}

onMounted(async () => {
  await fetchFeaturedProducts()
  await fetchMainCategories()
  
  // Start auto-scroll if we have enough products
  if (featuredProducts.value.length > visibleProducts.value) {
    startAutoScroll()
  }

  // Setup responsive behavior
  updateVisibleProducts()
  window.addEventListener('resize', updateVisibleProducts)
})

onUnmounted(() => {
  stopAutoScroll()
  window.removeEventListener('resize', updateVisibleProducts)
})
</script>
