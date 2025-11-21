<template>
  <div class="terminal-screen-content product-select-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">Bundle Products</h2>
      <p class="screen-subtitle">Your complete POS terminal package</p>
    </div>
    
    <!-- Products List -->
    <div class="products-container">
      
      <!-- Product Item 1: POS Terminal -->
      <div class="product-item">
        <div class="product-icon">🖥️</div>
        <div class="product-details">
          <div class="product-name">POS Terminal</div>
          <div class="product-description">Touchscreen, receipt printer, payment processing</div>
        </div>
        <div class="product-price">€1,299</div>
        <div class="product-check">✓</div>
      </div>
      
      <!-- Product Item 2: Menu Board -->
      <div class="product-item">
        <div class="product-icon">💡</div>
        <div class="product-details">
          <div class="product-name">LED Menu Board</div>
          <div class="product-description">120×80cm, fully customizable, LED-backlit</div>
        </div>
        <div class="product-price">€899</div>
        <div class="product-check">✓</div>
      </div>
      
      <!-- Product Item 3: Installation -->
      <div class="product-item">
        <div class="product-icon">🔧</div>
        <div class="product-details">
          <div class="product-name">Professional Installation</div>
          <div class="product-description">Setup, training, and 3-year warranty</div>
        </div>
        <div class="product-price free">FREE</div>
        <div class="product-check">✓</div>
      </div>
      
      <!-- Product Item 4: Software Setup -->
      <div class="product-item">
        <div class="product-icon">⚙️</div>
        <div class="product-details">
          <div class="product-name">Software Setup & Training</div>
          <div class="product-description">Full configuration and user training</div>
        </div>
        <div class="product-price free">FREE</div>
        <div class="product-check">✓</div>
      </div>
      
    </div>
    
    <!-- Pricing Summary -->
    <div class="pricing-summary">
      <div class="summary-row">
        <span class="summary-label">Subtotal:</span>
        <span class="summary-value original">€2,499</span>
      </div>
      <div class="summary-row discount">
        <span class="summary-label">Bundle Discount (20%):</span>
        <span class="summary-value">-€600</span>
      </div>
      <div class="summary-row total">
        <span class="summary-label">Total:</span>
        <span class="summary-value">€1,899</span>
      </div>
    </div>
    
    <!-- Action Button -->
    <div class="action-area">
      <button class="continue-btn" @click="handleContinue">
        Continue to Review →
      </button>
    </div>
    
    <!-- Savings Badge -->
    <div class="savings-badge">
      <span class="badge-icon">🎉</span>
      <span class="badge-text">You save €600 with this bundle!</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { defineProps, defineEmits } from 'vue'

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const handleContinue = () => {
  // Update state with selected products
  emit('update-state', {
    selectedProducts: [
      { id: '1', name: 'POS Terminal', price: 1299, quantity: 1 },
      { id: '2', name: 'LED Menu Board', price: 899, quantity: 1 },
      { id: '3', name: 'Professional Installation', price: 0, quantity: 1 },
      { id: '4', name: 'Software Setup & Training', price: 0, quantity: 1 }
    ],
    totalAmount: 1899
  })
  
  // Navigate to review screen
  emit('navigate', 'review')
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

.products-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin-bottom: 1rem;
  overflow-y: auto;
}

.product-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(59, 130, 246, 0.2);
  border-radius: 0.75rem;
  transition: all 0.3s;
  animation: slideInLeft 0.4s ease-out both;
}

.product-item:nth-child(1) {
  animation-delay: 0.1s;
}

.product-item:nth-child(2) {
  animation-delay: 0.2s;
}

.product-item:nth-child(3) {
  animation-delay: 0.3s;
}

.product-item:nth-child(4) {
  animation-delay: 0.4s;
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.product-item:hover {
  background: rgba(59, 130, 246, 0.1);
  border-color: rgba(59, 130, 246, 0.4);
  transform: translateX(5px);
}

.product-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.product-details {
  flex: 1;
  min-width: 0;
}

.product-name {
  font-size: 1rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.25rem;
}

.product-description {
  font-size: 0.75rem;
  color: #94a3b8;
  line-height: 1.3;
}

.product-price {
  font-size: 1rem;
  font-weight: bold;
  color: #3b82f6;
  flex-shrink: 0;
}

.product-price.free {
  color: #10b981;
}

.product-check {
  font-size: 1.25rem;
  color: #10b981;
  flex-shrink: 0;
}

.pricing-summary {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 0.75rem;
  margin-bottom: 1rem;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.summary-label {
  font-size: 0.95rem;
  color: #94a3b8;
}

.summary-value {
  font-size: 1rem;
  font-weight: bold;
  color: #fff;
}

.summary-value.original {
  text-decoration: line-through;
  color: #64748b;
}

.summary-row.discount {
  color: #10b981;
}

.summary-row.discount .summary-label {
  color: #10b981;
}

.summary-row.discount .summary-value {
  color: #10b981;
}

.summary-row.total {
  margin-top: 0.5rem;
  padding-top: 0.75rem;
  border-top: 2px solid rgba(59, 130, 246, 0.3);
}

.summary-row.total .summary-label {
  font-size: 1.125rem;
  font-weight: bold;
  color: #fff;
}

.summary-row.total .summary-value {
  font-size: 1.5rem;
  color: #3b82f6;
}

.action-area {
  margin-bottom: 1rem;
}

.continue-btn {
  width: 100%;
  padding: 1rem 2rem;
  font-size: 1.125rem;
  font-weight: bold;
  color: white;
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
  border: none;
  border-radius: 0.75rem;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.continue-btn:hover {
  background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
}

.continue-btn:active {
  transform: translateY(0);
}

.savings-badge {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  border-radius: 0.5rem;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.badge-icon {
  font-size: 1.25rem;
}

.badge-text {
  font-size: 0.9rem;
  font-weight: bold;
  color: #fff;
}

/* Scrollbar Styling */
.products-container::-webkit-scrollbar {
  width: 6px;
}

.products-container::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}

.products-container::-webkit-scrollbar-thumb {
  background: rgba(59, 130, 246, 0.5);
  border-radius: 3px;
}

.products-container::-webkit-scrollbar-thumb:hover {
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
  
  .product-item {
    padding: 0.75rem;
  }
  
  .product-icon {
    font-size: 1.5rem;
  }
  
  .product-name {
    font-size: 0.9rem;
  }
  
  .product-description {
    font-size: 0.7rem;
  }
  
  .product-price {
    font-size: 0.9rem;
  }
}
</style>
