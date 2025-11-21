<template>
  <div class="pos-terminal-container">
    <!-- Terminal Hardware Frame -->
    <div class="terminal-hardware">
      
      <!-- Terminal Screen -->
      <div class="terminal-screen">
        <!-- Language Switcher -->
        <TerminalLanguageSwitcher />
        
        <!-- Screen Bezel -->
        <div class="screen-bezel">
          
          <!-- Active Screen Content with Transitions -->
          <transition :name="transitionName" mode="out-in">
            <component 
              :is="currentScreenComponent" 
              :key="currentScreen"
              :state="terminalState"
              @navigate="handleNavigation"
              @update-state="updateState"
              @complete="handleComplete"
            />
          </transition>
          
        </div>
      </div>
      
      <!-- Terminal Physical Buttons Panel -->
      <div class="terminal-buttons-panel">
        <div class="button-row">
          <button 
            v-if="currentScreen !== 'welcome' && currentScreen !== 'success'"
            @click="goBack" 
            class="terminal-btn terminal-btn-cancel"
            :disabled="isProcessing"
          >
            ✕ Cancel
          </button>
          <button 
            v-if="canGoBack"
            @click="goBack" 
            class="terminal-btn terminal-btn-back"
            :disabled="isProcessing"
          >
            ← Back
          </button>
        </div>
      </div>
      
      <!-- Hardware Details -->
      <div class="terminal-hardware-details">
        <div class="card-reader-slot">
          <div class="slot-line"></div>
          <span class="slot-label">INSERT CARD</span>
        </div>
        <div class="receipt-printer-slot">
          <div class="printer-opening"></div>
          <span class="slot-label">RECEIPT</span>
        </div>
        <div class="status-lights">
          <div class="status-light" :class="{ active: isProcessing }"></div>
          <div class="status-light green" :class="{ active: currentScreen === 'success' }"></div>
        </div>
      </div>
      
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, defineProps, defineEmits, markRaw } from 'vue'
import TerminalWelcome from './screens/TerminalWelcome.vue'
import TerminalPaymentMethod from './screens/TerminalPaymentMethod.vue'
import TerminalProductSelect from './screens/TerminalProductSelect.vue'
import TerminalQuantity from './screens/TerminalQuantity.vue'
import TerminalReview from './screens/TerminalReview.vue'
import TerminalProcessing from './screens/TerminalProcessing.vue'
import TerminalSuccess from './screens/TerminalSuccess.vue'
import TerminalError from './screens/TerminalError.vue'
// Gas Station Screens
import TerminalPumpSelection from './screens/TerminalPumpSelection.vue'
import TerminalFuelType from './screens/TerminalFuelType.vue'
import TerminalAmountSelection from './screens/TerminalAmountSelection.vue'
import TerminalFueling from './screens/TerminalFueling.vue'
import TerminalFuelingComplete from './screens/TerminalFuelingComplete.vue'
import TerminalLanguageSwitcher from './TerminalLanguageSwitcher.vue'

// Props
interface Props {
  product?: any
  bundleProducts?: any[]
}

const props = defineProps<Props>()
const emit = defineEmits(['add-to-cart', 'complete'])

// Terminal State Interface
interface TerminalState {
  currentScreen: ScreenType
  paymentMethod: 'card' | 'cash' | 'mobile' | null
  selectedProducts: Array<{
    id: string
    name: string
    price: number
    quantity: number
  }>
  totalAmount: number
  taxRate: number
  orderNumber: string | null
  error: string | null
  // Gas Station Fields
  pumpNumber?: number
  fuelType?: string
  pricePerLiter?: number
  selectionMode?: 'fillTank' | 'amount' | 'liters'
  requestedAmount?: number
  requestedLiters?: number
  authorizationAmount?: number
  finalLiters?: number
  finalAmount?: number
}

// Screen Types
type ScreenType = 'welcome' | 'paymentMethod' | 'productSelect' | 'quantity' | 'review' | 'processing' | 'success' | 'error' | 'pumpSelection' | 'fuelType' | 'amountSelection' | 'fueling' | 'fuelingComplete'

