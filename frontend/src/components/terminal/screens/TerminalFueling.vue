<template>
  <div class="terminal-screen-content fueling-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.fueling.title').toUpperCase() }}</h2>
      <p class="screen-subtitle">{{ t('terminal.fueling.subtitle', { pump: state.pumpNumber, fuel: fuelLabel }) }}</p>
    </div>
    
    <!-- Animated Fuel Pump Icon -->
    <div class="fuel-pump-animation">
      <div class="pump-icon-container">
        <Fuel :size="100" :stroke-width="2" class="pump-icon pulsing" />
        <div class="droplet" v-for="i in 5" :key="i" :style="{ animationDelay: `${i * 0.3}s` }">
          <Droplet :size="20" />
        </div>
      </div>
    </div>
    
    <!-- Counters -->
    <div class="counters-container">
      
      <!-- Liters Counter -->
      <div class="counter-box">
        <div class="counter-icon">
          <Droplet :size="32" :stroke-width="2.5" />
        </div>
        <div class="counter-label">{{ t('terminal.fueling.litersDispensed').toUpperCase() }}</div>
        <div class="counter-value">{{ currentLiters.toFixed(2) }} L</div>
      </div>
      
      <!-- Amount Counter -->
      <div class="counter-box">
        <div class="counter-icon">
          <Euro :size="32" :stroke-width="2.5" />
        </div>
        <div class="counter-label">{{ t('terminal.fueling.totalAmount').toUpperCase() }}</div>
        <div class="counter-value">€{{ currentAmount.toFixed(2) }}</div>
      </div>
      
    </div>
    
    <!-- Fuel Gauge -->
    <div class="fuel-gauge-container">
      <div class="gauge-label">{{ t('terminal.fueling.progress').toUpperCase() }}</div>
      <div class="gauge-bar">
        <div class="gauge-fill" :style="{ width: `${progress}%` }">
          <div class="gauge-shimmer"></div>
        </div>
      </div>
      <div class="gauge-percentage">{{ progress }}%</div>
    </div>
    
    <!-- Warning Message -->
    <div class="warning-notice">
      <AlertCircle :size="24" :stroke-width="2.5" />
      <div class="warning-text">
        <div class="warning-title">{{ t('terminal.fueling.doNotRemove').toUpperCase() }}</div>
        <div class="warning-subtitle">{{ t('terminal.fueling.autoComplete') }}</div>
      </div>
    </div>
    
    <!-- Status Messages -->
    <div class="status-messages">
      <div class="status-line">
        <TrendingUp :size="16" />
        <span>{{ t('terminal.fueling.pricePerLiter') }}: €{{ state.pricePerLiter }}/L</span>
      </div>
      <div class="status-line" v-if="state.selectionMode === 'fillTank'">
        <Info :size="16" />
        <span>{{ t('terminal.fueling.fillingTank') }}</span>
      </div>
      <div class="status-line" v-else-if="state.selectionMode === 'amount'">
        <Info :size="16" />
        <span>{{ t('terminal.fueling.target') }}: €{{ state.requestedAmount.toFixed(2) }}</span>
      </div>
      <div class="status-line" v-else>
        <Info :size="16" />
        <span>{{ t('terminal.fueling.target') }}: {{ state.requestedLiters.toFixed(2) }}L</span>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { Fuel, Droplet, Euro, AlertCircle, TrendingUp, Info } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const currentLiters = ref(0)
const currentAmount = ref(0)
const progress = ref(0)

const fuelLabel = computed(() => {
  const fuel = props.state.fuelType
  if (fuel === 'diesel') return 'DIESEL'
  if (fuel === 'super') return 'SUPER 95'
  if (fuel === 'super-plus') return 'SUPER PLUS 98'
  if (fuel === 'e10') return 'SUPER E10'
  return 'FUEL'
})

// Calculate target based on selection mode
const targetLiters = computed(() => {
  if (props.state.selectionMode === 'fillTank') {
    return 50 // Simulated full tank amount
  } else if (props.state.selectionMode === 'amount') {
    return props.state.requestedAmount / props.state.pricePerLiter
  } else {
    return props.state.requestedLiters
  }
})

const targetAmount = computed(() => {
  return targetLiters.value * props.state.pricePerLiter
})

let fuelingInterval: number

onMounted(() => {
  // Simulate fueling process
  const fuelingSpeed = 0.5 // Liters per update (50ms)
  const updateInterval = 50 // ms
  
  fuelingInterval = window.setInterval(() => {
    if (currentLiters.value < targetLiters.value) {
      // Increment liters
      currentLiters.value = Math.min(
        currentLiters.value + fuelingSpeed,
        targetLiters.value
      )
      
      // Calculate amount
      currentAmount.value = currentLiters.value * props.state.pricePerLiter
      
      // Update progress
      progress.value = Math.min(
        Math.round((currentLiters.value / targetLiters.value) * 100),
        100
      )
    } else {
      // Fueling complete
      clearInterval(fuelingInterval)
      
      // Update final values in state
      emit('update-state', {
        finalLiters: currentLiters.value,
        finalAmount: currentAmount.value
      })
      
      // Navigate to completion screen after brief delay
      setTimeout(() => {
        emit('navigate', 'fuelingComplete')
      }, 1000)
    }
  }, updateInterval)
})

