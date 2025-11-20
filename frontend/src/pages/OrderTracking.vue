<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      <div class="max-w-2xl mx-auto">
        
        <h1 class="text-4xl font-heading font-bold text-text-main mb-8 text-center">Track Your Order</h1>
        
        <!-- Tracking Form -->
        <div v-if="!orderFound" class="bg-surface p-8 rounded-xl border border-primary/20 mb-8">
          <div class="space-y-4">
            <div>
              <label class="block text-text-main font-semibold mb-2">Order Number</label>
              <input 
                v-model="trackingForm.orderNumber"
                type="text" 
                placeholder="ORD-XXXXXXXX"
                class="w-full px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
              />
            </div>
            <div>
              <label class="block text-text-main font-semibold mb-2">Email Address</label>
              <input 
                v-model="trackingForm.email"
                type="email" 
                placeholder="your@email.com"
                class="w-full px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
              />
            </div>
            <button 
              @click="trackOrder"
              class="w-full px-8 py-4 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary cursor-pointer"
            >
              Track Order
            </button>
          </div>
        </div>
        
        <!-- Order Status -->
        <div v-else class="bg-surface p-8 rounded-xl border border-primary/20">
          <h2 class="text-2xl font-heading font-bold text-text-main mb-6">Order Status</h2>
          
          <div class="mb-8">
            <p class="text-text-muted mb-2">Order Number: <span class="font-semibold text-text-main">{{ trackingForm.orderNumber }}</span></p>
            <p class="text-text-muted">Estimated Delivery: <span class="font-semibold text-text-main">{{ estimatedDelivery }}</span></p>
          </div>
          
          <!-- Status Timeline -->
          <div class="space-y-6">
            <div 
              v-for="(status, index) in orderStatuses" 
              :key="index"
              class="flex gap-4"
            >
              <div class="flex flex-col items-center">
                <div 
                  :class="[
                    'w-12 h-12 rounded-full flex items-center justify-center border-2',
                    status.completed ? 'bg-primary text-background border-primary' : 'bg-surface-alt text-text-muted border-text-muted'
                  ]"
                >
                  <span class="text-2xl">{{ status.icon }}</span>
                </div>
                <div v-if="index < orderStatuses.length - 1" :class="['w-1 h-12', status.completed ? 'bg-primary/30' : 'bg-surface-alt']"></div>
              </div>
              
              <div class="flex-grow pb-8">
                <h3 :class="['text-lg font-bold', status.completed ? 'text-text-main' : 'text-text-muted']">
                  {{ status.title }}
                </h3>
                <p :class="['text-sm', status.completed ? 'text-text-muted' : 'text-text-muted/50']">
                  {{ status.date || 'Pending' }}
                </p>
              </div>
            </div>
          </div>
          
          <button 
            @click="orderFound = false"
            class="mt-6 w-full px-8 py-3 bg-surface-alt text-text-main font-bold rounded-lg hover:bg-surface transition-all border-2 border-text-muted hover:border-primary cursor-pointer"
          >
            Track Another Order
          </button>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const trackingForm = ref({
  orderNumber: '',
  email: ''
})

const orderFound = ref(false)
const estimatedDelivery = ref('')

const orderStatuses = ref([
  { icon: '📦', title: 'Order Placed', completed: true, date: new Date().toLocaleDateString() },
  { icon: '💳', title: 'Payment Confirmed', completed: true, date: new Date().toLocaleDateString() },
  { icon: '🏭', title: 'In Production', completed: true, date: new Date().toLocaleDateString() },
  { icon: '✅', title: 'Quality Check', completed: false, date: '' },
  { icon: '🚚', title: 'Ready for Delivery', completed: false, date: '' },
  { icon: '🎉', title: 'Delivered', completed: false, date: '' },
])

const trackOrder = () => {
  if (!trackingForm.value.orderNumber || !trackingForm.value.email) {
    alert('Please enter both order number and email')
    return
  }
  
  orderFound.value = true
  estimatedDelivery.value = new Date(Date.now() + 10 * 24 * 60 * 60 * 1000).toLocaleDateString()
}
</script>
