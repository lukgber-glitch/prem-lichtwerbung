<template>
  <div class="terminal-screen-content success-screen">
    
    <!-- Success Animation -->
    <div class="success-animation">
      <div class="checkmark-circle">
        <div class="checkmark">
          <CheckCircle :size="64" :stroke-width="2" />
        </div>
      </div>
    </div>
    
    <!-- Success Message -->
    <div class="success-content">
      <h2 class="success-title">{{ t('terminal.success.title') }}</h2>
      <p class="success-subtitle">{{ t('terminal.success.subtitle') }}</p>
      
      <!-- Order Number -->
      <div class="order-number">
        <span class="order-label">{{ t('terminal.success.orderNumber') }}:</span>
        <span class="order-value">#{{ orderNumber }}</span>
      </div>
    </div>
    
    <!-- Receipt Preview -->
    <div class="receipt-preview">
      <div class="receipt-header">
        <div class="receipt-logo">
          <Fuel :size="32" :stroke-width="2" />
        </div>
        <div class="receipt-company">Prem Tankstelle</div>
        <div class="receipt-date">{{ formattedDate }}</div>
      </div>
      
      <div class="receipt-divider"></div>
      
      <div class="receipt-items">
        <div class="receipt-item">
          <span class="item-name">{{ t('terminal.success.pumpNumber') }}:</span>
          <span class="item-price">#{{ state.pumpNumber || 1 }}</span>
        </div>
        <div class="receipt-item">
          <span class="item-name">{{ t('terminal.success.fuelType') }}:</span>
          <span class="item-price">{{ state.fuelType || 'Super 95' }}</span>
        </div>
        <div class="receipt-item">
          <span class="item-name">{{ t('terminal.success.litersDispensed') }}:</span>
          <span class="item-price">{{ (state.finalLiters || 0).toFixed(2) }}L</span>
        </div>
        <div class="receipt-item">
          <span class="item-name">{{ t('terminal.success.pricePerLiter') }}:</span>
          <span class="item-price">€{{ (state.pricePerLiter || 0).toFixed(3) }}</span>
        </div>
      </div>
      
      <div class="receipt-divider"></div>
      
      <div class="receipt-total">
        <span class="total-label">{{ t('terminal.success.total').toUpperCase() }}</span>
        <span class="total-value">€{{ (state.finalAmount || 0).toFixed(2) }}</span>
      </div>
      
      <div class="receipt-payment">
        <span class="payment-label">{{ t('terminal.success.paymentMethod') }}:</span>
        <span class="payment-value">{{ paymentMethodLabel }}</span>
      </div>
      
      <div class="receipt-payment">
        <span class="payment-label">{{ t('terminal.success.transactionId') }}:</span>
        <span class="payment-value">{{ orderNumber }}</span>
      </div>
    </div>
    
    <!-- Actions -->
    <div class="success-actions">
      <button class="action-btn primary" @click="handleAddToCart">
        {{ t('terminal.success.addToCart') }}
      </button>
      <button class="action-btn secondary" @click="handleNewTransaction">
        {{ t('terminal.success.newTransaction') }}
      </button>
    </div>
    
    <!-- Footer Message -->
    <div class="success-footer">
      <div class="footer-message">
        <div class="footer-line">
          <Mail :size="16" :stroke-width="2" />
          <span>{{ t('terminal.success.receiptAvailable') }}</span>
        </div>
        <div class="footer-line">
          <Sparkles :size="16" :stroke-width="2" />
          <span>{{ t('terminal.success.thankYou') }}</span>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { computed, defineProps, defineEmits, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { CheckCircle, Fuel, Mail, Sparkles } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state', 'complete'])

// Generate order number
const orderNumber = computed(() => {
  if (props.state.orderNumber) return props.state.orderNumber
  return 'TRM' + Date.now().toString().slice(-8)
})

// Format current date and time
const formattedDate = computed(() => {
  const now = new Date()
  return now.toLocaleString('en-US', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  })
})

// Payment method label
const paymentMethodLabel = computed(() => {
  const method = props.state.paymentMethod
  if (method === 'card') return 'Card Payment'
  if (method === 'cash') return 'Cash Payment'
  if (method === 'mobile') return 'Mobile Payment'
  return 'Unknown'
})

onMounted(() => {
  // Update state with order number
  emit('update-state', { orderNumber: orderNumber.value })
})

const handleAddToCart = () => {
  // Emit complete event with order data
  emit('complete', {
    orderNumber: orderNumber.value,
    products: props.state.selectedProducts,
    total: props.state.totalAmount,
    paymentMethod: props.state.paymentMethod
  })
}

