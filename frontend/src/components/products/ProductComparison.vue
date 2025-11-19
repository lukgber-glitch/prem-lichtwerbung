<template>
  <div>
    <!-- Fixed Comparison Bar at Bottom (shown when products are selected) -->
    <Transition name="slide-up">
      <div 
        v-if="comparedProducts.length > 0"
        class="fixed bottom-0 left-0 right-0 bg-white border-t-2 border-brand-blue shadow-2xl z-40"
      >
        <div class="container mx-auto px-4 py-4">
          <div class="flex items-center justify-between gap-4">
            <!-- Title and Count -->
            <div class="flex items-center gap-3">
              <div class="bg-brand-blue text-white w-8 h-8 rounded-full flex items-center justify-center font-bold">
                {{ comparedProducts.length }}
              </div>
              <h3 class="font-semibold text-brand-navy">
                Compare Products
                <span class="text-sm text-gray-500 ml-2">({{ comparedProducts.length }}/3)</span>
              </h3>
            </div>

            <!-- Product Thumbnails -->
            <div class="flex items-center gap-3 flex-grow justify-center">
              <div 
                v-for="product in comparedProducts"
                :key="product.id"
                class="relative group"
              >
                <div class="w-16 h-16 bg-gray-100 rounded-lg overflow-hidden border-2 border-brand-blue">
                  <img 
                    :src="product.image || product.day_image || '/placeholder-product.jpg'"
                    :alt="product.name"
                    class="w-full h-full object-cover"
                  />
                </div>
                <!-- Remove button on hover -->
                <button 
                  @click="removeFromComparison(product.id)"
                  class="absolute -top-2 -right-2 bg-red-500 text-white w-6 h-6 rounded-full opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center text-xs font-bold shadow-lg"
                  aria-label="Remove from comparison"
                >
                  ✕
                </button>
              </div>

              <!-- Empty Slots -->
              <div 
                v-for="n in (3 - comparedProducts.length)"
                :key="`empty-${n}`"
                class="w-16 h-16 bg-gray-100 rounded-lg border-2 border-dashed border-gray-300 flex items-center justify-center"
              >
                <svg class="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                </svg>
              </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex items-center gap-3">
              <ButtonGlow 
                variant="primary" 
                @click="showComparisonModal = true"
                :disabled="comparedProducts.length < 2"
              >
                View Comparison
              </ButtonGlow>
              <button 
                @click="clearComparison"
                class="text-sm text-gray-600 hover:text-brand-pink transition-colors font-semibold"
              >
                Clear All
              </button>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Comparison Modal -->
    <Transition name="fade">
      <div 
        v-if="showComparisonModal"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 overflow-y-auto"
        @click.self="showComparisonModal = false"
      >
        <!-- Backdrop -->
        <div 
          class="absolute inset-0 bg-black bg-opacity-50 backdrop-blur-sm"
          @click="showComparisonModal = false"
        ></div>

        <!-- Modal Content -->
        <div 
          class="relative bg-white rounded-xl shadow-2xl w-full max-w-6xl my-8"
          @click.stop
        >
          <!-- Modal Header -->
          <div class="border-b border-gray-200 p-6 flex items-center justify-between">
            <h2 class="text-3xl font-bold font-accent text-brand-navy">Compare Products</h2>
            <button 
              @click="showComparisonModal = false"
              class="text-gray-400 hover:text-gray-600 transition-colors"
              aria-label="Close comparison"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <!-- Comparison Table -->
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead class="bg-brand-gray-light">
                <tr>
                  <th class="sticky left-0 bg-brand-gray-light z-10 px-6 py-4 text-left font-semibold text-brand-navy w-48">
                    Feature
                  </th>
                  <th 
                    v-for="product in comparedProducts"
                    :key="product.id"
                    class="px-6 py-4 text-center border-l border-gray-200"
                  >
                    <!-- Product Header -->
                    <div class="space-y-3">
                      <div class="w-full h-40 bg-gray-100 rounded-lg overflow-hidden">
                        <img 
                          :src="product.image || product.day_image || '/placeholder-product.jpg'"
                          :alt="product.name"
                          class="w-full h-full object-cover"
                        />
                      </div>
                      <h3 class="font-semibold text-brand-navy text-sm line-clamp-2">
                        {{ product.name }}
                      </h3>
                      <!-- Remove Button -->
                      <button 
                        @click="removeFromComparison(product.id)"
                        class="text-xs text-red-500 hover:text-red-700 transition-colors font-semibold"
                      >
                        Remove
                      </button>
                    </div>
                  </th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200">
                <!-- Price -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Price
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`price-${product.id}`"
                    class="px-6 py-4 text-center border-l border-gray-200"
                  >
                    <div class="text-2xl font-bold text-brand-blue">€{{ product.price }}</div>
                    <div v-if="product.compare_at_price" class="text-sm text-gray-400 line-through">
                      €{{ product.compare_at_price }}
                    </div>
                  </td>
                </tr>

                <!-- Dimensions -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Dimensions
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`size-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    <span v-if="product.dimensions_width_cm">
                      {{ product.dimensions_width_cm }}cm × 
                      {{ product.dimensions_height_cm }}cm × 
                      {{ product.dimensions_depth_cm }}cm
                    </span>
                    <span v-else class="text-gray-400">N/A</span>
                  </td>
                </tr>

                <!-- Illumination Type -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Illumination Type
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`illumination-${product.id}`"
                    class="px-6 py-4 text-center border-l border-gray-200"
                  >
                    <span class="inline-block px-3 py-1 bg-brand-yellow bg-opacity-20 text-brand-gray-dark rounded-lg text-sm font-medium">
                      {{ product.illumination_type || 'N/A' }}
                    </span>
                  </td>
                </tr>

                <!-- Lead Time -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Lead Time
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`leadtime-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    <span v-if="product.lead_time_days">{{ product.lead_time_days }} days</span>
                    <span v-else class="text-gray-400">N/A</span>
                  </td>
                </tr>

                <!-- Power Consumption -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Power Consumption
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`power-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    <span v-if="product.power_consumption_watts">{{ product.power_consumption_watts }}W</span>
                    <span v-else class="text-gray-400">N/A</span>
                  </td>
                </tr>

                <!-- Mounting Type -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Mounting Type
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`mounting-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    {{ product.mounting_type || 'N/A' }}
                  </td>
                </tr>

                <!-- Material -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Material
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`material-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    <span v-if="product.material" class="line-clamp-2">{{ product.material }}</span>
                    <span v-else class="text-gray-400">N/A</span>
                  </td>
                </tr>

                <!-- Stock Status -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Stock Status
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`stock-${product.id}`"
                    class="px-6 py-4 text-center border-l border-gray-200"
                  >
                    <span 
                      v-if="product.stock && product.stock > 0"
                      class="inline-flex items-center px-3 py-1 bg-green-100 text-green-800 rounded-full text-xs font-semibold"
                    >
                      <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                      </svg>
                      In Stock
                    </span>
                    <span v-else class="inline-flex items-center px-3 py-1 bg-red-100 text-red-800 rounded-full text-xs font-semibold">
                      Out of Stock
                    </span>
                  </td>
                </tr>

                <!-- Customizable -->
                <tr class="hover:bg-gray-50 transition-colors">
                  <td class="sticky left-0 bg-white z-10 px-6 py-4 font-semibold text-gray-700">
                    Customizable
                  </td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`custom-${product.id}`"
                    class="px-6 py-4 text-center text-sm text-gray-600 border-l border-gray-200"
                  >
                    <span v-if="product.customizable" class="text-brand-blue font-semibold">✓ Yes</span>
                    <span v-else class="text-gray-400">✗ No</span>
                  </td>
                </tr>

                <!-- Action Row -->
                <tr class="bg-brand-gray-light">
                  <td class="sticky left-0 bg-brand-gray-light z-10 px-6 py-4"></td>
                  <td 
                    v-for="product in comparedProducts"
                    :key="`action-${product.id}`"
                    class="px-6 py-4 text-center border-l border-gray-200"
                  >
                    <div class="space-y-2">
                      <ButtonGlow 
                        variant="primary" 
                        @click="addToCart(product)"
                        :disabled="!product.stock || product.stock <= 0"
                        class="w-full"
                      >
                        Add to Cart
                      </ButtonGlow>
                      <router-link 
                        :to="`/products/${product.slug}`"
                        class="block text-sm text-brand-blue hover:text-brand-pink transition-colors font-semibold"
                      >
                        View Details
                      </router-link>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Modal Footer -->
          <div class="border-t border-gray-200 p-6 flex items-center justify-between">
            <button 
              @click="clearComparison"
              class="text-sm text-brand-pink hover:underline font-semibold"
            >
              Clear All Comparisons
            </button>
            <ButtonGlow variant="secondary" @click="showComparisonModal = false">
              Close
            </ButtonGlow>
          </div>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import ButtonGlow from '../ui/ButtonGlow.vue'
import { useCartStore } from '@/store/cart'

const router = useRouter()
const cartStore = useCartStore()

// State
const comparedProducts = ref<any[]>([])
const showComparisonModal = ref(false)

// Maximum products that can be compared
const MAX_COMPARE = 3

// Methods
const addToComparison = (product: any) => {
  // Check if product is already in comparison
  if (comparedProducts.value.some(p => p.id === product.id)) {
    return
  }

  // Check if max limit reached
  if (comparedProducts.value.length >= MAX_COMPARE) {
    alert(`You can only compare up to ${MAX_COMPARE} products at a time`)
    return
  }

  comparedProducts.value.push(product)
}

const removeFromComparison = (productId: number) => {
  comparedProducts.value = comparedProducts.value.filter(p => p.id !== productId)
  
  // Close modal if no products left
  if (comparedProducts.value.length === 0) {
    showComparisonModal.value = false
  }
}

const clearComparison = () => {
  if (confirm('Are you sure you want to clear all comparisons?')) {
    comparedProducts.value = []
    showComparisonModal.value = false
  }
}

const isProductCompared = (productId: number): boolean => {
  return comparedProducts.value.some(p => p.id === productId)
}

const toggleProductComparison = (product: any) => {
  if (isProductCompared(product.id)) {
    removeFromComparison(product.id)
  } else {
    addToComparison(product)
  }
}

const addToCart = (product: any) => {
  cartStore.addItem(product, 1)
  // Optionally show a success message or redirect
  alert(`${product.name} added to cart!`)
}

// Expose methods to parent components
defineExpose({
  addToComparison,
  removeFromComparison,
  isProductCompared,
  toggleProductComparison,
  comparedProducts: computed(() => comparedProducts.value)
})
</script>

<style scoped>
/* Slide up animation for comparison bar */
.slide-up-enter-active, .slide-up-leave-active {
  transition: transform 0.3s ease;
}

.slide-up-enter-from, .slide-up-leave-to {
  transform: translateY(100%);
}

/* Fade animation for modal */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

/* Line clamp utility */
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Sticky column styling */
.sticky {
  position: sticky;
}

/* Custom scrollbar for table */
.overflow-x-auto::-webkit-scrollbar {
  height: 8px;
}

.overflow-x-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.overflow-x-auto::-webkit-scrollbar-thumb {
  background: #00D9FF;
  border-radius: 4px;
}

.overflow-x-auto::-webkit-scrollbar-thumb:hover {
  background: #00b8d9;
}
</style>
