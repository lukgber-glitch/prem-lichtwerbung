<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      
      <h1 class="text-4xl font-heading font-bold text-text-main mb-8">Shopping Cart</h1>
      
      <div v-if="cartItems.length === 0" class="text-center py-12 bg-surface rounded-xl border border-primary/20">
        <span class="text-9xl mb-4 block">🛒</span>
        <h2 class="text-2xl font-bold text-text-main mb-4">Your cart is empty</h2>
        <p class="text-text-muted mb-8">Start adding products to your cart!</p>
        <button 
          @click="$router.push('/products')"
          class="px-8 py-3 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary cursor-pointer"
        >
          Browse Products
        </button>
      </div>
      
      <div v-else class="grid md:grid-cols-3 gap-8">
        
        <!-- Cart Items -->
        <div class="md:col-span-2 space-y-4">
          <div 
            v-for="item in cartItems" 
            :key="item.id"
            class="bg-surface p-6 rounded-xl border border-primary/20 flex gap-6"
          >
            <div class="w-24 h-24 bg-surface-alt rounded-lg flex items-center justify-center flex-shrink-0 border border-surface-alt">
              <span class="text-4xl">💡</span>
            </div>
            
            <div class="flex-grow">
              <h3 class="text-xl font-bold text-text-main mb-2">{{ item.name }}</h3>
              <p class="text-text-muted mb-4">€{{ item.price.toFixed(2) }}</p>
              
              <div class="flex items-center gap-4">
                <label class="text-text-main">Qty:</label>
                <input 
                  v-model.number="item.quantity"
                  type="number" 
                  min="1"
                  class="w-20 px-3 py-2 border border-surface-alt rounded-lg bg-surface-alt text-text-main"
                />
                <button 
                  @click="removeItem(item.id)"
                  class="text-red-400 hover:text-red-300 hover:underline ml-auto cursor-pointer"
                >
                  Remove
                </button>
              </div>
            </div>
            
            <div class="text-right">
              <p class="text-2xl font-bold text-primary">
                €{{ (item.price * item.quantity).toFixed(2) }}
              </p>
            </div>
          </div>
        </div>
        
        <!-- Order Summary -->
        <div class="md:col-span-1">
          <div class="bg-surface p-6 rounded-xl border border-primary/20 sticky top-6">
            <h3 class="text-2xl font-heading font-bold text-text-main mb-6">Order Summary</h3>
            
            <div class="space-y-3 mb-6">
              <div class="flex justify-between">
                <span class="text-text-muted">Subtotal</span>
                <span class="font-semibold text-text-main">€{{ subtotal.toFixed(2) }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-text-muted">Shipping</span>
                <span class="font-semibold text-text-main">€50.00</span>
              </div>
              <div class="flex justify-between">
                <span class="text-text-muted">Tax (19%)</span>
                <span class="font-semibold text-text-main">€{{ tax.toFixed(2) }}</span>
              </div>
              
              <div class="border-t border-primary/20 pt-3">
                <div class="flex justify-between">
                  <span class="text-xl font-bold text-text-main">Total</span>
                  <span class="text-2xl font-bold text-primary">€{{ total.toFixed(2) }}</span>
                </div>
              </div>
            </div>
            
            <button 
              @click="$router.push('/checkout')"
              class="w-full px-8 py-4 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary mb-4 cursor-pointer"
            >
              Proceed to Checkout
            </button>
            
            <button 
              @click="$router.push('/products')"
              class="w-full px-8 py-3 bg-surface-alt text-text-main font-semibold rounded-lg hover:bg-surface transition-all border-2 border-text-muted hover:border-primary cursor-pointer"
            >
              Continue Shopping
            </button>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

const cartItems = ref([
  { id: 1, name: 'Premium Lightbox - Medium', price: 450, quantity: 1 },
  { id: 2, name: 'LED Neon Sign - Custom', price: 350, quantity: 2 },
])

const subtotal = computed(() => 
  cartItems.value.reduce((sum, item) => sum + (item.price * item.quantity), 0)
)

const tax = computed(() => subtotal.value * 0.19)
const shipping = 50
const total = computed(() => subtotal.value + tax.value + shipping)

const removeItem = (id: number) => {
  cartItems.value = cartItems.value.filter(item => item.id !== id)
}
</script>
