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
            <router-link to="/cart" class="text-brand-navy hover:text-brand-blue transition-colors">
              Cart
            </router-link>
          </li>
          <li class="text-gray-400">/</li>
          <li class="text-brand-gray-dark font-semibold">Checkout</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
      <!-- Progress Indicator -->
      <div class="mb-12">
        <div class="flex items-center justify-center">
          <div class="flex items-center">
            <!-- Step 1: Cart -->
            <div class="flex items-center">
              <div class="flex items-center justify-center w-10 h-10 rounded-full bg-green-500 text-white font-semibold">
                ✓
              </div>
              <span class="ml-2 text-sm font-medium text-gray-900">Cart</span>
            </div>
            
            <div class="w-16 h-1 mx-2 bg-brand-blue"></div>
            
            <!-- Step 2: Information -->
            <div class="flex items-center">
              <div class="flex items-center justify-center w-10 h-10 rounded-full bg-brand-blue text-white font-semibold">
                2
              </div>
              <span class="ml-2 text-sm font-medium text-brand-blue">Information</span>
            </div>
            
            <div class="w-16 h-1 mx-2 bg-gray-300"></div>
            
            <!-- Step 3: Payment -->
            <div class="flex items-center">
              <div class="flex items-center justify-center w-10 h-10 rounded-full bg-gray-300 text-gray-600 font-semibold">
                3
              </div>
              <span class="ml-2 text-sm font-medium text-gray-500">Payment</span>
            </div>
            
            <div class="w-16 h-1 mx-2 bg-gray-300"></div>
            
            <!-- Step 4: Complete -->
            <div class="flex items-center">
              <div class="flex items-center justify-center w-10 h-10 rounded-full bg-gray-300 text-gray-600 font-semibold">
                4
              </div>
              <span class="ml-2 text-sm font-medium text-gray-500">Complete</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Main Checkout Layout -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Left & Middle Columns - Forms -->
        <div class="lg:col-span-2 space-y-8">
          <!-- Customer Information -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Customer Information</h2>
            
            <div class="space-y-4">
              <div>
                <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                  Email Address *
                </label>
                <input 
                  v-model="form.email"
                  type="email" 
                  id="email"
                  required
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="your@email.com"
                />
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label for="firstName" class="block text-sm font-semibold text-gray-700 mb-2">
                    First Name *
                  </label>
                  <input 
                    v-model="form.firstName"
                    type="text" 
                    id="firstName"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="John"
                  />
                </div>

                <div>
                  <label for="lastName" class="block text-sm font-semibold text-gray-700 mb-2">
                    Last Name *
                  </label>
                  <input 
                    v-model="form.lastName"
                    type="text" 
                    id="lastName"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="Doe"
                  />
                </div>
              </div>

              <div>
                <label for="phone" class="block text-sm font-semibold text-gray-700 mb-2">
                  Phone Number *
                </label>
                <input 
                  v-model="form.phone"
                  type="tel" 
                  id="phone"
                  required
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="+49 123 456789"
                />
              </div>

              <div class="flex items-center">
                <input 
                  v-model="form.createAccount"
                  type="checkbox" 
                  id="createAccount"
                  class="w-5 h-5 text-brand-blue border-gray-300 rounded focus:ring-brand-blue"
                />
                <label for="createAccount" class="ml-3 text-sm text-gray-700">
                  Create an account for faster checkout next time
                </label>
              </div>
            </div>
          </div>

          <!-- Shipping Address -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Shipping Address</h2>
            
            <div class="space-y-4">
              <div>
                <label for="shippingAddress1" class="block text-sm font-semibold text-gray-700 mb-2">
                  Address Line 1 *
                </label>
                <input 
                  v-model="form.shipping.address1"
                  type="text" 
                  id="shippingAddress1"
                  required
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="Street address"
                />
              </div>

              <div>
                <label for="shippingAddress2" class="block text-sm font-semibold text-gray-700 mb-2">
                  Address Line 2
                </label>
                <input 
                  v-model="form.shipping.address2"
                  type="text" 
                  id="shippingAddress2"
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="Apartment, suite, etc. (optional)"
                />
              </div>

              <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label for="shippingCity" class="block text-sm font-semibold text-gray-700 mb-2">
                    City *
                  </label>
                  <input 
                    v-model="form.shipping.city"
                    type="text" 
                    id="shippingCity"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="Berlin"
                  />
                </div>

                <div>
                  <label for="shippingPostalCode" class="block text-sm font-semibold text-gray-700 mb-2">
                    Postal Code *
                  </label>
                  <input 
                    v-model="form.shipping.postalCode"
                    type="text" 
                    id="shippingPostalCode"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="10115"
                  />
                </div>

                <div>
                  <label for="shippingCountry" class="block text-sm font-semibold text-gray-700 mb-2">
                    Country *
                  </label>
                  <select 
                    v-model="form.shipping.country"
                    id="shippingCountry"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  >
                    <option value="">Select country</option>
                    <option value="DE">Germany</option>
                    <option value="AT">Austria</option>
                    <option value="CH">Switzerland</option>
                    <option value="NL">Netherlands</option>
                    <option value="BE">Belgium</option>
                    <option value="FR">France</option>
                  </select>
                </div>
              </div>
            </div>
          </div>

          <!-- Billing Address -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex items-center justify-between mb-6">
              <h2 class="text-2xl font-bold font-accent text-brand-navy">Billing Address</h2>
              
              <label class="flex items-center cursor-pointer">
                <input 
                  v-model="form.sameAsShipping"
                  type="checkbox"
                  class="w-5 h-5 text-brand-blue border-gray-300 rounded focus:ring-brand-blue"
                />
                <span class="ml-2 text-sm font-semibold text-gray-700">Same as shipping</span>
              </label>
            </div>

            <div v-if="!form.sameAsShipping" class="space-y-4">
              <div>
                <label for="billingAddress1" class="block text-sm font-semibold text-gray-700 mb-2">
                  Address Line 1 *
                </label>
                <input 
                  v-model="form.billing.address1"
                  type="text" 
                  id="billingAddress1"
                  required
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="Street address"
                />
              </div>

              <div>
                <label for="billingAddress2" class="block text-sm font-semibold text-gray-700 mb-2">
                  Address Line 2
                </label>
                <input 
                  v-model="form.billing.address2"
                  type="text" 
                  id="billingAddress2"
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  placeholder="Apartment, suite, etc. (optional)"
                />
              </div>

              <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label for="billingCity" class="block text-sm font-semibold text-gray-700 mb-2">
                    City *
                  </label>
                  <input 
                    v-model="form.billing.city"
                    type="text" 
                    id="billingCity"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="Berlin"
                  />
                </div>

                <div>
                  <label for="billingPostalCode" class="block text-sm font-semibold text-gray-700 mb-2">
                    Postal Code *
                  </label>
                  <input 
                    v-model="form.billing.postalCode"
                    type="text" 
                    id="billingPostalCode"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                    placeholder="10115"
                  />
                </div>

                <div>
                  <label for="billingCountry" class="block text-sm font-semibold text-gray-700 mb-2">
                    Country *
                  </label>
                  <select 
                    v-model="form.billing.country"
                    id="billingCountry"
                    required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
                  >
                    <option value="">Select country</option>
                    <option value="DE">Germany</option>
                    <option value="AT">Austria</option>
                    <option value="CH">Switzerland</option>
                    <option value="NL">Netherlands</option>
                    <option value="BE">Belgium</option>
                    <option value="FR">France</option>
                  </select>
                </div>
              </div>
            </div>

            <div v-else class="text-center py-8 bg-brand-gray-light rounded-lg">
              <p class="text-gray-600">Billing address is the same as shipping address</p>
            </div>
          </div>

          <!-- Payment Method -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Payment Method</h2>
            
            <div class="space-y-4">
              <!-- Stripe Payment Placeholder -->
              <div class="border-2 border-dashed border-brand-blue rounded-lg p-8 text-center bg-brand-blue bg-opacity-5">
                <svg class="w-16 h-16 mx-auto mb-4 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                </svg>
                <p class="text-lg font-semibold text-brand-navy mb-2">Secure Payment with Stripe</p>
                <p class="text-sm text-gray-600 mb-4">Credit card, debit card, and more payment methods</p>
                <p class="text-xs text-gray-500">Stripe Checkout integration will be initialized on Place Order</p>
              </div>

              <!-- Terms and Conditions -->
              <div class="flex items-start pt-4">
                <input 
                  v-model="form.acceptTerms"
                  type="checkbox" 
                  id="acceptTerms"
                  required
                  class="w-5 h-5 text-brand-blue border-gray-300 rounded focus:ring-brand-blue mt-0.5"
                />
                <label for="acceptTerms" class="ml-3 text-sm text-gray-700">
                  I agree to the 
                  <a href="#" class="text-brand-blue hover:underline font-semibold">Terms & Conditions</a> 
                  and 
                  <a href="#" class="text-brand-blue hover:underline font-semibold">Privacy Policy</a>
                </label>
              </div>
            </div>
          </div>

          <!-- Place Order Button -->
          <div>
            <ButtonGlow 
              variant="accent" 
              @click="placeOrder"
              :disabled="!isFormValid || isProcessing"
              class="w-full text-xl py-5"
            >
              <span v-if="!isProcessing">Place Order - €{{ cartTotal.toFixed(2) }}</span>
              <span v-else class="flex items-center justify-center gap-3">
                <svg class="animate-spin h-6 w-6" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Processing...
              </span>
            </ButtonGlow>
          </div>
        </div>

        <!-- Right Column - Order Summary (Sticky) -->
        <div class="lg:col-span-1">
          <div class="bg-white rounded-lg shadow-lg p-6 lg:sticky lg:top-8">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Order Summary</h2>

            <!-- Cart Items -->
            <div class="space-y-4 mb-6 max-h-96 overflow-y-auto">
              <div 
                v-for="item in cartItems"
                :key="item.id"
                class="flex gap-4 pb-4 border-b border-gray-200"
              >
                <div class="relative flex-shrink-0 w-20 h-20 bg-gray-100 rounded-lg overflow-hidden">
                  <img 
                    :src="item.image || item.day_image || '/placeholder-product.jpg'"
                    :alt="item.name"
                    class="w-full h-full object-cover"
                  />
                  <span class="absolute -top-2 -right-2 bg-brand-navy text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold">
                    {{ item.quantity }}
                  </span>
                </div>
                <div class="flex-grow">
                  <h4 class="font-semibold text-sm text-brand-navy line-clamp-2">{{ item.name }}</h4>
                  <p class="text-sm text-gray-600 mt-1">€{{ item.price.toFixed(2) }} each</p>
                </div>
              </div>
            </div>

            <!-- Summary Breakdown -->
            <div class="space-y-3 mb-6">
              <div class="flex justify-between text-gray-700">
                <span>Subtotal</span>
                <span class="font-semibold">€{{ subtotal.toFixed(2) }}</span>
              </div>

              <div v-if="installationCost > 0" class="flex justify-between text-gray-700">
                <span>Installation</span>
                <span class="font-semibold">€{{ installationCost.toFixed(2) }}</span>
              </div>

              <div class="flex justify-between text-gray-700">
                <span>Shipping</span>
                <span class="font-semibold">€{{ shippingCost.toFixed(2) }}</span>
              </div>

              <div class="flex justify-between text-gray-700">
                <span>Tax (19%)</span>
                <span class="font-semibold">€{{ taxAmount.toFixed(2) }}</span>
              </div>

              <div class="border-t border-gray-300 pt-3"></div>

              <div class="flex justify-between items-center">
                <span class="text-xl font-semibold text-brand-navy">Total</span>
                <span class="text-3xl font-bold font-accent text-brand-blue">
                  €{{ cartTotal.toFixed(2) }}
                </span>
              </div>
            </div>

            <!-- Security Badge -->
            <div class="flex items-center justify-center gap-2 text-sm text-gray-600 pt-4 border-t border-gray-200">
              <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
              <span>Secure SSL Encrypted Checkout</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useCartStore } from '@/store/cart'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import { createCheckoutSession, redirectToCheckout, simulateCheckout } from '@/services/stripe'

