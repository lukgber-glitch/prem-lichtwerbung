<template>
  <div class="terminal-screen-content fuel-type-screen">
    
    <!-- Screen Header -->
    <div class="screen-header">
      <h2 class="screen-title">{{ t('terminal.fuelType.title') }}</h2>
      <p class="screen-subtitle">{{ t('terminal.fuelType.subtitle', { pump: state.pumpNumber || '?' }) }}</p>
    </div>
    
    <!-- Fuel Type Cards -->
    <div class="fuel-types">
      
      <!-- Diesel -->
      <div 
        class="fuel-card diesel"
        :class="{ selected: selectedFuel === 'diesel' }"
        @click="selectFuel('diesel', 1.699)"
      >
        <div class="fuel-icon">
          <Droplet :size="48" :stroke-width="2.5" />
        </div>
        <div class="fuel-name">{{ t('terminal.fuelType.diesel').toUpperCase() }}</div>
        <div class="fuel-specs">B7 • Max 7% Biodiesel</div>
        <div class="fuel-price">
          <span class="price-amount">1.699</span>
          <span class="price-unit">€/L</span>
        </div>
      </div>
      
      <!-- Super 95 -->
      <div 
        class="fuel-card super"
        :class="{ selected: selectedFuel === 'super' }"
        @click="selectFuel('super', 1.849)"
      >
        <div class="fuel-icon">
          <Droplet :size="48" :stroke-width="2.5" />
        </div>
        <div class="fuel-name">{{ t('terminal.fuelType.super').toUpperCase() }}</div>
        <div class="fuel-specs">95 RON • E5</div>
        <div class="fuel-price">
          <span class="price-amount">1.849</span>
          <span class="price-unit">€/L</span>
        </div>
      </div>
      
      <!-- Super Plus 98 -->
      <div 
        class="fuel-card super-plus"
        :class="{ selected: selectedFuel === 'super-plus' }"
        @click="selectFuel('super-plus', 1.989)"
      >
        <div class="fuel-icon">
          <Zap :size="48" :stroke-width="2.5" />
        </div>
        <div class="fuel-name">{{ t('terminal.fuelType.superPlus').toUpperCase() }}</div>
        <div class="fuel-specs">98 RON • Premium</div>
        <div class="fuel-price">
          <span class="price-amount">1.989</span>
          <span class="price-unit">€/L</span>
        </div>
        <div class="fuel-badge">{{ t('terminal.fuelType.premium').toUpperCase() }}</div>
      </div>
      
      <!-- E10 -->
      <div 
        class="fuel-card e10"
        :class="{ selected: selectedFuel === 'e10' }"
        @click="selectFuel('e10', 1.799)"
      >
        <div class="fuel-icon">
          <Leaf :size="48" :stroke-width="2.5" />
        </div>
        <div class="fuel-name">{{ t('terminal.fuelType.e10').toUpperCase() }}</div>
        <div class="fuel-specs">95 RON • Max 10% Ethanol</div>
        <div class="fuel-price">
          <span class="price-amount">1.799</span>
          <span class="price-unit">€/L</span>
        </div>
        <div class="fuel-badge eco">{{ t('terminal.fuelType.eco').toUpperCase() }}</div>
      </div>
      
    </div>
    
    <!-- Continue Button -->
    <div class="action-area">
      <button 
        class="continue-btn"
        :disabled="!selectedFuel"
        @click="handleContinue"
      >
        <span v-if="selectedFuel">
          {{ t('terminal.fuelType.continue') }} <ArrowRight :size="20" />
        </span>
        <span v-else>{{ t('terminal.fuelType.selectFuel') }}</span>
      </button>
    </div>
    
    <!-- Help Notice -->
    <div class="help-notice">
      <Info :size="20" />
      <span>{{ t('terminal.fuelType.helpText') }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { Droplet, Zap, Leaf, ArrowRight, Info } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const selectedFuel = ref<string | null>(null)
const selectedPrice = ref<number>(0)

const selectFuel = (fuelType: string, pricePerLiter: number) => {
  selectedFuel.value = fuelType
  selectedPrice.value = pricePerLiter
  
  // Update state
  emit('update-state', { 
    fuelType,
    pricePerLiter
  })
}

const handleContinue = () => {
  if (!selectedFuel.value) return
  
  // Navigate to amount selection
  emit('navigate', 'amountSelection')
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

.fuel-types {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  flex: 1;
  margin-bottom: 1.5rem;
  align-content: start;
}

.fuel-card {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  border: 4px solid;
  border-radius: 0.75rem;
  cursor: pointer;
  transition: all 0.3s;
  min-height: 220px;
}

/* Diesel - Black */
.fuel-card.diesel {
  background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
  border-color: #374151;
}

.fuel-card.diesel:hover {
  border-color: #4b5563;
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
}

.fuel-card.diesel.selected {
  border-color: #6b7280;
  box-shadow: 0 0 30px rgba(107, 114, 128, 0.5);
}

.fuel-card.diesel .fuel-icon {
  color: #9ca3af;
}

/* Super - Green */
.fuel-card.super {
  background: linear-gradient(135deg, #065f46 0%, #064e3b 100%);
  border-color: #059669;
}

.fuel-card.super:hover {
  border-color: #10b981;
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
}

.fuel-card.super.selected {
  border-color: #10b981;
  box-shadow: 0 0 30px rgba(16, 185, 129, 0.6);
}

.fuel-card.super .fuel-icon {
  color: #10b981;
}

/* Super Plus - Yellow */
.fuel-card.super-plus {
  background: linear-gradient(135deg, #854d0e 0%, #713f12 100%);
  border-color: #f59e0b;
}

.fuel-card.super-plus:hover {
  border-color: #fbbf24;
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(251, 191, 36, 0.4);
}

.fuel-card.super-plus.selected {
  border-color: #fbbf24;
  box-shadow: 0 0 30px rgba(251, 191, 36, 0.6);
}

.fuel-card.super-plus .fuel-icon {
  color: #fbbf24;
}

/* E10 - Light Green */
.fuel-card.e10 {
  background: linear-gradient(135deg, #15803d 0%, #166534 100%);
  border-color: #22c55e;
}

.fuel-card.e10:hover {
  border-color: #4ade80;
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(34, 197, 94, 0.4);
}

.fuel-card.e10.selected {
  border-color: #4ade80;
  box-shadow: 0 0 30px rgba(34, 197, 94, 0.6);
}

.fuel-card.e10 .fuel-icon {
  color: #4ade80;
}

.fuel-card.selected::after {
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
  box-shadow: 0 4px 12px rgba(34, 197, 94, 0.5);
}

.fuel-icon {
  margin-bottom: 1rem;
}

.fuel-name {
  font-size: 1.75rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
  text-align: center;
}

.fuel-specs {
  font-size: 0.85rem;
  color: #d1d5db;
  margin-bottom: 1rem;
  text-align: center;
}

.fuel-price {
  display: flex;
  align-items: baseline;
  gap: 0.25rem;
}

.price-amount {
  font-size: 2.5rem;
  font-weight: bold;
  color: #fff;
  line-height: 1;
}

.price-unit {
  font-size: 1rem;
  color: #9ca3af;
}

.fuel-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  padding: 0.4rem 0.8rem;
  background: #fbbf24;
  color: #000;
  font-size: 0.7rem;
  font-weight: bold;
  border-radius: 0.25rem;
  letter-spacing: 0.5px;
}

.fuel-badge.eco {
  background: #22c55e;
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

.fuel-card:nth-child(1) {
  animation: slideInUp 0.4s ease-out;
}

.fuel-card:nth-child(2) {
  animation: slideInUp 0.4s ease-out 0.1s both;
}

.fuel-card:nth-child(3) {
  animation: slideInUp 0.4s ease-out 0.2s both;
}

.fuel-card:nth-child(4) {
  animation: slideInUp 0.4s ease-out 0.3s both;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .screen-title {
    font-size: 1.25rem;
  }
  
  .fuel-types {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .fuel-card {
    padding: 1.5rem;
    min-height: 180px;
  }
  
  .fuel-icon svg {
    width: 40px;
    height: 40px;
  }
  
  .fuel-name {
    font-size: 1.5rem;
  }
  
  .price-amount {
    font-size: 2rem;
  }
}
</style>
