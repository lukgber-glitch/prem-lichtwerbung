<template>
  <div class="terminal-screen-content welcome-screen" @click="handleStart">
    
    <!-- Welcome Content -->
    <div class="welcome-content">
      
      <!-- Terminal Icon/Logo -->
      <div class="terminal-icon">
        <div class="icon-wrapper">
          <Fuel :size="80" :stroke-width="2" />
        </div>
      </div>
      
      <!-- Welcome Message -->
      <h1 class="welcome-title">
        {{ t('terminal.welcome.title') }}
      </h1>
      <h2 class="brand-name">
        {{ t('terminal.welcome.brand') }}
      </h2>
      
      <!-- Subtitle -->
      <p class="welcome-subtitle">
        {{ t('terminal.welcome.subtitle') }}
      </p>
      
      <!-- Current Fuel Prices -->
      <div class="fuel-prices">
        <div class="price-item">
          <span class="fuel-name">Diesel</span>
          <span class="fuel-price">€1.699</span>
        </div>
        <div class="price-item">
          <span class="fuel-name">Super</span>
          <span class="fuel-price">€1.849</span>
        </div>
        <div class="price-item">
          <span class="fuel-name">Super Plus</span>
          <span class="fuel-price">€1.989</span>
        </div>
        <div class="price-item">
          <span class="fuel-name">E10</span>
          <span class="fuel-price">€1.799</span>
        </div>
      </div>
      
      <!-- Touch to Start Prompt -->
      <div class="touch-prompt">
        <div class="touch-icon">
          <Hand :size="48" :stroke-width="2" />
        </div>
        <p class="touch-text animate-pulse">
          {{ t('terminal.welcome.touchToStart') }}
        </p>
      </div>
      
      <!-- Feature Highlights -->
      <div class="feature-highlights">
        <div class="feature-item">
          <Zap :size="24" :stroke-width="2.5" />
          <span class="feature-text">{{ t('terminal.welcome.fastAndSecure') }}</span>
        </div>
        <div class="feature-item">
          <CreditCard :size="24" :stroke-width="2.5" />
          <span class="feature-text">{{ t('terminal.welcome.multiplePayment') }}</span>
        </div>
        <div class="feature-item">
          <Smartphone :size="24" :stroke-width="2.5" />
          <span class="feature-text">{{ t('terminal.welcome.selfService') }}</span>
        </div>
      </div>
      
    </div>
    
    <!-- Footer Info -->
    <div class="welcome-footer">
      <p class="footer-text">{{ t('terminal.welcome.footer') }}</p>
      <p class="footer-version">{{ t('terminal.welcome.version') }}</p>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { Fuel, Hand, Zap, CreditCard, Smartphone } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const handleStart = () => {
  // Navigate to pump selection for gas station flow
  emit('navigate', 'pumpSelection')
}
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
  color: #fff;
  cursor: pointer;
  user-select: none;
}

.welcome-screen {
  position: relative;
  overflow: hidden;
}

/* Animated background effect */
.welcome-screen::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
  animation: rotate 20s linear infinite;
}

@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.welcome-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 2rem;
  position: relative;
  z-index: 1;
}

.terminal-icon {
  margin-bottom: 2rem;
}

.icon-wrapper {
  font-size: 5rem;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

.welcome-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #94a3b8;
  text-transform: uppercase;
  letter-spacing: 2px;
}

.brand-name {
  font-size: 2.5rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
  color: #3b82f6;
  text-shadow: 0 0 20px rgba(59, 130, 246, 0.5);
}

.welcome-subtitle {
  font-size: 1rem;
  color: #64748b;
  margin-bottom: 2rem;
}

.fuel-prices {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.75rem;
  width: 100%;
  max-width: 350px;
  margin-bottom: 2rem;
}

.price-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  background: rgba(34, 197, 94, 0.1);
  border: 1px solid rgba(34, 197, 94, 0.3);
  border-radius: 0.5rem;
}

.fuel-name {
  font-size: 0.9rem;
  color: #94a3b8;
  font-weight: 600;
}

.fuel-price {
  font-size: 1rem;
  color: #22c55e;
  font-weight: bold;
  font-family: monospace;
}

.touch-prompt {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.touch-icon {
  font-size: 3rem;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
  60% {
    transform: translateY(-5px);
  }
}

.touch-text {
  font-size: 1.25rem;
  font-weight: 600;
  color: #3b82f6;
}

.animate-pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.feature-highlights {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  width: 100%;
  max-width: 300px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 0.5rem;
  border: 1px solid rgba(59, 130, 246, 0.2);
  transition: all 0.3s;
}

.feature-item:hover {
  background: rgba(59, 130, 246, 0.1);
  border-color: rgba(59, 130, 246, 0.4);
  transform: translateX(5px);
}

.feature-icon {
  font-size: 1.5rem;
}

.feature-text {
  font-size: 0.9rem;
  color: #cbd5e1;
}

.welcome-footer {
  padding: 1.5rem;
  text-align: center;
  background: rgba(0, 0, 0, 0.3);
  border-top: 1px solid rgba(59, 130, 246, 0.2);
  position: relative;
  z-index: 1;
}

.footer-text {
  font-size: 0.85rem;
  color: #64748b;
  margin-bottom: 0.25rem;
}

.footer-version {
  font-size: 0.75rem;
  color: #475569;
}

/* Hover effect for entire screen */
.welcome-screen:hover .brand-name {
  color: #60a5fa;
  text-shadow: 0 0 30px rgba(59, 130, 246, 0.7);
}

.welcome-screen:active {
  transform: scale(0.99);
}

/* Responsive */
@media (max-width: 768px) {
  .welcome-content {
    padding: 1rem;
  }
  
  .icon-wrapper {
    font-size: 4rem;
  }
  
  .brand-name {
    font-size: 2rem;
  }
  
  .welcome-title {
    font-size: 1.25rem;
  }
  
  .feature-highlights {
    max-width: 100%;
  }
}
</style>