// Terminal State
const terminalState = ref<TerminalState>({
  currentScreen: 'welcome',
  paymentMethod: null,
  selectedProducts: [],
  totalAmount: 0,
  taxRate: 19, // 19% VAT
  orderNumber: null,
  error: null
})

// Navigation
const currentScreen = ref<ScreenType>('welcome')
const navigationHistory = ref<ScreenType[]>(['welcome'])
const transitionName = ref('slide-left')
const isProcessing = ref(false)

// Screen Components Map
const screenComponents = {
  welcome: markRaw(TerminalWelcome),
  paymentMethod: markRaw(TerminalPaymentMethod),
  productSelect: markRaw(TerminalProductSelect),
  quantity: markRaw(TerminalQuantity),
  review: markRaw(TerminalReview),
  processing: markRaw(TerminalProcessing),
  success: markRaw(TerminalSuccess),
  error: markRaw(TerminalError),
  // Gas Station Screens
  pumpSelection: markRaw(TerminalPumpSelection),
  fuelType: markRaw(TerminalFuelType),
  amountSelection: markRaw(TerminalAmountSelection),
  fueling: markRaw(TerminalFueling),
  fuelingComplete: markRaw(TerminalFuelingComplete)
}

const currentScreenComponent = computed(() => screenComponents[currentScreen.value])

const canGoBack = computed(() => {
  return navigationHistory.value.length > 1 && 
         currentScreen.value !== 'processing' && 
         currentScreen.value !== 'success' &&
         currentScreen.value !== 'fueling' &&
         currentScreen.value !== 'fuelingComplete'
})

// Navigation Handlers
const handleNavigation = (screen: ScreenType) => {
  transitionName.value = 'slide-left'
  navigationHistory.value.push(screen)
  currentScreen.value = screen
  terminalState.value.currentScreen = screen
}

const goBack = () => {
  if (!canGoBack.value) return
  
  transitionName.value = 'slide-right'
  navigationHistory.value.pop()
  const previousScreen = navigationHistory.value[navigationHistory.value.length - 1]
  currentScreen.value = previousScreen
  terminalState.value.currentScreen = previousScreen
}

const updateState = (updates: Partial<TerminalState>) => {
  terminalState.value = { ...terminalState.value, ...updates }
}

const handleComplete = (orderData: any) => {
  emit('complete', orderData)
  emit('add-to-cart', orderData)
}

// Reset terminal
const reset = () => {
  terminalState.value = {
    currentScreen: 'welcome',
    paymentMethod: null,
    selectedProducts: [],
    totalAmount: 0,
    taxRate: 19,
    orderNumber: null,
    error: null
  }
  currentScreen.value = 'welcome'
  navigationHistory.value = ['welcome']
}

// Expose methods for parent component
defineExpose({
  reset
})
</script>

<style scoped>
/* Gas Station Terminal - Industrial Design */
.pos-terminal-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 2rem;
  background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
  border-radius: 0.5rem;
  min-height: 600px;
}

.terminal-hardware {
  width: 100%;
  max-width: 500px;
  background: linear-gradient(145deg, #d4d4d8, #a1a1aa);
  border-radius: 0.5rem;
  padding: 2rem;
  border: 4px solid #71717a;
  box-shadow: 
    0 10px 30px rgba(0, 0, 0, 0.6),
    inset 0 2px 4px rgba(255, 255, 255, 0.3),
    inset 0 -2px 4px rgba(0, 0, 0, 0.2);
}

.terminal-screen {
  background: #18181b;
  border-radius: 0.5rem;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  border: 4px solid #3f3f46;
  box-shadow: 
    inset 0 4px 12px rgba(0, 0, 0, 0.9),
    0 0 0 2px #52525b;
}

.screen-bezel {
  background: #1f2937;
  border: 4px solid #374151;
  border-radius: 0.25rem;
  min-height: 500px;
  overflow: hidden;
  position: relative;
  box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.8);
}

