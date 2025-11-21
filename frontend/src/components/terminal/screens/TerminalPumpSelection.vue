<template>
  <div class="terminal-screen-content pump-selection-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.pumpSelection.title') }}</h2>
      <p class="screen-subtitle">{{ t('terminal.pumpSelection.subtitle') }}</p>
    </div>
    
    <!-- Pump Grid -->
    <div class="pump-grid">
      <div
        v-for="pump in pumps"
        :key="pump.number"
        class="pump-button"
        :class="[
          pump.status,
          { selected: selectedPump === pump.number }
        ]"
        @click="selectPump(pump.number, pump.status)"
      >
        <div class="pump-icon">
          <Fuel v-if="pump.status === 'available'" :size="32" :stroke-width="2.5" />
          <Loader2 v-else-if="pump.status === 'in-use'" :size="32" :stroke-width="2.5" class="spinning" />
          <XCircle v-else :size="32" :stroke-width="2.5" />
        </div>
        <div class="pump-number">{{ pump.number }}</div>
        <div class="pump-status-label">
          <span v-if="pump.status === 'available'">{{ t('terminal.pumpSelection.available') }}</span>
          <span v-else-if="pump.status === 'in-use'">{{ t('terminal.pumpSelection.inUse') }}</span>
          <span v-else>{{ t('terminal.pumpSelection.outOfOrder') }}</span>
        </div>
      </div>
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        :disabled="!selectedPump"
        @click="handleContinue"
      >
        <span v-if="selectedPump">
          {{ t('terminal.pumpSelection.continue') }} <ArrowRight :size="20" />
        </span>
        <span v-else>{{ t('terminal.pumpSelection.selectPump') }}</span>
      </button>
    </div>
    
    <!-- Help Notice -->
    <div class="help-notice">
      <Info :size="20" />
      <span>{{ t('terminal.pumpSelection.helpText') }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { Fuel, Loader2, XCircle, ArrowRight, Info } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

interface Pump {
  number: number
  status: 'available' | 'in-use' | 'out-of-order'
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const selectedPump = ref<number | null>(null)

// Generate 12 pumps with simulated statuses
const pumps = ref<Pump[]>([
  { number: 1, status: 'available' },
  { number: 2, status: 'available' },
  { number: 3, status: 'in-use' },
  { number: 4, status: 'available' },
  { number: 5, status: 'available' },
  { number: 6, status: 'available' },
  { number: 7, status: 'in-use' },
  { number: 8, status: 'available' },
  { number: 9, status: 'out-of-order' },
  { number: 10, status: 'available' },
  { number: 11, status: 'available' },
  { number: 12, status: 'available' }
])

const selectPump = (pumpNumber: number, status: string) => {
  // Only allow selection of available pumps
  if (status !== 'available') {
    return
  }
  
  selectedPump.value = pumpNumber
  
  // Update state
  emit('update-state', { pumpNumber })
}

const handleContinue = () => {
  if (!selectedPump.value) return
  
  // Navigate to fuel type selection
  emit('navigate', 'fuelType')
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

.pump-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
  flex: 1;
  margin-bottom: 1.5rem;
  align-content: start;
}

.pump-button {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 3px solid #4b5563;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.3s;
  min-height: 140px;
}

.pump-button.available {
  border-color: #22c55e;
}

.pump-button.available:hover {
  background: rgba(34, 197, 94, 0.1);
  border-color: #22c55e;
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(34, 197, 94, 0.3);
}

.pump-button.available.selected {
  background: rgba(34, 197, 94, 0.2);
  border-color: #22c55e;
  border-width: 4px;
  box-shadow: 0 0 20px rgba(34, 197, 94, 0.4);
}

.pump-button.available.selected::after {
  content: '✓';
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  width: 28px;
  height: 28px;
  background: #22c55e;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  font-weight: bold;
}

.pump-button.in-use {
  border-color: #fbbf24;
  cursor: not-allowed;
  opacity: 0.7;
}

.pump-button.out-of-order {
  border-color: #ef4444;
  cursor: not-allowed;
  opacity: 0.5;
}

.pump-icon {
  margin-bottom: 0.75rem;
}

.pump-button.available .pump-icon {
  color: #22c55e;
}

.pump-button.in-use .pump-icon {
  color: #fbbf24;
}

.pump-button.out-of-order .pump-icon {
  color: #ef4444;
}

.spinning {
  animation: spin 2s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.pump-number {
  font-size: 2rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
  line-height: 1;
}

.pump-status-label {
  font-size: 0.7rem;
  font-weight: bold;
  letter-spacing: 0.5px;
}

.pump-button.available .pump-status-label {
  color: #22c55e;
}

.pump-button.in-use .pump-status-label {
  color: #fbbf24;
}

.pump-button.out-of-order .pump-status-label {
  color: #ef4444;
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
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.pump-button {
  animation: fadeIn 0.3s ease-out both;
}

.pump-button:nth-child(1) { animation-delay: 0.05s; }
.pump-button:nth-child(2) { animation-delay: 0.1s; }
.pump-button:nth-child(3) { animation-delay: 0.15s; }
.pump-button:nth-child(4) { animation-delay: 0.2s; }
.pump-button:nth-child(5) { animation-delay: 0.25s; }
.pump-button:nth-child(6) { animation-delay: 0.3s; }
.pump-button:nth-child(7) { animation-delay: 0.35s; }
.pump-button:nth-child(8) { animation-delay: 0.4s; }
.pump-button:nth-child(9) { animation-delay: 0.45s; }
.pump-button:nth-child(10) { animation-delay: 0.5s; }
.pump-button:nth-child(11) { animation-delay: 0.55s; }
.pump-button:nth-child(12) { animation-delay: 0.6s; }

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.25rem;
  }
  
  .pump-grid {
    grid-template-columns: repeat(3, 1fr);
    gap: 0.75rem;
  }
  
  .pump-button {
    padding: 1rem 0.75rem;
    min-height: 120px;
  }
  
  .pump-icon svg {
    width: 24px;
    height: 24px;
  }
  
  .pump-number {
    font-size: 1.75rem;
  }
  
  .pump-status-label {
    font-size: 0.65rem;
  }
}
</style>
