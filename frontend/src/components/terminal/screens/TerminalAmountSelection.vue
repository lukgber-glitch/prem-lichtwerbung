<template>
  <div class="terminal-screen-content amount-selection-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.amountSelection.title') }}</h2>
      <p class="screen-subtitle">{{ t('terminal.amountSelection.subtitle', { pump: state.pumpNumber, fuel: fuelLabel, price: state.pricePerLiter }) }}</p>
    </div>
    
    <!-- Selection Method Tabs -->
    <div class="selection-tabs">
      <button 
        class="tab-btn"
        :class="{ active: selectionMode === 'fillTank' }"
        @click="setSelectionMode('fillTank')"
      >
        <Gauge :size="20" />
        {{ t('terminal.amountSelection.fillTank').toUpperCase() }}
      </button>
      <button 
        class="tab-btn"
        :class="{ active: selectionMode === 'amount' }"
        @click="setSelectionMode('amount')"
      >
        <Euro :size="20" />
        {{ t('terminal.amountSelection.enterAmount').toUpperCase() }}
      </button>
      <button 
        class="tab-btn"
        :class="{ active: selectionMode === 'liters' }"
        @click="setSelectionMode('liters')"
      >
        <Droplet :size="20" />
        {{ t('terminal.amountSelection.enterLiters').toUpperCase() }}
      </button>
    </div>
    
    <!-- Content Area -->
    <div class="content-area">
      
      <!-- Fill Tank Mode -->
      <div v-if="selectionMode === 'fillTank'" class="fill-tank-content">
        <div class="fill-tank-icon">
          <Gauge :size="80" :stroke-width="2" />
        </div>
        <div class="fill-tank-label">{{ t('terminal.amountSelection.fillTank').toUpperCase() }}</div>
        <div class="fill-tank-description">
          {{ t('terminal.amountSelection.fillTankDesc') }}
        </div>
        <div class="estimated-amount">
          {{ t('terminal.amountSelection.estimated') }}: ~50L = ~€{{ (50 * state.pricePerLiter).toFixed(2) }}
        </div>
      </div>
      
      <!-- Enter Amount/Liters Mode -->
      <div v-else class="input-content">
        
        <!-- Current Input Display -->
        <div class="input-display">
          <div class="input-value">
            <span v-if="selectionMode === 'amount'">€</span>
            {{ displayValue }}
            <span v-if="selectionMode === 'liters'">L</span>
          </div>
          <div class="conversion-text" v-if="inputValue">
            <span v-if="selectionMode === 'amount'">
              ≈ {{ (parseFloat(inputValue) / state.pricePerLiter).toFixed(2) }}L
            </span>
            <span v-else>
              ≈ €{{ (parseFloat(inputValue) * state.pricePerLiter).toFixed(2) }}
            </span>
          </div>
        </div>
        
        <!-- Quick Select Buttons (Amount Mode Only) -->
        <div v-if="selectionMode === 'amount'" class="quick-select">
          <button 
            v-for="preset in quickSelectAmounts"
            :key="preset"
            class="quick-btn"
            @click="setQuickAmount(preset)"
          >
            €{{ preset }}
          </button>
        </div>
        
        <!-- Number Pad -->
        <div class="number-pad">
          <button 
            v-for="num in [1, 2, 3, 4, 5, 6, 7, 8, 9]"
            :key="num"
            class="num-btn"
            @click="addDigit(num.toString())"
          >
            {{ num }}
          </button>
          <button class="num-btn" @click="addDigit('0')">0</button>
          <button class="num-btn" @click="addDecimal">.</button>
          <button class="num-btn clear" @click="clearInput">
            <X :size="24" />
          </button>
        </div>
        
      </div>
      
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        :disabled="!isValidSelection"
        @click="handleContinue"
      >
        <span v-if="isValidSelection">
          {{ t('terminal.amountSelection.continue') }} <ArrowRight :size="20" />
        </span>
        <span v-else>{{ t('terminal.amountSelection.enterAmountPrompt') }}</span>
      </button>
    </div>
    
    <!-- Help Notice -->
    <div class="help-notice">
      <Info :size="20" />
      <span>{{ t('terminal.amountSelection.helpText') }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { Gauge, Euro, Droplet, ArrowRight, Info, X } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const selectionMode = ref<'fillTank' | 'amount' | 'liters'>('fillTank')
const inputValue = ref<string>('')
const quickSelectAmounts = [20, 30, 50, 75, 100]

const fuelLabel = computed(() => {
  const fuel = props.state.fuelType
  if (fuel === 'diesel') return 'DIESEL'
  if (fuel === 'super') return 'SUPER 95'
  if (fuel === 'super-plus') return 'SUPER PLUS 98'
  if (fuel === 'e10') return 'SUPER E10'
  return 'FUEL'
})

const displayValue = computed(() => {
  return inputValue.value || '0'
})

const isValidSelection = computed(() => {
  if (selectionMode.value === 'fillTank') return true
  
  const value = parseFloat(inputValue.value)
  if (isNaN(value) || value <= 0) return false
  
  // Check maximum limits
  if (selectionMode.value === 'amount' && value > 150) return false
  if (selectionMode.value === 'liters' && value > 100) return false
  
  return true
})

const setSelectionMode = (mode: 'fillTank' | 'amount' | 'liters') => {
  selectionMode.value = mode
  inputValue.value = ''
}

const addDigit = (digit: string) => {
  // Limit input length
  if (inputValue.value.length >= 6) return
  
  // Don't allow leading zeros
  if (inputValue.value === '' && digit === '0') return
  
  inputValue.value += digit
}

const addDecimal = () => {
  // Only one decimal point allowed
  if (inputValue.value.includes('.')) return
  
  // Add leading zero if empty
  if (inputValue.value === '') {
    inputValue.value = '0.'
  } else {
    inputValue.value += '.'
  }
}

const clearInput = () => {
  inputValue.value = ''
}

const setQuickAmount = (amount: number) => {
  inputValue.value = amount.toString()
}

const handleContinue = () => {
  if (!isValidSelection.value) return
  
  let finalAmount = 0
  let finalLiters = 0
  let authAmount = 0
  
  if (selectionMode.value === 'fillTank') {
    // Fill tank - authorize maximum
    authAmount = 150
    finalAmount = 0 // Will be determined after fueling
    finalLiters = 0 // Will be determined after fueling
  } else if (selectionMode.value === 'amount') {
    // Fixed euro amount
    finalAmount = parseFloat(inputValue.value)
    finalLiters = finalAmount / props.state.pricePerLiter
    authAmount = finalAmount
  } else {
    // Fixed liters
    finalLiters = parseFloat(inputValue.value)
    finalAmount = finalLiters * props.state.pricePerLiter
    authAmount = finalAmount
  }
  
  // Update state
  emit('update-state', {
    selectionMode: selectionMode.value,
    requestedAmount: finalAmount,
    requestedLiters: finalLiters,
    authorizationAmount: authAmount
  })
  
  // Navigate to payment method
  emit('navigate', 'paymentMethod')
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
  margin-bottom: 1.5rem;
}

.screen-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
}