const handleNewTransaction = () => {
  // Reset and go back to welcome
  emit('navigate', 'welcome')
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

.success-screen {
  align-items: center;
}

/* Success Animation */
.success-animation {
  margin-bottom: 1.5rem;
  animation: scaleIn 0.5s ease-out;
}

@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.checkmark-circle {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 
    0 0 0 0 rgba(16, 185, 129, 1),
    0 10px 30px rgba(16, 185, 129, 0.3);
  animation: pulse-ring 2s infinite;
}

@keyframes pulse-ring {
  0% {
    box-shadow: 
      0 0 0 0 rgba(16, 185, 129, 0.7),
      0 10px 30px rgba(16, 185, 129, 0.3);
  }
  50% {
    box-shadow: 
      0 0 0 20px rgba(16, 185, 129, 0),
      0 10px 30px rgba(16, 185, 129, 0.3);
  }
  100% {
    box-shadow: 
      0 0 0 0 rgba(16, 185, 129, 0),
      0 10px 30px rgba(16, 185, 129, 0.3);
  }
}

.checkmark {
  font-size: 4rem;
  color: white;
  font-weight: bold;
  animation: checkmarkPop 0.5s ease-out 0.3s both;
}

@keyframes checkmarkPop {
  0% {
    opacity: 0;
    transform: scale(0) rotate(-45deg);
  }
  50% {
    transform: scale(1.2) rotate(10deg);
  }
  100% {
    opacity: 1;
    transform: scale(1) rotate(0deg);
  }
}

/* Success Content */
.success-content {
  text-align: center;
  margin-bottom: 1.5rem;
  animation: fadeInUp 0.5s ease-out 0.4s both;
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

.success-title {
  font-size: 2rem;
  font-weight: bold;
  color: #10b981;
  margin-bottom: 0.5rem;
}

.success-subtitle {
  font-size: 1rem;
  color: #94a3b8;
  margin-bottom: 1rem;
}

.order-number {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: rgba(59, 130, 246, 0.1);
  border: 2px solid rgba(59, 130, 246, 0.3);
  border-radius: 0.5rem;
}

.order-label {
  font-size: 0.9rem;
  color: #94a3b8;
}

.order-value {
  font-size: 1.125rem;
  font-weight: bold;
  color: #3b82f6;
  font-family: monospace;
}

/* Receipt Preview */
.receipt-preview {
  width: 100%;
  max-width: 350px;
  background: white;
  color: #000;
  padding: 1.5rem;
  border-radius: 0.5rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  margin-bottom: 1.5rem;
  font-family: 'Courier New', monospace;
  animation: slideInUp 0.5s ease-out 0.5s both;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.receipt-header {
  text-align: center;
  margin-bottom: 1rem;
}

.receipt-logo {
  font-size: 2rem;
  margin-bottom: 0.5rem;
}

.receipt-company {
  font-size: 1rem;
  font-weight: bold;
  margin-bottom: 0.25rem;
}

.receipt-date {
  font-size: 0.75rem;
  color: #666;
}

.receipt-divider {
  border-top: 2px dashed #ccc;
  margin: 1rem 0;
}

.receipt-items {
  margin-bottom: 1rem;
}

.receipt-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.5rem;
  font-size: 0.85rem;
}

.item-name {
  flex: 1;
  color: #333;
}

.item-price {
  font-weight: bold;
  color: #000;
}

.receipt-total {
  display: flex;
  justify-content: space-between;
  font-size: 1.125rem;
  font-weight: bold;
  padding: 0.75rem 0;
  border-top: 2px solid #000;
  border-bottom: 2px solid #000;
  margin-bottom: 0.75rem;
}

.receipt-payment {
  display: flex;
  justify-content: space-between;
  font-size: 0.8rem;
  color: #666;
}

/* Actions */
.success-actions {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  width: 100%;
  max-width: 350px;
  margin-bottom: 1rem;
  animation: fadeIn 0.5s ease-out 0.6s both;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
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
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.action-btn.primary:hover {
  background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
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

/* Footer */
.success-footer {
  text-align: center;
  animation: fadeIn 0.5s ease-out 0.7s both;
}

.footer-message {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  font-size: 0.85rem;
  color: #94a3b8;
  line-height: 1.6;
}

.footer-line {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1rem;
  }
  
  .checkmark-circle {
    width: 80px;
    height: 80px;
  }
  
  .checkmark {
    font-size: 3rem;
  }
  
  .success-title {
    font-size: 1.75rem;
  }
  
  .receipt-preview {
    padding: 1rem;
  }
}
</style>
