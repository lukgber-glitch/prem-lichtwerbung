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
          <li>
            <router-link to="/checkout" class="text-brand-navy hover:text-brand-blue transition-colors">
              Checkout
            </router-link>
          </li>
          <li class="text-gray-400">/</li>
          <li class="text-brand-gray-dark font-semibold">Confirmation</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-12">
      <!-- Loading State -->
      <div v-if="loading" class="text-center py-20">
        <div class="inline-block animate-spin rounded-full h-16 w-16 border-4 border-brand-blue border-t-transparent"></div>
        <p class="text-gray-600 mt-4 text-lg">Loading order details...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="max-w-2xl mx-auto text-center py-20">
        <svg class="w-24 h-24 mx-auto mb-6 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <h2 class="text-2xl font-bold text-gray-800 mb-4">Order Not Found</h2>
        <p class="text-gray-600 mb-8">{{ error }}</p>
        <div class="flex gap-4 justify-center">
          <ButtonGlow variant="primary" @click="$router.push('/products')">
            Continue Shopping
          </ButtonGlow>
          <ButtonGlow variant="secondary" @click="$router.push('/contact')">
            Contact Support
          </ButtonGlow>
        </div>
      </div>

      <!-- Success State -->
      <div v-else-if="orderData" class="max-w-4xl mx-auto">
        <!-- Success Icon & Message -->
        <div class="text-center mb-12">
          <div class="inline-flex items-center justify-center w-24 h-24 bg-green-100 rounded-full mb-6 animate-bounce">
            <svg class="w-12 h-12 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7" />
            </svg>
          </div>
          <h1 class="text-4xl md:text-5xl font-bold font-accent text-brand-navy mb-4">
            Thank You for Your Order!
          </h1>
          <p class="text-xl text-gray-600 mb-2">
            Your order has been successfully placed and is being processed.
          </p>
          <p class="text-sm text-gray-500">
            We've sent a confirmation email to <span class="font-semibold text-brand-navy">{{ orderData.customerEmail || 'your email' }}</span>
          </p>
        </div>

        <!-- Order Details Card -->
        <div class="bg-white rounded-lg shadow-lg p-8 mb-8">
          <!-- Order Number & Date -->
          <div class="border-b border-gray-200 pb-6 mb-6">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
              <div>
                <p class="text-sm text-gray-600 mb-1">Order Number</p>
                <p class="text-3xl font-bold font-accent text-brand-blue">{{ orderData.orderId }}</p>
              </div>
              <div class="text-left md:text-right">
                <p class="text-sm text-gray-600 mb-1">Order Date</p>
                <p class="text-lg font-semibold text-brand-navy">{{ formatDate(orderData.createdAt) }}</p>
              </div>
            </div>
          </div>

          <!-- Estimated Delivery -->
          <div class="bg-brand-blue bg-opacity-10 border border-brand-blue rounded-lg p-6 mb-6">
            <div class="flex items-start gap-4">
              <div class="w-12 h-12 bg-brand-blue rounded-full flex items-center justify-center flex-shrink-0">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
              </div>
              <div class="flex-grow">
                <h3 class="text-lg font-bold text-brand-navy mb-2">Estimated Delivery</h3>
                <p class="text-2xl font-bold text-brand-blue mb-2">{{ estimatedDeliveryDate }}</p>
                <p class="text-sm text-gray-600">
                  We'll notify you when your order ships. Track your order status anytime from your account.
                </p>
              </div>
            </div>
          </div>

          <!-- Order Items -->
          <div class="mb-6">
            <h3 class="text-xl font-bold mb-4 font-accent text-brand-navy">Order Items</h3>
            <div class="space-y-4">
              <div 
                v-for="item in orderData.items"
                :key="item.id"
                class="flex gap-4 pb-4 border-b border-gray-200 last:border-b-0"
              >
                <div class="w-20 h-20 bg-gray-100 rounded-lg overflow-hidden flex-shrink-0">
                  <img 
                    :src="item.image || '/placeholder-product.jpg'"
                    :alt="item.name"
                    class="w-full h-full object-cover"
                  />
                </div>
                <div class="flex-grow">
                  <h4 class="font-semibold text-brand-navy mb-1">{{ item.name }}</h4>
                  <p class="text-sm text-gray-600">Quantity: {{ item.quantity }}</p>
                </div>
                <div class="text-right">
                  <p class="text-lg font-bold text-brand-navy">€{{ (item.price * item.quantity).toFixed(2) }}</p>
                  <p class="text-sm text-gray-500">€{{ item.price.toFixed(2) }} each</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Order Summary -->
          <div class="border-t border-gray-200 pt-6">
            <div class="space-y-3 mb-6">
              <div class="flex justify-between text-gray-700">
                <span>Subtotal</span>
                <span class="font-semibold">€{{ orderData.metadata?.subtotal || calculateSubtotal() }}</span>
              </div>
              
              <div v-if="orderData.metadata?.shipping" class="flex justify-between text-gray-700">
                <span>Shipping</span>
                <span class="font-semibold">€{{ orderData.metadata.shipping }}</span>
              </div>
              
              <div v-if="orderData.metadata?.tax" class="flex justify-between text-gray-700">
                <span>Tax</span>
                <span class="font-semibold">€{{ orderData.metadata.tax }}</span>
              </div>

              <div class="border-t border-gray-300 pt-3"></div>

              <div class="flex justify-between items-center">
                <span class="text-xl font-semibold text-brand-navy">Total</span>
                <span class="text-3xl font-bold font-accent text-brand-blue">
                  €{{ orderData.metadata?.total || calculateTotal() }}
                </span>
              </div>
            </div>
          </div>

          <!-- Shipping Address -->
          <div v-if="orderData.shippingAddress" class="border-t border-gray-200 pt-6">
            <h3 class="text-lg font-bold mb-3 text-brand-navy">Shipping Address</h3>
            <div class="text-gray-700">
              <p v-if="orderData.metadata?.customerName" class="font-semibold">{{ orderData.metadata.customerName }}</p>
              <p>{{ orderData.shippingAddress.line1 }}</p>
              <p v-if="orderData.shippingAddress.line2">{{ orderData.shippingAddress.line2 }}</p>
              <p>{{ orderData.shippingAddress.postalCode }} {{ orderData.shippingAddress.city }}</p>
              <p>{{ orderData.shippingAddress.country }}</p>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
          <ButtonGlow 
            variant="primary" 
            @click="downloadInvoice"
            class="w-full py-4 text-lg"
          >
            <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            Download Invoice
          </ButtonGlow>

          <ButtonGlow 
            variant="secondary" 
            @click="$router.push(`/order/tracking?order_id=${orderData.orderId}`)"
            class="w-full py-4 text-lg"
          >
            <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
            </svg>
            Track Your Order
          </ButtonGlow>
        </div>

        <!-- What's Next Section -->
        <div class="bg-brand-gray-light rounded-lg p-8">
          <h3 class="text-2xl font-bold mb-6 font-accent text-brand-navy">What Happens Next?</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="flex gap-4">
              <div class="w-10 h-10 bg-brand-blue rounded-full flex items-center justify-center flex-shrink-0 text-white font-bold">
                1
              </div>
              <div>
                <h4 class="font-semibold text-brand-navy mb-2">Order Processing</h4>
                <p class="text-sm text-gray-600">We're preparing your custom signage with care and attention to detail.</p>
              </div>
            </div>

            <div class="flex gap-4">
              <div class="w-10 h-10 bg-brand-pink rounded-full flex items-center justify-center flex-shrink-0 text-white font-bold">
                2
              </div>
              <div>
                <h4 class="font-semibold text-brand-navy mb-2">Quality Check</h4>
                <p class="text-sm text-gray-600">Every product undergoes rigorous quality inspection before shipping.</p>
              </div>
            </div>

            <div class="flex gap-4">
              <div class="w-10 h-10 bg-brand-yellow rounded-full flex items-center justify-center flex-shrink-0 text-brand-navy font-bold">
                3
              </div>
              <div>
                <h4 class="font-semibold text-brand-navy mb-2">Delivery</h4>
                <p class="text-sm text-gray-600">Your order will be carefully packaged and delivered to your door.</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Continue Shopping -->
        <div class="text-center mt-12">
          <p class="text-gray-600 mb-6">Need more signage for your business?</p>
          <ButtonGlow variant="accent" @click="$router.push('/products')" class="px-8 py-3">
            Continue Shopping
          </ButtonGlow>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import { getCheckoutSession } from '@/services/stripe'

