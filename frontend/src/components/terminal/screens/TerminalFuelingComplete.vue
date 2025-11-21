<template>
  <div class="terminal-screen-content fueling-complete-screen">
    
    <!-- Success Animation -->
    <div class="success-animation">
      <div class="success-circle">
        <CheckCircle :size="100" :stroke-width="2.5" class="success-icon" />
      </div>
    </div>
    
    <!-- Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.fuelingComplete.title').toUpperCase() }}</h2>
      <p class="screen-subtitle">{{ t('terminal.fuelingComplete.subtitle', { pump: state.pumpNumber }) }}</p>
    </div>
    
    <!-- Final Amounts -->
    <div class="amounts-container">
      
      <!-- Liters -->
      <div class="amount-box liters">
        <div class="amount-icon">
          <Droplet :size="40" :stroke-width="2.5" />
        </div>
        <div class="amount-label">{{ t('terminal.fuelingComplete.totalLiters').toUpperCase() }}</div>
        <div class="amount-value">{{ state.finalLiters.toFixed(2) }} L</div>
      </div>
      
      <!-- Euro Amount -->
      <div class="amount-box total">
        <div class="amount-icon">
          <Euro :size="40" :stroke-width="2.5" />
        </div>
        <div class="amount-label">{{ t('terminal.fuelingComplete.totalAmount').toUpperCase() }}</div>
        <div class="amount-value">€{{ state.finalAmount.toFixed(2) }}</div>
      </div>
      
    </div>
    
    <!-- Fuel Details -->
    <div class="fuel-details">
      <div class="detail-row">
        <span class="detail-label">{{ t('terminal.fuelingComplete.fuelType') }}:</span>
        <span class="detail-value">{{ fuelLabel }}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">{{ t('terminal.fuelingComplete.pricePerLiter') }}:</span>
        <span class="detail-value">€{{ state.pricePerLiter }}/L</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">{{ t('terminal.fuelingComplete.paymentMethod') }}:</span>
        <span class="detail-value">{{ paymentMethodLabel }}</span>
      </div>
    </div>
    
    <!-- Instructions -->
    <div class="instructions-box">
      <div class="instruction-icon">
        <Fuel :size="32" :stroke-width="2.5" />
      </div>
      <div class="instruction-text">
        <div class="instruction-title">{{ t('terminal.fuelingComplete.replaceNozzle').toUpperCase() }}</div>
        <div class="instruction-subtitle">{{ t('terminal.fuelingComplete.closeCapRemove') }}</div>
      </div>
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        @click="handleContinue"
      >
        {{ t('terminal.fuelingComplete.continue').toUpperCase() }} <ArrowRight :size="20" />
      </button>
    </div>
    
    <!-- Auto-advance Notice -->
    <div class="auto-advance-notice">
      <Clock :size="20" />
      <span>{{ t('terminal.fuelingComplete.advancingIn', { seconds: countdown }) }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { CheckCircle, Droplet, Euro, Fuel, ArrowRight, Clock } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const countdown = ref(5)
let countdownInterval: number

const fuelLabel = computed(() => {
  const fuel = props.state.fuelType
  if (fuel === 'diesel') return 'DIESEL'
  if (fuel === 'super') return 'SUPER 95'
  if (fuel === 'super-plus') return 'SUPER PLUS 98'
  if (fuel === 'e10') return 'SUPER E10'
  return 'FUEL'
})

const paymentMethodLabel = computed(() => {
  const method = props.state.paymentMethod
  if (method === 'card') return 'Card Payment'
  if (method === 'cash') return 'Cash'
  if (method === 'mobile') return 'Mobile Payment'
  return 'Paid'
})

const handleContinue = () => {
  clearInterval(countdownInterval)
  navigateToSuccess()
}

const navigateToSuccess = () => {
  // Navigate to success/receipt screen
  emit('navigate', 'success')
}

onMounted(() => {
  // Start countdown
  countdownInterval = window.setInterval(() => {
    countdown.value--
    
    if (countdown.value <= 0) {
      clearInterval(countdownInterval)
      navigateToSuccess()
    }
  }, 1000)
})

onUnmounted(() => {
  if (countdownInterval) {
    clearInterval(countdownInterval)
  }
})
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #1f2937;
  color: #fff;
  padding: 2rem;
  align-items: center;
}