const router = useRouter()
const cartStore = useCartStore()

// Check if Stripe is configured
const isStripeConfigured = !!import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY

// Form state
const form = ref({
  email: '',
  firstName: '',
  lastName: '',
  phone: '',
  createAccount: false,
  shipping: {
    address1: '',
    address2: '',
    city: '',
    postalCode: '',
    country: ''
  },
  billing: {
    address1: '',
    address2: '',
    city: '',
    postalCode: '',
    country: ''
  },
  sameAsShipping: true,
  acceptTerms: false
})

const isProcessing = ref(false)

// Cart data
const cartItems = computed(() => cartStore.items)
const subtotal = computed(() => cartStore.subtotal)

// Calculate costs
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

const shippingCost = computed(() => {
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

const taxAmount = computed(() => {
  const taxableAmount = subtotal.value + installationCost.value + shippingCost.value
  return taxableAmount * 0.19
})

const cartTotal = computed(() => {
  return subtotal.value + installationCost.value + shippingCost.value + taxAmount.value
})

// Form validation
const isFormValid = computed(() => {
  const hasCustomerInfo = form.value.email && form.value.firstName && form.value.lastName && form.value.phone
  const hasShipping = form.value.shipping.address1 && form.value.shipping.city && 
                      form.value.shipping.postalCode && form.value.shipping.country
  const hasBilling = form.value.sameAsShipping || 
                     (form.value.billing.address1 && form.value.billing.city && 
                      form.value.billing.postalCode && form.value.billing.country)
  const hasAcceptedTerms = form.value.acceptTerms
  
  return hasCustomerInfo && hasShipping && hasBilling && hasAcceptedTerms
})

// Place order
const placeOrder = async () => {
  if (!isFormValid.value) {
    alert('Please fill in all required fields')
    return
  }

  if (cartItems.value.length === 0) {
    alert('Your cart is empty')
    router.push('/cart')
    return
  }

  isProcessing.value = true

  try {
    // Prepare order data
    const orderData = {
      items: cartItems.value.map(item => ({
        id: item.id,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        image: item.image || item.day_image
      })),
      customerEmail: form.value.email,
      shippingAddress: {
        line1: form.value.shipping.address1,
        line2: form.value.shipping.address2,
        city: form.value.shipping.city,
        postalCode: form.value.shipping.postalCode,
        country: form.value.shipping.country
      },
      metadata: {
        customerName: `${form.value.firstName} ${form.value.lastName}`,
        phone: form.value.phone,
        subtotal: subtotal.value.toFixed(2),
        shipping: shippingCost.value.toFixed(2),
        tax: taxAmount.value.toFixed(2),
        total: cartTotal.value.toFixed(2)
      }
    }

    if (isStripeConfigured) {
      // Real Stripe checkout flow
      const { sessionId } = await createCheckoutSession(orderData)
      
      // Clear cart before redirect
      cartStore.clearCart()
      
      // Redirect to Stripe checkout
      await redirectToCheckout(sessionId)
    } else {
      // Demo mode - simulate checkout
      console.log('Running in demo mode (Stripe not configured)')
      const { orderId } = await simulateCheckout(orderData)
      
      // Clear cart
      cartStore.clearCart()
      
      // Redirect to order confirmation with demo order ID
      router.push(`/order/confirmation?order_id=${orderId}`)
    }
  } catch (error: any) {
    console.error('Order placement failed:', error)
    alert(error.message || 'Failed to place order. Please try again.')
  } finally {
    isProcessing.value = false
  }
}
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
