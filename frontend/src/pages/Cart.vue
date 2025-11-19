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
          <li class="text-brand-gray-dark font-semibold">Shopping Cart</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
      <!-- Page Title -->
      <h1 class="text-4xl font-bold mb-8 font-accent text-brand-navy">Your Cart</h1>

      <!-- Empty Cart State -->
      <div v-if="cartItems.length === 0" class="text-center py-20">
        <svg class="w-32 h-32 mx-auto mb-6 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
        </svg>
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">Your cart is empty</h2>
        <p class="text-gray-500 mb-8">Start adding some amazing illuminated signage to your cart!</p>
        <ButtonGlow variant="primary" @click="$router.push('/products')">
          Browse Products
        </ButtonGlow>
      </div>

      <!-- Cart with Items -->
      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Left Column - Cart Items -->
        <div class="lg:col-span-2 space-y-4">
          <!-- Cart Item -->
          <div 
            v-for="item in cartItems"
            :key="item.id"
            class="bg-white rounded-lg shadow-md p-6 flex flex-col sm:flex-row gap-6"
          >
            <!-- Product Image -->
            <router-link 
              :to="`/products/${item.slug}`"
              class="flex-shrink-0 w-full sm:w-32 h-32 bg-gray-100 rounded-lg overflow-hidden"
            >
              <img 
                :src="item.image || item.day_image || '/placeholder-product.jpg'"
                :alt="item.name"
                class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
              />
            </router-link>

            <!-- Product Info -->
            <div class="flex-grow">
              <div class="flex justify-between items-start mb-2">
                <router-link 
                  :to="`/products/${item.slug}`"
                  class="text-xl font-semibold font-accent text-brand-navy hover:text-brand-blue transition-colors"
                >
                  {{ item.name }}
                </router-link>
                
                <!-- Remove Button -->
                <button 
                  @click="removeItem(item.id)"
                  class="text-gray-400 hover:text-red-500 transition-colors ml-4"
                  aria-label="Remove item"
                >
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>

              <!-- Selected Options -->
              <div v-if="item.selectedOptions" class="mb-3 space-y-1">
                <p v-if="item.selectedOptions.includeInstallation" class="text-sm text-gray-600">
                  ✓ Professional Installation (+€{{ item.selectedOptions.installationPrice || 0 }})
                </p>
                <p v-if="item.selectedOptions.selectedOptions" class="text-sm text-gray-600">
                  Custom configuration selected
                </p>
              </div>

              <!-- Price and Quantity -->
              <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <!-- Unit Price -->
                <div>
                  <span class="text-sm text-gray-500">Unit Price:</span>
                  <span class="text-lg font-bold text-brand-blue ml-2">€{{ item.price.toFixed(2) }}</span>
                </div>

                <!-- Quantity Selector -->
                <div class="flex items-center gap-3">
                  <span class="text-sm text-gray-600">Quantity:</span>
                  <div class="flex items-center border border-gray-300 rounded-lg">
                    <button 
                      @click="updateQuantity(item.id, item.quantity - 1)"
                      class="px-3 py-2 hover:bg-gray-100 transition-colors"
                      :disabled="item.quantity <= 1"
                    >
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4" />
                      </svg>
                    </button>
                    <input 
                      :value="item.quantity"
                      @input="updateQuantity(item.id, parseInt(($event.target as HTMLInputElement).value))"
                      type="number" 
                      min="1" 
                      class="w-16 text-center border-x border-gray-300 py-2 focus:outline-none"
                    />
                    <button 
                      @click="updateQuantity(item.id, item.quantity + 1)"
                      class="px-3 py-2 hover:bg-gray-100 transition-colors"
                    >
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                      </svg>
                    </button>
                  </div>
                </div>

                <!-- Subtotal -->
                <div class="text-right">
                  <span class="text-sm text-gray-500">Subtotal:</span>
                  <div class="text-2xl font-bold text-brand-navy">€{{ getItemSubtotal(item).toFixed(2) }}</div>
                </div>
              </div>

              <!-- Stock Warning -->
              <div v-if="item.stock <= 5 && item.stock > 0" class="mt-3">
                <span class="inline-flex items-center px-3 py-1 bg-orange-100 text-orange-800 rounded-full text-xs font-semibold">
                  ⚠️ Only {{ item.stock }} left in stock
                </span>
              </div>
            </div>
          </div>

          <!-- Continue Shopping Button -->
          <div class="pt-4">
            <button 
              @click="$router.push('/products')"
              class="flex items-center gap-2 text-brand-blue hover:text-brand-navy transition-colors font-semibold"
            >
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
              Continue Shopping
            </button>
          </div>
        </div>

        <!-- Right Column - Cart Summary (Sticky on Desktop) -->
        <div class="lg:col-span-1">
          <div class="bg-white rounded-lg shadow-lg p-6 lg:sticky lg:top-8">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Order Summary</h2>

            <!-- Summary Breakdown -->
            <div class="space-y-4 mb-6">
              <!-- Subtotal -->
              <div class="flex justify-between text-gray-700">
                <span>Subtotal ({{ totalItems }} items)</span>
                <span class="font-semibold">€{{ subtotal.toFixed(2) }}</span>
              </div>

              <!-- Installation Costs -->
              <div v-if="installationCost > 0" class="flex justify-between text-gray-700">
                <span>Installation Services</span>
                <span class="font-semibold text-brand-blue">+€{{ installationCost.toFixed(2) }}</span>
              </div>

              <!-- Shipping -->
              <div class="flex justify-between text-gray-700">
                <div>
                  <span>Shipping</span>
                  <p class="text-xs text-gray-500">Calculated at checkout</p>
                </div>
                <span class="font-semibold">
                  {{ shippingEstimate > 0 ? `€${shippingEstimate.toFixed(2)}` : 'TBD' }}
                </span>
              </div>

              <!-- Tax -->
              <div class="flex justify-between text-gray-700">
                <div>
                  <span>Tax ({{ taxRate }}%)</span>
                </div>
                <span class="font-semibold">€{{ taxAmount.toFixed(2) }}</span>
              </div>

              <div class="border-t border-gray-300 pt-4"></div>

              <!-- Total -->
              <div class="flex justify-between items-center">
                <span class="text-xl font-semibold text-brand-navy">Total</span>
                <span class="text-4xl font-bold font-accent text-brand-blue">
                  €{{ total.toFixed(2) }}
                </span>
              </div>
            </div>

            <!-- Proceed to Checkout Button -->
            <ButtonGlow 
              variant="primary" 
              @click="proceedToCheckout"
              class="w-full text-lg py-4 mb-4"
            >
              Proceed to Checkout
            </ButtonGlow>

            <!-- Secure Checkout Badge -->
            <div class="flex items-center justify-center gap-2 text-sm text-gray-600">
              <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
              <span>Secure Checkout</span>
            </div>

            <!-- Promo Code (Placeholder) -->
            <div class="mt-6 pt-6 border-t border-gray-200">
              <details class="group">
                <summary class="flex items-center justify-between cursor-pointer text-sm font-semibold text-brand-navy hover:text-brand-blue transition-colors">
                  <span>Have a promo code?</span>
                  <svg class="w-5 h-5 transition-transform group-open:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                  </svg>
                </summary>
                <div class="mt-4">
                  <div class="flex gap-2">
                    <input 
                      type="text" 
                      placeholder="Enter code"
                      class="flex-grow px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    />
                    <button class="px-4 py-2 bg-brand-navy text-white rounded-lg hover:bg-opacity-90 transition-all font-semibold">
                      Apply
                    </button>
                  </div>
                </div>
              </details>
            </div>

            <!-- Trust Badges -->
            <div class="mt-6 pt-6 border-t border-gray-200 space-y-3">
              <div class="flex items-center gap-3 text-sm text-gray-600">
                <svg class="w-5 h-5 text-brand-blue flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Free shipping on orders over €500</span>
              </div>
              <div class="flex items-center gap-3 text-sm text-gray-600">
                <svg class="w-5 h-5 text-brand-blue flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Professional installation available</span>
              </div>
              <div class="flex items-center gap-3 text-sm text-gray-600">
                <svg class="w-5 h-5 text-brand-blue flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>30-day money-back guarantee</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useCartStore } from '@/store/cart'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const router = useRouter()