.success-animation {
  margin-bottom: 1.5rem;
  animation: scaleIn 0.6s ease-out;
}

@keyframes scaleIn {
  0% {
    opacity: 0;
    transform: scale(0);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}

.success-circle {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: rgba(34, 197, 94, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 0 30px rgba(34, 197, 94, 0.4);
  animation: pulse-ring 2s infinite;
}

@keyframes pulse-ring {
  0%, 100% {
    box-shadow: 0 0 20px rgba(34, 197, 94, 0.4);
  }
  50% {
    box-shadow: 0 0 40px rgba(34, 197, 94, 0.6);
  }
}

.success-icon {
  color: #22c55e;
  animation: rotate 0.6s ease-out 0.3s;
}

@keyframes rotate {
  0% {
    transform: rotate(-180deg);
    opacity: 0;
  }
  100% {
    transform: rotate(0deg);
    opacity: 1;
  }
}

.screen-header {
  text-align: center;
  margin-bottom: 2rem;
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

.screen-title {
  font-size: 2rem;
  font-weight: bold;
  color: #22c55e;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
}

.screen-subtitle {
  font-size: 1rem;
  color: #9ca3af;
}

.amounts-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  width: 100%;
  max-width: 500px;
  margin-bottom: 2rem;
  animation: fadeInUp 0.5s ease-out 0.5s both;
}

.amount-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid;
  border-radius: 0.75rem;
}

.amount-box.liters {
  border-color: #22c55e;
}

.amount-box.total {
  border-color: #fbbf24;
}

.amount-icon {
  margin-bottom: 0.75rem;
}

.amount-box.liters .amount-icon {
  color: #22c55e;
}

.amount-box.total .amount-icon {
  color: #fbbf24;
}

.amount-label {
  font-size: 0.75rem;
  color: #9ca3af;
  margin-bottom: 0.5rem;
  font-weight: bold;
  letter-spacing: 0.5px;
}

.amount-value {
  font-size: 2rem;
  font-weight: bold;
  color: #fff;
  font-family: monospace;
  line-height: 1;
}

.fuel-details {
  width: 100%;
  max-width: 500px;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.3);
  border: 2px solid #4b5563;
  border-radius: 0.75rem;
  margin-bottom: 1.5rem;
  animation: fadeInUp 0.5s ease-out 0.6s both;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.95rem;
}

.detail-label {
  color: #9ca3af;
}

.detail-value {
  color: #fff;
  font-weight: bold;
}

.instructions-box {
  display: flex;
  align-items: center;
  gap: 1rem;
  width: 100%;
  max-width: 500px;
  padding: 1.25rem;
  background: rgba(59, 130, 246, 0.1);
  border: 3px solid #3b82f6;
  border-radius: 0.75rem;
  margin-bottom: 1.5rem;
  animation: fadeInUp 0.5s ease-out 0.7s both;
}

.instruction-icon {
  color: #3b82f6;
  flex-shrink: 0;
}

.instruction-text {
  flex: 1;
}

.instruction-title {
  font-size: 1rem;
  font-weight: bold;
  color: #3b82f6;
  margin-bottom: 0.25rem;
  letter-spacing: 0.5px;
}

.instruction-subtitle {
  font-size: 0.85rem;
  color: #93c5fd;
}

.action-area {
  width: 100%;
  max-width: 500px;
  margin-bottom: 1rem;
  animation: fadeInUp 0.5s ease-out 0.8s both;
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

.continue-btn:hover {
  background: #16a34a;
  transform: translateY(-2px);
  box-shadow: 
    0 8px 0 #15803d,
    0 10px 16px rgba(0, 0, 0, 0.4);
}

.continue-btn:active {
  transform: translateY(4px);
  box-shadow: 
    0 2px 0 #16a34a,
    0 4px 8px rgba(0, 0, 0, 0.3);
}

.auto-advance-notice {
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
  animation: fadeInUp 0.5s ease-out 0.9s both;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .success-circle {
    width: 100px;
    height: 100px;
  }
  
  .success-icon {
    width: 80px;
    height: 80px;
  }
  
  .screen-title {
    font-size: 1.75rem;
  }
  
  .amounts-container {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .amount-box {
    padding: 1.25rem;
  }
  
  .amount-value {
    font-size: 1.75rem;
  }
  
  .fuel-details {
    padding: 1.25rem;
  }
}
</style>
