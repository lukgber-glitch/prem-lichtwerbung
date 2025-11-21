<template>
  <div class="terminal-screen-content payment-timing-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">WHEN WOULD YOU LIKE TO PAY?</h2>
      <p class="screen-subtitle">Choose your preferred payment timing</p>
    </div>
    
    <!-- Payment Timing Options -->
    <div class="timing-options">
      
      <!-- Pay Now Option -->
      <div 
        class="timing-option"
        :class="{ selected: selectedTiming === 'now' }"
        @click="selectTiming('now')"
      >
        <div class="option-icon">
          <CreditCard :size="64" :stroke-width="2" />
        </div>
        <div class="option-badge recommended">RECOMMENDED</div>
        <div class="option-label">PAY NOW</div>
        <div class="option-description">
          Pre-authorize your card. Pump stops automatically at approved amount.
        </div>
        <ul class="option-benefits">
          <li><Check :size="16" /> Faster checkout</li>
          <li><Check :size="16" /> Pump activates immediately</li>
          <li><Check :size="16" /> No need to return inside</li>
        </ul>
      </div>
      
      <!-- Pay After Option -->
      <div 
        class="timing-option"
        :class="{ selected: selectedTiming === 'after' }"
        @click="selectTiming('after')"
      >
        <div class="option-icon">
          <Fuel :size="64" :stroke-width="2" />
        </div>
        <div class="option-label">PAY AFTER FUELING</div>
        <div class="option-description">
          Pump first, then come inside to pay at the counter.
        </div>
        <ul class="option-benefits">
          <li><Check :size="16" /> Traditional method</li>
          <li><Check :size="16" /> Pay exact amount</li>
          <li><Check :size="16" /> Cash or card inside</li>
        </ul>
      </div>
      
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        :disabled="!selectedTiming"
        @click="handleContinue"
      >
        <span v-if="selectedTiming">
          CONTINUE <ArrowRight :size="20" />
        </span>
        <span v-else>SELECT PAYMENT TIMING</span>
      </button>
    </div>
    
    <!-- Help Notice -->
    <div class="help-notice">
      <Info :size="20" />
      <span>Need assistance? Press the help button on the terminal</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits } from 'vue'
import { CreditCard, Fuel, ArrowRight, Check, Info } from 'lucide-vue-next'

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const selectedTiming = ref<'now' | 'after' | null>(null)

const selectTiming = (timing: 'now' | 'after') => {
  selectedTiming.value = timing
  
  // Update state
  emit('update-state', { paymentTiming: timing })
}

const handleContinue = () => {
  if (!selectedTiming.value) return
  
  // Navigate to pump selection
  emit('navigate', 'pumpSelection')
}
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #1f2937;
  color: #fff;
  padding: 2rem;
}

.screen-header {
  text-align: center;
  margin-bottom: 2rem;
}

.screen-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
}

.screen-subtitle {
  font-size: 1rem;
  color: #9ca3af;
}

.timing-options {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  flex: 1;
  margin-bottom: 1.5rem;
}

.timing-option {
  position: relative;
  display: flex;
  flex-direction: column;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 3px solid #4b5563;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.3s;
}

.timing-option:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: #6b7280;
  transform: translateY(-2px);
}

.timing-option.selected {
  background: rgba(34, 197, 94, 0.15);
  border-color: #22c55e;
  border-width: 4px;
  box-shadow: 0 0 20px rgba(34, 197, 94, 0.3);
}

.timing-option.selected::after {
  content: '✓';
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 36px;
  height: 36px;
  background: #22c55e;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: bold;
  box-shadow: 0 2px 8px rgba(34, 197, 94, 0.4);
}

.option-icon {
  display: flex;
  justify-content: center;
  margin-bottom: 1rem;
  color: #22c55e;
}

.option-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  padding: 0.4rem 0.8rem;
  background: #22c55e;
  color: #000;
  font-size: 0.7rem;
  font-weight: bold;
  border-radius: 0.25rem;
  letter-spacing: 0.5px;
}

.option-badge.recommended {
  background: #22c55e;
  animation: pulse-badge 2s infinite;
}

@keyframes pulse-badge {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
}

.option-label {
  font-size: 1.5rem;
  font-weight: bold;
  color: #fff;
  text-align: center;
  margin-bottom: 0.75rem;
  letter-spacing: 1px;
}

.option-description {
  font-size: 0.95rem;
  color: #d1d5db;
  text-align: center;
  line-height: 1.5;
  margin-bottom: 1rem;
}

.option-benefits {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.option-benefits li {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  color: #9ca3af;
}

.option-benefits li svg {
  color: #22c55e;
  flex-shrink: 0;
}

.action-area {
  margin-bottom: 1rem;
}

.continue-btn {
  width: 100%;
  padding: 1.25rem 2rem;
  font-size: 1.25rem;
  font-weight: bold;
  color: #000;
  background: #22c55e;
  border: 4px solid #16a34a;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 
    0 6px 0 #16a34a,
    0 8px 12px rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  letter-spacing: 1px;
}

.continue-btn:hover:not(:disabled) {
  background: #16a34a;
  transform: translateY(-2px);
  box-shadow: 
    0 8px 0 #15803d,
    0 10px 16px rgba(0, 0, 0, 0.4);
}

.continue-btn:active:not(:disabled) {
  transform: translateY(4px);
  box-shadow: 
    0 2px 0 #16a34a,
    0 4px 8px rgba(0, 0, 0, 0.3);
}

.continue-btn:disabled {
  background: #4b5563;
  border-color: #374151;
  color: #9ca3af;
  cursor: not-allowed;
  box-shadow: 
    0 6px 0 #374151,
    0 8px 12px rgba(0, 0, 0, 0.3);
}

.help-notice {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: rgba(59, 130, 246, 0.1);
  border: 2px solid rgba(59, 130, 246, 0.3);
  border-radius: 0.5rem;
  font-size: 0.85rem;
  color: #93c5fd;
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

.timing-option:nth-child(1) {
  animation: slideInUp 0.4s ease-out;
}

.timing-option:nth-child(2) {
  animation: slideInUp 0.4s ease-out 0.1s both;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.25rem;
  }
  
  .timing-option {
    padding: 1.5rem;
  }
  
  .option-icon svg {
    width: 48px;
    height: 48px;
  }
  
  .option-label {
    font-size: 1.25rem;
  }
}
</style>
