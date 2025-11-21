<template>
  <div class="terminal-screen-content processing-screen">
    
    <!-- Processing Animation -->
    <div class="processing-animation">
      
      <!-- Animated Card Icon -->
      <div class="card-icon-container">
        <div class="card-icon">
          <CreditCard :size="80" :stroke-width="2" />
        </div>
        <div class="card-glow"></div>
      </div>
      
      <!-- Progress Spinner -->
      <div class="spinner-container">
        <Loader2 :size="60" :stroke-width="3" class="spinner-icon" />
      </div>
      
    </div>
    
    <!-- Processing Content -->
    <div class="processing-content">
      <h2 class="processing-title">{{ currentMessage }}</h2>
      <p class="processing-subtitle">{{ currentSubMessage }}</p>
      
      <!-- Progress Bar -->
      <div class="progress-bar-container">
        <div class="progress-bar" :style="{ width: `${progress}%` }"></div>
      </div>
      <div class="progress-text">{{ progress }}%</div>
    </div>
    
    <!-- Status Messages -->
    <div class="status-messages">
      <div 
        v-for="(message, index) in statusMessages" 
        :key="index"
        class="status-message"
        :class="{ completed: message.completed }"
      >
        <span class="status-icon">
          <Check v-if="message.completed" :size="20" :stroke-width="3" />
          <Clock v-else :size="20" :stroke-width="2" />
        </span>
        <span class="status-text">{{ message.text }}</span>
      </div>
    </div>
    
    <!-- Security Notice -->
    <div class="security-notice">
      <span class="security-icon">
        <Lock :size="20" :stroke-width="2" />
      </span>
      <span class="security-text">{{ t('terminal.processing.secureTransaction') }}</span>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { CreditCard, Loader2, Clock, Check, Lock } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

interface StatusMessage {
  text: string
  completed: boolean
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

const progress = ref(0)
const currentMessage = ref(t('terminal.processing.title'))
const currentSubMessage = ref(t('terminal.processing.subtitle'))

const statusMessages = ref<StatusMessage[]>([
  { text: t('terminal.processing.verifyingPayment'), completed: false },
  { text: t('terminal.processing.contactingGateway'), completed: false },
  { text: t('terminal.processing.authorizingPump'), completed: false },
  { text: t('terminal.processing.activatingFuel'), completed: false }
])

let progressInterval: number
let statusInterval: number

onMounted(() => {
  // Simulate progress
  progressInterval = window.setInterval(() => {
    if (progress.value < 100) {
      progress.value += 2
      
      // Update status messages based on progress
      if (progress.value >= 25 && !statusMessages.value[0].completed) {
        statusMessages.value[0].completed = true
      }
      if (progress.value >= 50 && !statusMessages.value[1].completed) {
        statusMessages.value[1].completed = true
        currentMessage.value = t('terminal.processing.authorizingPump')
      }
      if (progress.value >= 75 && !statusMessages.value[2].completed) {
        statusMessages.value[2].completed = true
        currentMessage.value = t('terminal.processing.activatingFuel')
      }
      if (progress.value >= 95 && !statusMessages.value[3].completed) {
        statusMessages.value[3].completed = true
        currentMessage.value = t('terminal.processing.pumpReady')
        currentSubMessage.value = t('terminal.processing.proceedToPump')
      }
    } else {
      clearInterval(progressInterval)
      // Navigate to fueling screen after completion
      setTimeout(() => {
        emit('navigate', 'fueling')
      }, 500)
    }
  }, 50) // Update every 50ms for smooth animation
})

// Cleanup on unmount
const cleanup = () => {
  if (progressInterval) clearInterval(progressInterval)
  if (statusInterval) clearInterval(statusInterval)
}

// Cleanup when component is destroyed
onMounted(() => {
  return cleanup
})
</script>

<style scoped>
.terminal-screen-content {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
  color: #fff;
  padding: 2rem;
  justify-content: center;
  align-items: center;
}

.processing-screen {
  text-align: center;
}

/* Processing Animation */
.processing-animation {
  position: relative;
  margin-bottom: 2rem;
}

.card-icon-container {
  position: relative;
  width: 120px;
  height: 120px;
  margin: 0 auto 2rem;
}

.card-icon {
  font-size: 5rem;
  animation: float 2s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-15px);
  }
}

.card-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 140px;
  height: 140px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.3) 0%, transparent 70%);
  border-radius: 50%;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: translate(-50%, -50%) scale(1);
    opacity: 0.5;
  }
  50% {
    transform: translate(-50%, -50%) scale(1.3);
    opacity: 0.2;
  }
}

.spinner-container {
  display: flex;
  justify-content: center;
  margin-bottom: 2rem;
}

.spinner {
  width: 60px;
  height: 60px;
  border: 4px solid rgba(59, 130, 246, 0.2);
  border-top-color: #3b82f6;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* Processing Content */
.processing-content {
  width: 100%;
  max-width: 400px;
  margin-bottom: 2rem;
}

.processing-title {
  font-size: 1.75rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 0.5rem;
  animation: fadeIn 0.5s ease-out;
}

.processing-subtitle {
  font-size: 0.95rem;
  color: #94a3b8;
  margin-bottom: 1.5rem;
  animation: fadeIn 0.5s ease-out 0.2s both;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

/* Progress Bar */
.progress-bar-container {
  width: 100%;
  height: 12px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 6px;
  overflow: hidden;
  margin-bottom: 0.5rem;
}

.progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
  border-radius: 6px;
  transition: width 0.3s ease;
  box-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% {
    background-position: -200% 0;
  }
  100% {
    background-position: 200% 0;
  }
}

.progress-text {
  font-size: 0.9rem;
  color: #3b82f6;
  font-weight: bold;
}

/* Status Messages */
.status-messages {
  width: 100%;
  max-width: 400px;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
}

.status-message {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 0.5rem;
  transition: all 0.3s;
}

.status-message.completed {
  background: rgba(16, 185, 129, 0.1);
  border-color: rgba(16, 185, 129, 0.3);
}

.status-icon {
  font-size: 1.25rem;
  flex-shrink: 0;
}

.status-message.completed .status-icon {
  animation: checkPop 0.3s ease-out;
}

@keyframes checkPop {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.3);
  }
  100% {
    transform: scale(1);
  }
}

.status-text {
  font-size: 0.9rem;
  color: #cbd5e1;
  text-align: left;
}

.status-message.completed .status-text {
  color: #10b981;
}

/* Security Notice */
.security-notice {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.2);
  border-radius: 0.5rem;
  max-width: 400px;
}

.security-icon {
  font-size: 1.25rem;
}

.security-text {
  font-size: 0.85rem;
  color: #10b981;
  font-weight: 500;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .card-icon {
    font-size: 4rem;
  }
  
  .card-icon-container {
    width: 100px;
    height: 100px;
  }
  
  .processing-title {
    font-size: 1.5rem;
  }
  
  .spinner {
    width: 50px;
    height: 50px;
  }
}
</style>