const route = useRoute()

// State
const loading = ref(true)
const error = ref<string | null>(null)
const orderData = ref<any>(null)

// Get order ID or session ID from URL
const orderId = route.query.order_id as string
const sessionId = route.query.session_id as string

// Format date
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

// Calculate estimated delivery (lead time + 3 days for shipping)
const estimatedDeliveryDate = computed(() => {
  if (!orderData.value?.createdAt) return 'TBD'
  
  const orderDate = new Date(orderData.value.createdAt)
  const deliveryDate = new Date(orderDate)
  
  // Average lead time + shipping (assume 14 days total)
  deliveryDate.setDate(deliveryDate.getDate() + 14)
  
  return deliveryDate.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric'
  })
})

// Calculate subtotal from items
const calculateSubtotal = () => {
  if (!orderData.value?.items) return '0.00'
  const subtotal = orderData.value.items.reduce((sum: number, item: any) => 
    sum + (item.price * item.quantity), 0
  )
  return subtotal.toFixed(2)
}

// Calculate total
const calculateTotal = () => {
  const subtotal = parseFloat(calculateSubtotal())
  const shipping = parseFloat(orderData.value?.metadata?.shipping || '0')
  const tax = parseFloat(orderData.value?.metadata?.tax || '0')
  return (subtotal + shipping + tax).toFixed(2)
}

// Load order data
const loadOrderData = async () => {
  loading.value = true
  error.value = null

  try {
    if (sessionId) {
      // Real Stripe order - fetch from backend
      const session = await getCheckoutSession(sessionId)
      orderData.value = {
        orderId: session.id,
        ...session
      }
    } else if (orderId) {
      // Demo order - load from localStorage
      const storedOrder = localStorage.getItem('demo_order_' + orderId)
      if (storedOrder) {
        orderData.value = JSON.parse(storedOrder)
      } else {
        error.value = 'Order not found. Please check your order number.'
      }
    } else {
      error.value = 'No order information provided.'
    }
  } catch (err: any) {
    console.error('Error loading order:', err)
    error.value = err.message || 'Failed to load order details.'
  } finally {
    loading.value = false
  }
}

// Download invoice (placeholder)
const downloadInvoice = () => {
  // TODO: Implement actual invoice generation
  alert('Invoice download will be available soon. You will receive it via email.')
}

// On mount
onMounted(() => {
  loadOrderData()
})
</script>