// Cleanup on unmount
const cleanup = () => {
  if (fuelingInterval) clearInterval(fuelingInterval)
}

onMounted(() => {
  return cleanup
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
}

.screen-header {
  text-align: center;
  margin-bottom: 2rem;
}

.screen-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #22c55e;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.screen-subtitle {
  font-size: 0.95rem;
  color: #9ca3af;
}

.fuel-pump-animation {
  display: flex;
  justify-content: center;
  margin-bottom: 2rem;
}

.pump-icon-container {
  position: relative;
  width: 120px;
  height: 120px;
}

.pump-icon {
  color: #22c55e;
}

.pump-icon.pulsing {
  animation: pumpPulse 1.5s ease-in-out infinite;
}

@keyframes pumpPulse {
  0%, 100% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.05);
    opacity: 0.9;
  }
}

.droplet {
  position: absolute;
  left: 50%;
  top: 100%;
  transform: translateX(-50%);
  color: #22c55e;
  animation: dropletFall 1.5s ease-in infinite;
  opacity: 0;
}

@keyframes dropletFall {
  0% {
    top: 100%;
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 1;
  }
  100% {
    top: 200%;
    opacity: 0;
  }
}

.counters-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  margin-bottom: 2rem;
}

.counter-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid #22c55e;
  border-radius: 0.75rem;
  animation: counterGlow 2s ease-in-out infinite;
}

@keyframes counterGlow {
  0%, 100% {
    box-shadow: 0 0 10px rgba(34, 197, 94, 0.3);
  }
  50% {
    box-shadow: 0 0 20px rgba(34, 197, 94, 0.6);
  }
}

.counter-icon {
  color: #22c55e;
  margin-bottom: 0.5rem;
}

.counter-label {
  font-size: 0.75rem;
  color: #9ca3af;
  margin-bottom: 0.5rem;
  letter-spacing: 0.5px;
  font-weight: bold;
}

.counter-value {
  font-size: 2rem;
  font-weight: bold;
  color: #22c55e;
  font-family: monospace;
  line-height: 1;
}

.fuel-gauge-container {
  margin-bottom: 2rem;
}

.gauge-label {
  font-size: 0.85rem;
  color: #9ca3af;
  margin-bottom: 0.5rem;
  text-align: center;
  font-weight: bold;
  letter-spacing: 0.5px;
}

.gauge-bar {
  height: 32px;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid #4b5563;
  border-radius: 1rem;
  overflow: hidden;
  position: relative;
}

.gauge-fill {
  height: 100%;
  background: linear-gradient(90deg, #22c55e 0%, #16a34a 100%);
  border-radius: 0.75rem;
  transition: width 0.3s ease;
  position: relative;
  overflow: hidden;
}

.gauge-shimmer {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent 0%,
    rgba(255, 255, 255, 0.3) 50%,
    transparent 100%
  );
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% {
    left: -100%;
  }
  100% {
    left: 200%;
  }
}

.gauge-percentage {
  font-size: 1.25rem;
  font-weight: bold;
  color: #22c55e;
  text-align: center;
  margin-top: 0.5rem;
  font-family: monospace;
}

.warning-notice {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(239, 68, 68, 0.1);
  border: 3px solid #ef4444;
  border-radius: 0.75rem;
  margin-bottom: 1rem;
  animation: warningBlink 2s ease-in-out infinite;
}

@keyframes warningBlink {
  0%, 100% {
    border-color: #ef4444;
    background: rgba(239, 68, 68, 0.1);
  }
  50% {
    border-color: #fbbf24;
    background: rgba(251, 191, 36, 0.1);
  }
}

.warning-notice svg {
  color: #ef4444;
  flex-shrink: 0;
}

.warning-text {
  flex: 1;
}

.warning-title {
  font-size: 1rem;
  font-weight: bold;
  color: #ef4444;
  margin-bottom: 0.25rem;
  letter-spacing: 0.5px;
}

.warning-subtitle {
  font-size: 0.85rem;
  color: #fca5a5;
}

.status-messages {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.status-line {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.85rem;
  color: #9ca3af;
}

.status-line svg {
  color: #22c55e;
  flex-shrink: 0;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.25rem;
  }
  
  .pump-icon-container {
    width: 80px;
    height: 80px;
  }
  
  .pump-icon {
    width: 80px;
    height: 80px;
  }
  
  .counters-container {
    grid-template-columns: 1fr;
    gap: 0.75rem;
  }
  
  .counter-box {
    padding: 1rem;
  }
  
  .counter-value {
    font-size: 1.75rem;
  }
  
  .gauge-bar {
    height: 24px;
  }
}
</style>
