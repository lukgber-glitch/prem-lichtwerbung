<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      <div class="max-w-2xl mx-auto text-center">
        
        <div class="w-24 h-24 bg-primary/20 rounded-full flex items-center justify-center mx-auto mb-6 border-2 border-primary">
          <span class="text-6xl text-primary">✓</span>
        </div>
        
        <h1 class="text-4xl font-heading font-bold text-text-main mb-4">Thank You for Your Order!</h1>
        <p class="text-xl text-text-muted mb-8">
          Your order has been received and is being processed.
        </p>
        
        <div class="bg-surface p-8 rounded-xl border border-primary/20 mb-8 text-left">
          <h2 class="text-2xl font-heading font-bold text-text-main mb-4">Order Details</h2>
          
          <div class="space-y-3">
            <div class="flex justify-between">
              <span class="text-text-muted">Order Number</span>
              <span class="font-semibold text-text-main">#{{ orderNumber }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-muted">Order Date</span>
              <span class="font-semibold text-text-main">{{ orderDate }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-muted">Estimated Delivery</span>
              <span class="font-semibold text-text-main">{{ estimatedDelivery }}</span>
            </div>
            <div class="flex justify-between border-t border-primary/20 pt-3">
              <span class="text-xl font-bold text-text-main">Total Paid</span>
              <span class="text-2xl font-bold text-primary">€595.00</span>
            </div>
          </div>
        </div>
        
        <p class="text-text-muted mb-8">
          📧 A confirmation email has been sent to your email address.
        </p>
        
        <div class="flex flex-col md:flex-row gap-4 justify-center">
          <button 
            @click="$router.push('/products')"
            class="px-8 py-3 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary cursor-pointer"
          >
            Continue Shopping
          </button>
          <button 
            @click="$router.push('/order/tracking')"
            class="px-8 py-3 bg-surface-alt text-text-main font-bold rounded-lg hover:bg-surface transition-all border-2 border-text-muted hover:border-primary cursor-pointer"
          >
            Track Order
          </button>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const orderNumber = ref('ORD-' + Math.random().toString(36).substr(2, 9).toUpperCase())
const orderDate = ref(new Date().toLocaleDateString())
const estimatedDelivery = ref(new Date(Date.now() + 14 * 24 * 60 * 60 * 1000).toLocaleDateString())
</script>
