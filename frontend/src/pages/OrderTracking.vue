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
          <li class="text-brand-gray-dark font-semibold">Order Tracking</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-12">
      <div class="max-w-4xl mx-auto">
        <!-- Page Title -->
        <div class="text-center mb-12">
          <h1 class="text-4xl md:text-5xl font-bold mb-4 font-accent text-brand-navy">
            Track Your Order
          </h1>
          <p class="text-xl text-gray-600">
            Enter your order details to check the status of your illuminated signage
          </p>
        </div>

        <!-- Tracking Form -->
        <div v-if="!orderStatus" class="bg-white rounded-lg shadow-lg p-8 mb-8">
          <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Enter Order Details</h2>
          
          <form @submit.prevent="trackOrder" class="space-y-6">
            <!-- Order Number -->
            <div>
              <label for="orderNumber" class="block text-sm font-semibold text-gray-700 mb-2">
                Order Number *
              </label>
              <input
                v-model="trackingForm.orderNumber"
                type="text"
                id="orderNumber"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="e.g., ORD-1234567890-ABC"
              />
            </div>

            <!-- Email -->
            <div>
              <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                Email Address *
              </label>
              <input
                v-model="trackingForm.email"
                type="email"
                id="email"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="your@email.com"
              />
            </div>

            <!-- Error Message -->
            <div v-if="errorMessage" class="p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg">
              <p class="font-semibold">{{ errorMessage }}</p>
            </div>

            <!-- Submit Button -->
            <ButtonGlow
              type="submit"
              variant="primary"
              :disabled="isTracking"
              class="w-full text-lg py-4"
            >
              <span v-if="!isTracking" class="flex items-center justify-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                Track Order
              </span>
              <span v-else class="flex items-center justify-center gap-3">
                <svg class="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Tracking...
              </span>
            </ButtonGlow>

            <p class="text-sm text-gray-500 text-center">
              * Required fields
            </p>
          </form>

          <!-- Help Section -->
          <div class="mt-8 pt-8 border-t border-gray-200">
            <h3 class="font-semibold text-brand-navy mb-3">Need Help?</h3>
            <p class="text-sm text-gray-600 mb-4">
              You can find your order number in the confirmation email we sent you. If you're having trouble, please contact our support team.
            </p>
            <router-link to="/contact" class="text-brand-blue hover:underline font-semibold text-sm">
              Contact Support →
            </router-link>
          </div>
        </div>

        <!-- Order Status Display -->
        <div v-else class="space-y-8">
          <!-- Order Header -->
          <div class="bg-white rounded-lg shadow-lg p-8">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
              <div>
                <p class="text-sm text-gray-600 mb-1">Order Number</p>
                <p class="text-3xl font-bold font-accent text-brand-blue">{{ orderStatus.orderNumber }}</p>
              </div>
              <button
                @click="resetTracking"
                class="text-brand-pink hover:underline font-semibold flex items-center gap-2"
              >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Track Another Order
              </button>
            </div>

            <!-- Current Status Badge -->
            <div class="inline-flex items-center px-6 py-3 rounded-full text-lg font-semibold"
                 :class="getStatusBadgeClass(orderStatus.currentStatus)">
              {{ getStatusLabel(orderStatus.currentStatus) }}
            </div>
          </div>

          <!-- Estimated Delivery -->
          <div class="bg-gradient-to-r from-brand-blue to-brand-pink rounded-lg shadow-lg p-8 text-white">
            <div class="flex items-center gap-4">
              <div class="w-16 h-16 bg-white bg-opacity-20 rounded-full flex items-center justify-center flex-shrink-0">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
              </div>
              <div>
                <p class="text-brand-warm text-sm mb-1">Estimated Delivery Date</p>
                <p class="text-3xl font-bold font-accent">{{ orderStatus.estimatedDelivery }}</p>
              </div>
            </div>
          </div>

          <!-- Order Timeline -->
          <div class="bg-white rounded-lg shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-8 font-accent text-brand-navy">Order Progress</h2>
            
            <div class="space-y-8">
              <div
                v-for="(step, index) in orderTimeline"
                :key="step.status"
                class="relative flex gap-6"
              >
                <!-- Timeline Line -->
                <div v-if="index < orderTimeline.length - 1" class="absolute left-6 top-16 w-0.5 h-full -ml-px"
                     :class="step.completed ? 'bg-brand-blue' : 'bg-gray-300'">
                </div>

                <!-- Status Icon -->
                <div class="relative flex-shrink-0">
                  <div
                    class="w-12 h-12 rounded-full flex items-center justify-center transition-all duration-300"
                    :class="step.completed 
                      ? 'bg-brand-blue text-white shadow-glow-blue' 
                      : step.inProgress 
                        ? 'bg-brand-yellow text-brand-navy animate-pulse' 
                        : 'bg-gray-200 text-gray-400'"
                  >
                    <svg v-if="step.completed" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7" />
                    </svg>
                    <svg v-else-if="step.inProgress" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <div v-else class="w-3 h-3 rounded-full bg-gray-400"></div>
                  </div>
                </div>

                <!-- Status Details -->
                <div class="flex-grow pb-8">
                  <h3 class="text-lg font-bold mb-1"
                      :class="step.completed || step.inProgress ? 'text-brand-navy' : 'text-gray-400'">
                    {{ step.label }}
                  </h3>
                  
                  <p v-if="step.date" class="text-sm font-semibold mb-2"
                     :class="step.completed ? 'text-brand-blue' : 'text-brand-yellow'">
                    {{ formatDateTime(step.date) }}
                  </p>
                  
                  <p v-else-if="step.estimatedDate" class="text-sm text-gray-500 mb-2">
                    Estimated: {{ formatDate(step.estimatedDate) }}
                  </p>
                  
                  <p class="text-sm"
                     :class="step.completed || step.inProgress ? 'text-gray-600' : 'text-gray-400'">
                    {{ step.description }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Order Items -->
          <div class="bg-white rounded-lg shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Order Items</h2>
            <div class="space-y-4">
              <div
                v-for="item in orderStatus.items"
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
                </div>
              </div>
            </div>
          </div>

          <!-- Contact Support -->
          <div class="bg-brand-gray-light rounded-lg p-8 text-center">
            <h3 class="text-xl font-bold mb-3 text-brand-navy">Questions About Your Order?</h3>
            <p class="text-gray-600 mb-6">
              Our customer support team is here to help with any questions or concerns.
            </p>
            <div class="flex gap-4 justify-center">
              <ButtonGlow variant="secondary" @click="$router.push('/contact')">
                Contact Support
              </ButtonGlow>
              <ButtonGlow variant="primary" @click="$router.push('/products')">
                Continue Shopping
              </ButtonGlow>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const route = useRoute()

// Form state
const trackingForm = ref({
  orderNumber: '',
  email: ''
})

const isTracking = ref(false)
const errorMessage = ref('')
const orderStatus = ref<any>(null)

// Order statuses
enum OrderStatus {
  PLACED = 'placed',
  PAYMENT_CONFIRMED = 'payment_confirmed',
  IN_PRODUCTION = 'in_production',
  QUALITY_CHECK = 'quality_check',
  READY_FOR_DELIVERY = 'ready_for_delivery',
  DELIVERED = 'delivered'
}

// Get status label
const getStatusLabel = (status: string): string => {
  const labels: Record<string, string> = {
    placed: 'Order Placed',
    payment_confirmed: 'Payment Confirmed',
    in_production: 'In Production',
    quality_check: 'Quality Check',
    ready_for_delivery: 'Ready for Delivery',
    delivered: 'Delivered'
  }
  return labels[status] || status
}

// Get status badge class
const getStatusBadgeClass = (status: string): string => {
  const classes: Record<string, string> = {
    placed: 'bg-blue-100 text-blue-800',
    payment_confirmed: 'bg-green-100 text-green-800',
    in_production: 'bg-brand-yellow bg-opacity-30 text-brand-navy',
    quality_check: 'bg-purple-100 text-purple-800',
    ready_for_delivery: 'bg-orange-100 text-orange-800',
    delivered: 'bg-green-100 text-green-800'
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

// Format date
const formatDate = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

// Format date and time
const formatDateTime = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

// Generate order timeline
const orderTimeline = computed(() => {
  if (!orderStatus.value) return []

  const currentStatus = orderStatus.value.currentStatus
  const createdAt = new Date(orderStatus.value.createdAt)

  const timeline = [
    {
      status: OrderStatus.PLACED,
      label: 'Order Placed',
      description: 'Your order has been received and confirmed.',
      date: orderStatus.value.createdAt,
      completed: true,
      inProgress: false
    },
    {
      status: OrderStatus.PAYMENT_CONFIRMED,
      label: 'Payment Confirmed',
      description: 'Payment has been processed successfully.',
      date: orderStatus.value.createdAt,
      completed: true,
      inProgress: false
    },
    {
      status: OrderStatus.IN_PRODUCTION,
      label: 'In Production',
      description: 'Your custom signage is being fabricated with precision and care.',
      date: currentStatus === OrderStatus.IN_PRODUCTION ? new Date().toISOString() : null,
      estimatedDate: new Date(createdAt.getTime() + 2 * 24 * 60 * 60 * 1000).toISOString(),
      completed: [OrderStatus.QUALITY_CHECK, OrderStatus.READY_FOR_DELIVERY, OrderStatus.DELIVERED].includes(currentStatus as OrderStatus),
      inProgress: currentStatus === OrderStatus.IN_PRODUCTION
    },
    {
      status: OrderStatus.QUALITY_CHECK,
      label: 'Quality Check',
      description: 'Your signage is undergoing final quality inspection.',
      date: currentStatus === OrderStatus.QUALITY_CHECK ? new Date().toISOString() : null,
      estimatedDate: new Date(createdAt.getTime() + 10 * 24 * 60 * 60 * 1000).toISOString(),
      completed: [OrderStatus.READY_FOR_DELIVERY, OrderStatus.DELIVERED].includes(currentStatus as OrderStatus),
      inProgress: currentStatus === OrderStatus.QUALITY_CHECK
    },
    {
      status: OrderStatus.READY_FOR_DELIVERY,
      label: 'Ready for Delivery',
      description: 'Your order has been packaged and is ready to ship.',
      date: currentStatus === OrderStatus.READY_FOR_DELIVERY ? new Date().toISOString() : null,
      estimatedDate: new Date(createdAt.getTime() + 12 * 24 * 60 * 60 * 1000).toISOString(),
      completed: currentStatus === OrderStatus.DELIVERED,
      inProgress: currentStatus === OrderStatus.READY_FOR_DELIVERY
    },
    {
      status: OrderStatus.DELIVERED,
      label: 'Delivered',
      description: 'Your order has been successfully delivered.',
      date: currentStatus === OrderStatus.DELIVERED ? new Date().toISOString() : null,
      estimatedDate: new Date(createdAt.getTime() + 14 * 24 * 60 * 60 * 1000).toISOString(),
      completed: currentStatus === OrderStatus.DELIVERED,
      inProgress: false
    }
  ]

  return timeline
})

// Track order
const trackOrder = async () => {
  errorMessage.value = ''
  isTracking.value = true

  try {
    // TODO: Replace with actual API call
    // For demo, check localStorage
    await new Promise(resolve => setTimeout(resolve, 1000))

    const storedOrder = localStorage.getItem('demo_order_' + trackingForm.value.orderNumber)

    if (storedOrder) {
      const order = JSON.parse(storedOrder)
      
      // Simulate order progression based on time
      const orderAge = Date.now() - new Date(order.createdAt).getTime()
      const daysOld = orderAge / (1000 * 60 * 60 * 24)
      
      let currentStatus = OrderStatus.IN_PRODUCTION
      if (daysOld >= 14) currentStatus = OrderStatus.DELIVERED
      else if (daysOld >= 12) currentStatus = OrderStatus.READY_FOR_DELIVERY
      else if (daysOld >= 10) currentStatus = OrderStatus.QUALITY_CHECK
      
      orderStatus.value = {
        ...order,
        orderNumber: order.orderId,
        currentStatus,
        estimatedDelivery: new Date(new Date(order.createdAt).getTime() + 14 * 24 * 60 * 60 * 1000).toLocaleDateString('en-US', {
          year: 'numeric',
          month: 'long',
          day: 'numeric'
        })
      }
    } else {
      errorMessage.value = 'Order not found. Please check your order number and email.'
    }
  } catch (error) {
    console.error('Error tracking order:', error)
    errorMessage.value = 'Failed to track order. Please try again.'
  } finally {
    isTracking.value = false
  }
}

// Reset tracking
const resetTracking = () => {
  orderStatus.value = null
  trackingForm.value = { orderNumber: '', email: '' }
  errorMessage.value = ''
}

// On mount - check if order ID is in URL
onMounted(() => {
  const orderId = route.query.order_id as string
  if (orderId) {
    trackingForm.value.orderNumber = orderId
  }
})
</script>