.screen-subtitle {
  font-size: 0.95rem;
  color: #9ca3af;
}

.selection-tabs {
  display: flex;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
}

.tab-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid #4b5563;
  border-radius: 0.5rem;
  color: #9ca3af;
  font-weight: bold;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s;
}

.tab-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: #6b7280;
}

.tab-btn.active {
  background: rgba(34, 197, 94, 0.2);
  border-color: #22c55e;
  color: #22c55e;
}

.content-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  margin-bottom: 1.5rem;
}

/* Fill Tank Content */
.fill-tank-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  flex: 1;
  animation: fadeIn 0.4s ease-out;
}

.fill-tank-icon {
  color: #22c55e;
  margin-bottom: 1.5rem;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.fill-tank-label {
  font-size: 2rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 1rem;
  letter-spacing: 1px;
}

.fill-tank-description {
  font-size: 1rem;
  color: #d1d5db;
  text-align: center;
  line-height: 1.6;
  max-width: 400px;
  margin-bottom: 1rem;
}

.estimated-amount {
  font-size: 1.25rem;
  color: #9ca3af;
}

/* Input Content */
.input-content {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  animation: fadeIn 0.4s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.input-display {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid #4b5563;
  border-radius: 0.75rem;
  min-height: 100px;
}

.input-value {
  font-size: 3rem;
  font-weight: bold;
  color: #22c55e;
  line-height: 1;
  font-family: monospace;
}

.conversion-text {
  font-size: 1rem;
  color: #9ca3af;
  margin-top: 0.5rem;
}

.quick-select {
  display: flex;
  gap: 0.5rem;
  justify-content: center;
}

.quick-btn {
  padding: 0.75rem 1rem;
  background: rgba(34, 197, 94, 0.1);
  border: 2px solid #22c55e;
  border-radius: 0.5rem;
  color: #22c55e;
  font-weight: bold;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.2s;
}

.quick-btn:hover {
  background: rgba(34, 197, 94, 0.2);
  transform: translateY(-2px);
}

.quick-btn:active {
  transform: translateY(0);
}

.number-pad {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.75rem;
}

.num-btn {
  aspect-ratio: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.08);
  border: 3px solid #4b5563;
  border-radius: 0.5rem;
  color: #fff;
  font-size: 1.5rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 4px 0 #374151;
}

.num-btn:hover {
  background: rgba(255, 255, 255, 0.12);
  border-color: #6b7280;
  transform: translateY(-2px);
  box-shadow: 0 6px 0 #374151;
}

.num-btn:active {
  transform: translateY(2px);
  box-shadow: 0 2px 0 #374151;
}

.num-btn.clear {
  background: rgba(239, 68, 68, 0.2);
  border-color: #ef4444;
  color: #ef4444;
}

.num-btn.clear:hover {
  background: rgba(239, 68, 68, 0.3);
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
  text-align: center;
  line-height: 1.4;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.25rem;
  }
  
  .selection-tabs {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .tab-btn {
    padding: 0.75rem;
  }
  
  .input-value {
    font-size: 2.5rem;
  }
  
  .number-pad {
    gap: 0.5rem;
  }
  
  .num-btn {
    font-size: 1.25rem;
  }
  
  .quick-select {
    flex-wrap: wrap;
  }
}
</style>
