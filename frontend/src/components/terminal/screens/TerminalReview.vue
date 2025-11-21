<template>
  <div class="terminal-screen-content review-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">Review Your Order</h2>
      <p class="screen-subtitle">Please confirm the details below</p>
    </div>
    
    <!-- Order Summary -->
    <div class="order-summary">
      
      <!-- Payment Method -->
      <div class="summary-section">
        <div class="section-header">
          <span class="section-icon">💳</span>
          <span class="section-title">Payment Method</span>
        </div>
        <div class="section-content">
          <div class="payment-badge">
            {{ paymentMethodLabel }}
          </div>
        </div>
      </div>
      
      <!-- Products List -->
      <div class="summary-section">
        <div class="section-header">
          <span class="section-icon">📦</span>
          <span class="section-title">Bundle Items</span>
        </div>
        <div class="section-content">
          <div v-for="(product, index) in state.selectedProducts" :key="index" class="product-line">
            <span class="product-name">{{ product.name }}</span>
            <span class="product-qty">×{{ product.quantity }}</span>
            <span class="product-price">€{{ product.price.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      
      <!-- Price Breakdown -->
      <div class="summary-section">
        <div class="section-header">
          <span class="section-icon">💰</span>
          <span class="section-title">Price Breakdown</span>
        </div>
        <div class="section-content">
          <div class="price-line">
            <span class="price-label">Subtotal:</span>
            <span class="price-value">€2,499</span>
          </div>
          <div class="price-line discount">
            <span class="price-label">Bundle Discount (20%):</span>
            <span class="price-value">-€600</span>
          </div>
          <div class="price-line tax">
            <span class="price-label">Tax ({{ state.taxRate }}%):</span>
            <span class="price-value">€{{ taxAmount.toFixed(2) }}</span>
          </div>
          <div class="price-line total">
            <span class="price-label">Total:</span>
            <span class="price-value">€{{ totalWithTax.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      
    </div>
    
    <!-- Actions -->
    <div class="action-area">
      <button class="action-btn primary" @click="handleConfirm">
        Confirm & Pay €{{ totalWithTax.toFixed(2) }}
      </button>
      <button class="action-btn secondary" @click="handleEdit">
        Edit Order
      </button>
    </div>
    
    <!-- Terms Notice -->
    <div class="terms-notice">
      <span class="terms-icon">ℹ️</span>
      <span class="terms-text">By confirming, you agree to our terms and conditions</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { computed, defineProps, defineEmits } from 'vue'

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

// Payment method label
const paymentMethodLabel = computed(() => {
  const method = props.state.paymentMethod
  if (method === 'card') return '💳 Card Payment'
  if (method === 'cash') return '💵 Cash Payment'
  if (method === 'mobile') return '📱 Mobile Payment'
  return 'Unknown'
})

// Calculate tax
const taxAmount = computed(() => {
  const subtotal = props.state.totalAmount || 1899
  return (subtotal * props.state.taxRate) / 100
})

// Total with tax
const totalWithTax = computed(() => {
  const subtotal = props.state.totalAmount || 1899
  return subtotal + taxAmount.value
})

const handleConfirm = () => {
  // Navigate to processing screen
  emit('navigate', 'processing')
}

const handleEdit = () => {
  // Go back to product selection
  emit('navigate', 'productSelect')
}
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
  color: #fff;
  padding: 1.5rem;
  overflow-y: auto;
}

.screen-header {
  text-align: center;
  margin-bottom: 1.5rem;
}

.screen-title {
  font-size: 1.75rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
}

.screen-subtitle {
  font-size: 0.95rem;
  color: #94a3b8;
}

.order-summary {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 1.5rem;
  overflow-y: auto;
}

.summary-section {
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(59, 130, 246, 0.2);
  border-radius: 0.75rem;
  padding: 1rem;
  animation: fadeInUp 0.4s ease-out both;
}

.summary-section:nth-child(1) {
  animation-delay: 0.1s;
}

.summary-section:nth-child(2) {
  animation-delay: 0.2s;
}

.summary-section:nth-child(3) {
  animation-delay: 0.3s;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.section-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid rgba(59, 130, 246, 0.2);
}

.section-icon {
  font-size: 1.25rem;
}

.section-title {
  font-size: 1rem;
  font-weight: bold;
  color: #fff;
}

.section-content {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.payment-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.5rem 1rem;
  background: rgba(59, 130, 246, 0.2);
  border: 1px solid rgba(59, 130, 246, 0.4);
  border-radius: 0.5rem;
  font-size: 0.95rem;
  font-weight: 600;
  color: #3b82f6;
}

.product-line {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
}

.product-name {
  flex: 1;
  color: #cbd5e1;
}

.product-qty {
  color: #94a3b8;
}

.product-price {
  font-weight: bold;
  color: #fff;
}

.price-line {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem 0;
  font-size: 0.95rem;
}

.price-label {
  color: #94a3b8;
}

.price-value {
  font-weight: bold;
  color: #fff;
}

.price-line.discount {
  color: #10b981;
}

.price-line.discount .price-label,
.price-line.discount .price-value {
  color: #10b981;
}

.price-line.tax {
  border-top: 1px solid rgba(59, 130, 246, 0.2);
  margin-top: 0.5rem;
  padding-top: 0.75rem;
}

.price-line.total {
  margin-top: 0.5rem;
  padding-top: 0.75rem;
  border-top: 2px solid rgba(59, 130, 246, 0.4);
}

.price-line.total .price-label {
  font-size: 1.125rem;
  font-weight: bold;
  color: #fff;
}

.price-line.total .price-value {
  font-size: 1.5rem;
  color: #3b82f6;
}

.action-area {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.action-btn {
  width: 100%;
  padding: 1rem 2rem;
  font-size: 1.125rem;
  font-weight: bold;
  border: none;
  border-radius: 0.75rem;
  cursor: pointer;
  transition: all 0.3s;
}

.action-btn.primary {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.action-btn.primary:hover {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
}

.action-btn.secondary {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.action-btn.secondary:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.action-btn:active {
  transform: translateY(0);
}

.terms-notice {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: rgba(59, 130, 246, 0.1);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 0.5rem;
}

.terms-icon {
  font-size: 1rem;
}

.terms-text {
  font-size: 0.8rem;
  color: #94a3b8;
}

/* Scrollbar Styling */
.order-summary::-webkit-scrollbar {
  width: 6px;
}

.order-summary::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}

.order-summary::-webkit-scrollbar-thumb {
  background: rgba(59, 130, 246, 0.5);
  border-radius: 3px;
}

.order-summary::-webkit-scrollbar-thumb:hover {
  background: rgba(59, 130, 246, 0.7);
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1rem;
  }
  
  .screen-title {
    font-size: 1.5rem;
  }
  
  .summary-section {
    padding: 0.75rem;
  }
  
  .section-title {
    font-size: 0.9rem;
  }
  
  .price-line.total .price-value {
    font-size: 1.25rem;
  }
}
</style>