.terminal-buttons-panel {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.button-row {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

/* Gas Station Buttons - Chunky 3D Style */
.terminal-btn {
  flex: 1;
  padding: 1.25rem 1.5rem;
  font-size: 1.125rem;
  font-weight: bold;
  border: 4px solid;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.2s;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  min-height: 80px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.terminal-btn:active:not(:disabled) {
  transform: translateY(4px);
}

.terminal-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  filter: grayscale(50%);
}

.terminal-btn-cancel {
  background: #ef4444;
  border-color: #dc2626;
  color: #000;
  box-shadow: 
    0 6px 0 #b91c1c,
    0 8px 12px rgba(0, 0, 0, 0.4);
}

.terminal-btn-cancel:hover:not(:disabled) {
  background: #dc2626;
  transform: translateY(-2px);
  box-shadow: 
    0 8px 0 #991b1b,
    0 10px 16px rgba(0, 0, 0, 0.5);
}

.terminal-btn-cancel:active:not(:disabled) {
  box-shadow: 
    0 2px 0 #b91c1c,
    0 4px 8px rgba(0, 0, 0, 0.4);
}

.terminal-btn-back {
  background: #fbbf24;
  border-color: #f59e0b;
  color: #000;
  box-shadow: 
    0 6px 0 #d97706,
    0 8px 12px rgba(0, 0, 0, 0.4);
}

.terminal-btn-back:hover:not(:disabled) {
  background: #f59e0b;
  transform: translateY(-2px);
  box-shadow: 
    0 8px 0 #b45309,
    0 10px 16px rgba(0, 0, 0, 0.5);
}

.terminal-btn-back:active:not(:disabled) {
  box-shadow: 
    0 2px 0 #d97706,
    0 4px 8px rgba(0, 0, 0, 0.4);
}

/* Gas Station Hardware Details */
.terminal-hardware-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 1rem;
  background: linear-gradient(145deg, #52525b, #3f3f46);
  border-radius: 0.25rem;
  border: 2px solid #71717a;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.4);
}

.card-reader-slot {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
}

.slot-line {
  width: 80px;
  height: 12px;
  background: linear-gradient(180deg, #18181b 0%, #09090b 100%);
  border-radius: 2px;
  border: 2px solid #27272a;
  box-shadow: 
    inset 0 3px 6px rgba(0, 0, 0, 0.8),
    0 1px 2px rgba(255, 255, 255, 0.1);
}

.receipt-printer-slot {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
}

.printer-opening {
  width: 70px;
  height: 10px;
  background: linear-gradient(180deg, #09090b 0%, #000 100%);
  border-radius: 2px;
  border: 2px solid #27272a;
  box-shadow: 
    inset 0 3px 6px rgba(0, 0, 0, 0.9),
    0 1px 2px rgba(255, 255, 255, 0.1);
}

.slot-label {
  font-size: 0.7rem;
  color: #d4d4d8;
  font-weight: bold;
  letter-spacing: 1px;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.8);
}

.status-lights {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.status-light {
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: #27272a;
  border: 3px solid #3f3f46;
  transition: all 0.3s;
  box-shadow: 
    inset 0 2px 4px rgba(0, 0, 0, 0.6),
    0 0 0 2px #18181b;
}

.status-light.active {
  background: #fbbf24;
  border-color: #f59e0b;
  box-shadow: 
    0 0 16px #fbbf24,
    0 0 8px #f59e0b,
    inset 0 0 8px rgba(255, 255, 255, 0.5);
  animation: status-pulse 1.5s ease-in-out infinite;
}

.status-light.green.active {
  background: #22c55e;
  border-color: #16a34a;
  box-shadow: 
    0 0 16px #22c55e,
    0 0 8px #16a34a,
    inset 0 0 8px rgba(255, 255, 255, 0.5);
  animation: status-pulse 1.5s ease-in-out infinite;
}

@keyframes status-pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
}

/* Screen Transitions */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.3s ease;
}

.slide-left-enter-from {
  transform: translateX(100%);
  opacity: 0;
}

.slide-left-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}

.slide-right-enter-from {
  transform: translateX(-100%);
  opacity: 0;
}

.slide-right-leave-to {
  transform: translateX(100%);
  opacity: 0;
}

/* Responsive Design */
@media (max-width: 768px) {
  .pos-terminal-container {
    padding: 1rem;
  }
  
  .terminal-hardware {
    max-width: 100%;
    padding: 1rem;
  }
  
  .screen-bezel {
    min-height: 400px;
  }
  
  .terminal-btn {
    padding: 0.75rem 1rem;
    font-size: 0.9rem;
  }
}
</style>