const cartStore = useCartStore()

// Computed properties
const cartItems = computed(() => cartStore.items)
const totalItems = computed(() => cartStore.totalItems)
const subtotal = computed(() => cartStore.subtotal)

// Calculate installation costs
const installationCost = computed(() => {
  let total = 0
  cartItems.value.forEach(item => {
    if (item.selectedOptions?.includeInstallation && item.selectedOptions?.installationPrice) {
      total += item.selectedOptions.installationPrice
    } else if (item.selectedOptions?.includeInstallation && item.installation_price) {
      total += item.installation_price
    }
  })
  return total
})

// Shipping estimate (simplified - would be calculated based on items/weight/location)
const shippingEstimate = computed(() => {
  let total = 0
  cartItems.value.forEach(item => {
    if (item.shipping_price) {
      total += item.shipping_price * item.quantity
    }
  })
  // Free shipping over €500
  if (subtotal.value >= 500) {
    return 0
  }
  return total
})

// Tax configuration (would come from settings or user location)
const taxRate = 19 // 19% VAT
const taxAmount = computed(() => {
  const taxableAmount = subtotal.value + installationCost.value + shippingEstimate.value
  return taxableAmount * (taxRate / 100)
})

// Total
const total = computed(() => {
  return subtotal.value + installationCost.value + shippingEstimate.value + taxAmount.value
})

// Methods
const getItemSubtotal = (item: any) => {
  let itemTotal = item.price * item.quantity
  
  // Add installation cost if selected
  if (item.selectedOptions?.includeInstallation) {
    const installPrice = item.selectedOptions?.installationPrice || item.installation_price || 0
    itemTotal += installPrice
  }
  
  // Add custom options cost if present
  if (item.selectedOptions?.totalPrice) {
    itemTotal = item.selectedOptions.totalPrice * item.quantity
  }
  
  return itemTotal
}

const updateQuantity = (itemId: number, newQuantity: number) => {
  if (newQuantity >= 1) {
    cartStore.updateQuantity(itemId, newQuantity)
  }
}

const removeItem = (itemId: number) => {
  if (confirm('Are you sure you want to remove this item from your cart?')) {
    cartStore.removeItem(itemId)
  }
}

const proceedToCheckout = () => {
  router.push('/checkout')
}
</script>
