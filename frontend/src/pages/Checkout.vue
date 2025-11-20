<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      <h1 class="text-4xl font-heading font-bold text-text-main mb-8">Checkout</h1>
      
      <div class="grid md:grid-cols-3 gap-8">
        
        <!-- Checkout Form -->
        <div class="md:col-span-2 space-y-6">
          
          <!-- Customer Information -->
          <div class="bg-surface p-6 rounded-xl border border-primary/20">
            <h2 class="text-2xl font-heading font-bold text-text-main mb-4">Customer Information</h2>
            <div class="space-y-4">
              <input 
                v-model="form.email"
                type="email" 
                placeholder="Email"
                class="w-full px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
              />
              <div class="grid md:grid-cols-2 gap-4">
                <input 
                  v-model="form.firstName"
                  type="text" 
                  placeholder="First Name"
                  class="px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
                />
                <input 
                  v-model="form.lastName"
                  type="text" 
                  placeholder="Last Name"
                  class="px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
                />
              </div>
            </div>
          </div>
          
          <!-- Shipping Address -->
          <div class="bg-surface p-6 rounded-xl border border-primary/20">
            <h2 class="text-2xl font-heading font-bold text-text-main mb-4">Shipping Address</h2>
            <div class="space-y-4">
              <input 
                v-model="form.address"
                type="text" 
                placeholder="Address"
                class="w-full px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
              />
              <div class="grid md:grid-cols-2 gap-4">
                <input 
                  v-model="form.city"
                  type="text" 
                  placeholder="City"
                  class="px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
                />
                <input 
                  v-model="form.postalCode"
                  type="text" 
                  placeholder="Postal Code"
                  class="px-4 py-3 border border-surface-alt rounded-lg bg-surface-alt text-text-main placeholder-text-muted"
                />
              </div>
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
                <span class="font-semibold text-text-main">€450.00</span>
              </div>
              <div class="flex justify-between">
                <span class="text-text-muted">Shipping</span>
                <span class="font-semibold text-text-main">€50.00</span>
              </div>
              <div class="flex justify-between">
                <span class="text-text-muted">Tax</span>
                <span class="font-semibold text-text-main">€95.00</span>
              </div>
              
              <div class="border-t border-primary/20 pt-3">
                <div class="flex justify-between">
                  <span class="text-xl font-bold text-text-main">Total</span>
                  <span class="text-2xl font-bold text-primary">€595.00</span>
                </div>
              </div>
            </div>
            
            <div v-if="checkoutError" class="bg-red-900/20 border-2 border-red-500 text-red-400 p-4 rounded-lg mb-4">
              {{ checkoutError }}
            </div>
            
            <ButtonGlow 
              variant="primary" 
              class="w-full text-xl py-4" 
              @click="handlePlaceOrder"
              :disabled="isProcessing || !termsAccepted">
              {{ isProcessing ? '⏳ Processing...' : '💳 Place Order' }}
            </ButtonGlow>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { handleCheckoutFlow } from '@/services/stripe'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const router = useRouter()

const form = ref({
  email: '',
  firstName: '',
  lastName: '',
  phone: '',
  address1: '',
  address2: '',
  city: '',
  postalCode: '',
  country: 'DE',
  billingDifferent: false,
  billingAddress1: '',
  billingAddress2: '',
  billingCity: '',
  billingPostalCode: '',
  billingCountry: 'DE'
})

const isProcessing = ref(false)
const checkoutError = ref<string | null>(null)
const termsAccepted = ref(false)

const handlePlaceOrder = async () => {
  isProcessing.value = true
  checkoutError.value = null
  
  try {
    const sessionData = {
      items: [
        // TODO: Replace with actual cart items from store
        {
          product_id: 'sample-product-id',
          product_name: 'Sample Product',
          quantity: 1,
          price: 595.00,
          options: {}
        }
      ],
      customer_email: form.value.email,
      customer_name: `${form.value.firstName} ${form.value.lastName}`,
      customer_phone: form.value.phone,
      shipping_address: {
        line1: form.value.address1,
        line2: form.value.address2,
        city: form.value.city,
        postal_code: form.value.postalCode,
        country: form.value.country
      },
      billing_address: form.value.billingDifferent ? {
        line1: form.value.billingAddress1,
        line2: form.value.billingAddress2,
        city: form.value.billingCity,
        postal_code: form.value.billingPostalCode,
        country: form.value.billingCountry
      } : undefined
    }
    
    await handleCheckoutFlow(sessionData)
  } catch (error) {
    console.error('Checkout error:', error)
    checkoutError.value = 'Failed to process checkout. Please try again or contact support.'
  } finally {
    isProcessing.value = false
  }
}
</script>
