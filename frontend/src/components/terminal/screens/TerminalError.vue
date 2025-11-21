<template>
  <div class="terminal-screen-content error-screen">
    
    <!-- Error Animation -->
    <div class="error-animation">
      <div class="error-icon-container">
        <div class="error-icon">
          <XCircle :size="80" :stroke-width="2" />
        </div>
        <div class="error-pulse"></div>
      </div>
    </div>
    
    <!-- Error Content -->
    <div class="error-content">
      <h2 class="error-title">{{ errorTitle }}</h2>
      <p class="error-message">{{ errorMessage }}</p>
      
      <!-- Error Code -->
      <div v-if="errorCode" class="error-code">
        <span class="code-label">{{ t('terminal.error.errorCode') }}:</span>
        <span class="code-value">{{ errorCode }}</span>
      </div>
    </div>
    
    <!-- Error Details -->
    <div class="error-details">
      <div class="detail-item">
        <span class="detail-icon">
          <AlertTriangle :size="20" :stroke-width="2" />
        </span>
        <span class="detail-text">{{ errorHint }}</span>
      </div>
    </div>
    
    <!-- Actions -->
    <div class="action-area">
      <button class="action-btn primary" @click="handleRetry">
        <RotateCw :size="20" :stroke-width="2" />
        {{ t('terminal.error.tryAgain') }}
      </button>
      <button class="action-btn secondary" @click="handleCancel">
        <X :size="20" :stroke-width="2" />
        {{ t('terminal.error.cancelTransaction') }}
      </button>
      <button class="action-btn tertiary" @click="handleSupport">
        <Phone :size="20" :stroke-width="2" />
        {{ t('terminal.error.contactSupportBtn') }}
      </button>
    </div>
    
    <!-- Help Notice -->
    <div class="help-notice">
      <p class="help-text">
        {{ t('terminal.error.needHelp') }}
      </p>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { computed, defineProps, defineEmits } from 'vue'
import { useI18n } from 'vue-i18n'
import { XCircle, AlertTriangle, RotateCw, X, Phone } from 'lucide-vue-next'

const { t } = useI18n()

interface Props {
  state: any
}

const props = defineProps<Props>()
const emit = defineEmits(['navigate', 'update-state'])

// Error details based on state
const errorTitle = computed(() => {
  return props.state.error || t('terminal.error.title')
})

const errorMessage = computed(() => {
  // Provide user-friendly error messages
  const error = props.state.error?.toLowerCase() || ''
  
  if (error.includes('pump') && error.includes('auth')) {
    return t('terminal.error.pumpAuthFailed')
  }
  if (error.includes('fuel') && error.includes('flow')) {
    return t('terminal.error.fuelFlowError')
  }
  if (error.includes('payment')) {
    return t('terminal.error.paymentFailed')
  }
  if (error.includes('network') || error.includes('connection')) {
    return t('terminal.error.networkError')
  }
  if (error.includes('timeout')) {
    return t('terminal.error.timeout')
  }
  if (error.includes('declined')) {
    return t('terminal.error.declined')
  }
  
  return t('terminal.error.unexpectedError')
})

const errorCode = computed(() => {
  // Generate error code based on error type
  const error = props.state.error?.toLowerCase() || ''
  
  if (error.includes('pump') && error.includes('auth')) return 'ERR_PUMP_001'
  if (error.includes('fuel') && error.includes('flow')) return 'ERR_FUEL_001'
  if (error.includes('payment')) return 'ERR_PAY_001'
  if (error.includes('network')) return 'ERR_NET_001'
  if (error.includes('timeout')) return 'ERR_TMO_001'
  if (error.includes('declined')) return 'ERR_DEC_001'
  
  return 'ERR_UNK_001'
})

const errorHint = computed(() => {
  const error = props.state.error?.toLowerCase() || ''
  
  if (error.includes('payment') || error.includes('declined')) {
    return t('terminal.error.tryDifferentPayment')
  }
  if (error.includes('network') || error.includes('connection')) {
    return t('terminal.error.checkConnection')
  }
  if (error.includes('timeout')) {
    return t('terminal.error.serverTimeout')
  }
  
  return t('terminal.error.contactSupport')
})

const handleRetry = () => {
  // Clear error and go back to review screen
  emit('update-state', { error: null })
  emit('navigate', 'review')
}

const handleCancel = () => {
  // Clear error and go back to welcome
  emit('update-state', { error: null })
  emit('navigate', 'welcome')
}

