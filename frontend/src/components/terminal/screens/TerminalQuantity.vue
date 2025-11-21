<template>
  <div class="terminal-screen-content quantity-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">Select Quantity</h2>
      <p class="screen-subtitle">Choose the number of items</p>
    </div>
    
    <!-- Product Info Display -->
    <div class="product-info-display">
      <div class="product-icon">📦</div>
      <div class="product-details">
        <div class="product-name">{{ currentProduct?.name || 'Product' }}</div>
        <div class="product-unit-price">€{{ currentProduct?.price?.toFixed(2) || '0.00' }} each</div>
      </div>
    </div>
    
    <!-- Quantity Display -->
    <div class="quantity-display">
      <div class="quantity-value">{{ quantity }}</div>
      <div class="quantity-label">items</div>
    </div>
    
    <!-- Quantity Controls -->
    <div class="quantity-controls">
      <button 
        class="qty-btn qty-minus" 
        @click="decrementQuantity"
        :disabled="quantity <= 1"
      >
        −
      </button>
      <button 
        class="qty-btn qty-plus" 
        @click="incrementQuantity"
        :disabled="quantity >= 99"
      >
        +
      </button>
    </div>
    
    <!-- Number Pad -->
    <div class="number-pad">
      <button 
        v-for="num in [1, 2, 3, 4, 5, 6, 7, 8, 9]" 
        :key="num"
        class="num-btn"
        @click="setQuantity(num)"
      >
        {{ num }}
      </button>
      <button class="num-btn" @click="setQuantity(0)">0</button>
      <button class="num-btn clear-btn" @click="clearQuantity">Clear</button>
    </div>
    
    <!-- Subtotal Display -->
    <div class="subtotal-display">
      <span class="subtotal-label">Subtotal:</span>
      <span class="subtotal-value">€{{ subtotal.toFixed(2) }}</span>
    </div>
    
    <!-- Action Button -->
    <div class="action-area">
      <button class="continue-btn" @click="handleContinue">
        Add to Order →
      </button>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed, defineProps, defineEmits } from 'vue'

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

// Quantity state
const quantity = ref(1)

// Get current product from state (if available)
const currentProduct = computed(() => {
  if (props.state?.selectedProducts && props.state.selectedProducts.length > 0) {
    return props.state.selectedProducts[0]
  }
  return { name: 'Product Bundle', price: 1899 }
})

// Calculate subtotal
const subtotal = computed(() => {
  return (currentProduct.value?.price || 0) * quantity.value
})

// Quantity controls
const incrementQuantity = () => {
  if (quantity.value < 99) {
    quantity.value++
  }
}

const decrementQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--
  }
}

const setQuantity = (num: number) => {
  const newQty = parseInt(quantity.value.toString() + num.toString())
  if (newQty <= 99) {
    quantity.value = newQty
  }
}

const clearQuantity = () => {
  quantity.value = 1
}

const handleContinue = () => {
  // Update the selected products with the chosen quantity
  const updatedProducts = props.state.selectedProducts.map((product: any) => ({
    ...product,
    quantity: quantity.value
  }))
  
  emit('update-state', {
    selectedProducts: updatedProducts,
    totalAmount: subtotal.value
  })
  
  // Navigate to review screen
  emit('navigate', 'review')
}
</script>

<style scoped>
.quantity-screen {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1.5rem;
  gap: 1.5rem;
}

.screen-header {
  text-align: center;
  margin-bottom: 1rem;
}

.screen-title {
  font-size: 1.75rem;
  font-weight: bold;
  color: #1f2937;
  margin-bottom: 0.5rem;
}

.screen-subtitle {
  font-size: 1rem;
  color: #6b7280;
}

.product-info-display {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: #f3f4f6;
  padding: 1rem 1.5rem;
  border-radius: 12px;
  width: 100%;
  max-width: 400px;
}

.product-icon {
  font-size: 2.5rem;
}

.product-details {
  flex: 1;
}

.product-name {
  font-weight: 600;
  font-size: 1.1rem;
  color: #1f2937;
  margin-bottom: 0.25rem;
}

.product-unit-price {
  font-size: 0.9rem;
  color: #6b7280;
}

.quantity-display {
  text-align: center;
  margin: 1rem 0;
}

.quantity-value {
  font-size: 4rem;
  font-weight: bold;
  color: #2563eb;
  line-height: 1;
}

.quantity-label {
  font-size: 1rem;
  color: #6b7280;
  margin-top: 0.5rem;
}

.quantity-controls {
  display: flex;
  gap: 1.5rem;
  margin: 1rem 0;
}

.qty-btn {
  width: 70px;
  height: 70px;
  font-size: 2rem;
  font-weight: bold;
  border: 3px solid #2563eb;
  background: white;
  color: #2563eb;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.qty-btn:hover:not(:disabled) {
  background: #2563eb;
  color: white;
  transform: scale(1.05);
}

.qty-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.number-pad {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.75rem;
  max-width: 280px;
  margin: 1rem 0;
}

.num-btn {
  width: 80px;
  height: 60px;
  font-size: 1.5rem;
  font-weight: 600;
  border: 2px solid #e5e7eb;
  background: white;
  color: #1f2937;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.15s;
}

.num-btn:hover {
  background: #f3f4f6;
  border-color: #2563eb;
  transform: translateY(-2px);
}

.num-btn:active {
  transform: translateY(0);
}

.clear-btn {
  grid-column: span 2;
  background: #fee2e2;
  border-color: #ef4444;
  color: #ef4444;
  font-size: 1.1rem;
}

.clear-btn:hover {
  background: #fecaca;
}

.subtotal-display {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 400px;
  padding: 1rem 1.5rem;
  background: #dbeafe;
  border-radius: 12px;
  margin-top: 1rem;
}

.subtotal-label {
  font-size: 1.25rem;
  font-weight: 600;
  color: #1e40af;
}

.subtotal-value {
  font-size: 1.75rem;
  font-weight: bold;
  color: #1e40af;
}

.action-area {
  width: 100%;
  max-width: 400px;
  margin-top: 1rem;
}

.continue-btn {
  width: 100%;
  padding: 1.25rem 2rem;
  font-size: 1.25rem;
  font-weight: bold;
  background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  color: white;
  border: none;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.continue-btn:hover {
  background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
}

.continue-btn:active {
  transform: translateY(0);
}
</style>
