<template>
  <div class="terminal-screen-content payment-method-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.paymentMethod.title') }}</h2>
      <p class="screen-subtitle">{{ t('terminal.paymentMethod.subtitle') }}</p>
    </div>
    
    <!-- Payment Options Grid -->
    <div class="payment-options">
      
      <!-- Card Payment -->
      <div 
        class="payment-option"
        :class="{ selected: selectedMethod === 'card' }"
        @click="selectPaymentMethod('card')"
      >
        <div class="option-icon">
          <CreditCard :size="64" :stroke-width="2" />
        </div>
        <div class="option-label">{{ t('terminal.paymentMethod.card') }}</div>
        <div class="option-description">{{ t('terminal.paymentMethod.debitCredit') }}</div>
        <div class="option-badge">{{ t('terminal.paymentMethod.mostPopular') }}</div>
      </div>
      
      <!-- Cash Payment -->
      <div 
        class="payment-option"
        :class="{ selected: selectedMethod === 'cash' }"
        @click="selectPaymentMethod('cash')"
      >
        <div class="option-icon">
          <Banknote :size="64" :stroke-width="2" />
        </div>
        <div class="option-label">{{ t('terminal.paymentMethod.cash') }}</div>
        <div class="option-description">{{ t('terminal.paymentMethod.billsCoins') }}</div>
      </div>
      
      <!-- Mobile Payment -->
      <div 
        class="payment-option"
        :class="{ selected: selectedMethod === 'mobile' }"
        @click="selectPaymentMethod('mobile')"
      >
        <div class="option-icon">
          <Smartphone :size="64" :stroke-width="2" />
        </div>
        <div class="option-label">{{ t('terminal.paymentMethod.mobile') }}</div>
        <div class="option-description">{{ t('terminal.paymentMethod.applePay') }}</div>
        <div class="option-badge new">{{ t('terminal.paymentMethod.new') }}</div>
      </div>
      
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        :disabled="!selectedMethod"
        @click="handleContinue"
      >
        <span v-if="selectedMethod">
          {{ t('terminal.paymentMethod.continue') }} <ArrowRight :size="20" />
        </span>
        <span v-else>{{ t('terminal.paymentMethod.selectMethod') }}</span>
      </button>
    </div>
    
    <!-- Security Notice -->
    <div class="security-notice">
      <Lock :size="20" :stroke-width="2" />
      <span class="security-text">{{ t('terminal.paymentMethod.secureText') }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { CreditCard, Banknote, Smartphone, Lock, ArrowRight } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const selectedMethod = ref<'card' | 'cash' | 'mobile' | null>(props.state.paymentMethod || null)

const selectPaymentMethod = (method: 'card' | 'cash' | 'mobile') => {
  selectedMethod.value = method
  
  // Update state
  emit('update-state', { paymentMethod: method })
}

const handleContinue = () => {
  if (!selectedMethod.value) return
  
  // Navigate to processing for gas station flow
  emit('navigate', 'processing')
}
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
  color: #fff;
  padding: 2rem;
}

.screen-header {
  text-align: center;
  margin-bottom: 2rem;
}

.screen-title {
  font-size: 1.75rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
}

.screen-subtitle {
  font-size: 1rem;
  color: #94a3b8;
}

.payment-options {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
  flex: 1;
  margin-bottom: 1.5rem;
}

.payment-option {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(59, 130, 246, 0.2);
  border-radius: 1rem;
  cursor: pointer;
  transition: all 0.3s;
  min-height: 120px;
}

.payment-option:hover {
  background: rgba(59, 130, 246, 0.1);
  border-color: rgba(59, 130, 246, 0.4);
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
}

.payment-option.selected {
  background: rgba(59, 130, 246, 0.2);
  border-color: #3b82f6;
  border-width: 3px;
  box-shadow: 
    0 0 20px rgba(59, 130, 246, 0.4),
    inset 0 0 20px rgba(59, 130, 246, 0.1);
}

.payment-option.selected::after {
  content: '✓';
  position: absolute;
  top: 0.75rem;
  right: 0.75rem;
  width: 28px;
  height: 28px;
  background: #10b981;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
  font-weight: bold;
  box-shadow: 0 2px 8px rgba(16, 185, 129, 0.4);
}

.option-icon {
  font-size: 3rem;
  margin-bottom: 0.75rem;
}

.option-label {
  font-size: 1.25rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.25rem;
}

.option-description {
  font-size: 0.85rem;
  color: #94a3b8;
}

.option-badge {
  position: absolute;
  top: 0.75rem;
  left: 0.75rem;
  padding: 0.25rem 0.75rem;
  background: #f59e0b;
  color: #fff;
  font-size: 0.7rem;
  font-weight: bold;
  border-radius: 0.25rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.option-badge.new {
  background: #10b981;
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

.continue-btn:hover:not(:disabled) {
  background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
}

.continue-btn:active:not(:disabled) {
  transform: translateY(0);
}

.continue-btn:disabled {
  background: rgba(100, 116, 139, 0.5);
  cursor: not-allowed;
  box-shadow: none;
  opacity: 0.6;
}

.security-notice {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.2);
  border-radius: 0.5rem;
}

.security-icon {
  font-size: 1.25rem;
}

.security-text {
  font-size: 0.85rem;
  color: #10b981;
  font-weight: 500;
}

/* Animations */
@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.payment-option:nth-child(1) {
  animation: slideInUp 0.3s ease-out 0.1s both;
}

.payment-option:nth-child(2) {
  animation: slideInUp 0.3s ease-out 0.2s both;
}

.payment-option:nth-child(3) {
  animation: slideInUp 0.3s ease-out 0.3s both;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.5rem;
  }
  
  .payment-option {
    min-height: 100px;
    padding: 1.25rem;
  }
  
  .option-icon {
    font-size: 2.5rem;
  }
  
  .option-label {
    font-size: 1.1rem;
  }
}
</style>