const handleSupport = () => {
  // Show alert with support info (could open modal in real app)
  alert('📞 Support Contact:\n\nPhone: +49 123 456 789\nEmail: support@prem-lichtwerbung.de\n\nOur team is available Monday-Friday, 9AM-6PM')
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
  justify-content: center;
  align-items: center;
}

.error-screen {
  text-align: center;
}

/* Error Animation */
.error-animation {
  margin-bottom: 2rem;
}

.error-icon-container {
  position: relative;
  width: 120px;
  height: 120px;
  margin: 0 auto;
}

.error-icon {
  font-size: 5rem;
  animation: shake 0.5s ease-in-out;
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  10%, 30%, 50%, 70%, 90% {
    transform: translateX(-10px);
  }
  20%, 40%, 60%, 80% {
    transform: translateX(10px);
  }
}

.error-pulse {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 140px;
  height: 140px;
  background: radial-gradient(circle, rgba(239, 68, 68, 0.3) 0%, transparent 70%);
  border-radius: 50%;
  animation: errorPulse 2s ease-in-out infinite;
}

@keyframes errorPulse {
  0%, 100% {
    transform: translate(-50%, -50%) scale(1);
    opacity: 0.5;
  }
  50% {
    transform: translate(-50%, -50%) scale(1.3);
    opacity: 0.2;
  }
}

/* Error Content */
.error-content {
  width: 100%;
  max-width: 400px;
  margin-bottom: 1.5rem;
}

.error-title {
  font-size: 2rem;
  font-weight: bold;
  color: #ef4444;
  margin-bottom: 1rem;
  animation: fadeInUp 0.5s ease-out;
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

.error-message {
  font-size: 1rem;
  color: #cbd5e1;
  margin-bottom: 1rem;
  line-height: 1.6;
  animation: fadeInUp 0.5s ease-out 0.1s both;
}

.error-code {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(239, 68, 68, 0.1);
  border: 1px solid rgba(239, 68, 68, 0.3);
  border-radius: 0.5rem;
  font-family: monospace;
  animation: fadeInUp 0.5s ease-out 0.2s both;
}

.code-label {
  font-size: 0.85rem;
  color: #94a3b8;
}

.code-value {
  font-size: 0.9rem;
  font-weight: bold;
  color: #ef4444;
}

/* Error Details */
.error-details {
  width: 100%;
  max-width: 400px;
  margin-bottom: 1.5rem;
  animation: fadeInUp 0.5s ease-out 0.3s both;
}

.detail-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem;
  background: rgba(59, 130, 246, 0.1);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 0.5rem;
}

.detail-icon {
  font-size: 1.25rem;
  flex-shrink: 0;
}

.detail-text {
  font-size: 0.9rem;
  color: #cbd5e1;
  text-align: left;
}

/* Actions */
.action-area {
  width: 100%;
  max-width: 400px;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin-bottom: 1rem;
  animation: fadeInUp 0.5s ease-out 0.4s both;
}

.action-btn {
  width: 100%;
  padding: 1rem 2rem;
  font-size: 1.125rem;
  font-weight: bold;
  border: none;
  border-radius: 0.75rem;
  cursor: pointer;
  transition: all 0.3s;
}

.action-btn.primary {
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.action-btn.primary:hover {
  background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
}

.action-btn.secondary {
  background: rgba(239, 68, 68, 0.2);
  color: #ef4444;
  border: 2px solid rgba(239, 68, 68, 0.3);
}

.action-btn.secondary:hover {
  background: rgba(239, 68, 68, 0.3);
  border-color: rgba(239, 68, 68, 0.4);
  transform: translateY(-2px);
}

.action-btn.tertiary {
  background: rgba(255, 255, 255, 0.05);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.action-btn.tertiary:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.action-btn:active {
  transform: translateY(0);
}

/* Help Notice */
.help-notice {
  animation: fadeInUp 0.5s ease-out 0.5s both;
}

.help-text {
  font-size: 0.85rem;
  color: #94a3b8;
  line-height: 1.6;
}

.help-text strong {
  color: #3b82f6;
  font-weight: 600;
}

/* Responsive */
@media (max-width: 768px) {
  .terminal-screen-content {
    padding: 1.5rem;
  }
  
  .error-icon {
    font-size: 4rem;
  }
  
  .error-icon-container {
    width: 100px;
    height: 100px;
  }
  
  .error-title {
    font-size: 1.75rem;
  }
  
  .action-btn {
    padding: 0.875rem 1.5rem;
    font-size: 1rem;
  }
}
</style>
