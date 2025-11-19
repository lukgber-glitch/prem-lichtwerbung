<template>
  <div class="bg-white rounded-lg shadow-lg p-6">
    <h3 class="text-2xl font-bold mb-4 font-accent text-brand-navy">
      Upload Your Logo
    </h3>
    <p class="text-gray-600 mb-6">
      See how your logo will look on the signage before ordering
    </p>

    <!-- File Upload Area -->
    <div
      v-if="!uploadedLogo"
      @drop.prevent="handleDrop"
      @dragover.prevent="isDragging = true"
      @dragleave.prevent="isDragging = false"
      :class="[
        'border-2 border-dashed rounded-lg p-8 text-center transition-all duration-300 cursor-pointer',
        isDragging 
          ? 'border-brand-blue bg-brand-blue bg-opacity-10 scale-105' 
          : 'border-gray-300 hover:border-brand-blue hover:bg-brand-gray-light'
      ]"
      @click="$refs.fileInput.click()"
    >
      <input
        ref="fileInput"
        type="file"
        accept="image/png,image/jpeg,image/jpg,image/svg+xml"
        class="hidden"
        @change="handleFileSelect"
      />
      
      <div class="flex flex-col items-center">
        <!-- Upload Icon -->
        <svg class="w-16 h-16 text-brand-blue mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
        </svg>
        
        <p class="text-lg font-semibold text-brand-navy mb-2">
          {{ isDragging ? 'Drop your logo here' : 'Drag and drop your logo' }}
        </p>
        <p class="text-sm text-gray-600 mb-4">or click to browse</p>
        
        <div class="text-xs text-gray-500 space-y-1">
          <p>Supported formats: PNG, JPG, SVG</p>
          <p>Maximum file size: 5MB</p>
        </div>
      </div>
    </div>

    <!-- Error Message -->
    <div v-if="errorMessage" class="mt-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg">
      <p class="font-semibold">{{ errorMessage }}</p>
    </div>

    <!-- Logo Preview & Mockup -->
    <div v-if="uploadedLogo" class="mt-6 space-y-6">
      <!-- Logo Info & Actions -->
      <div class="flex items-center justify-between p-4 bg-brand-gray-light rounded-lg">
        <div class="flex items-center gap-4">
          <div class="w-16 h-16 bg-white rounded-lg shadow-sm flex items-center justify-center overflow-hidden">
            <img :src="uploadedLogo" alt="Uploaded logo" class="max-w-full max-h-full object-contain" />
          </div>
          <div>
            <p class="font-semibold text-brand-navy">{{ fileName }}</p>
            <p class="text-sm text-gray-600">{{ fileSize }}</p>
          </div>
        </div>
        <button
          @click="clearLogo"
          class="px-4 py-2 text-sm font-semibold text-red-600 hover:bg-red-100 rounded-lg transition-colors"
        >
          Clear Logo
        </button>
      </div>

      <!-- Mockup Preview -->
      <div class="space-y-4">
        <h4 class="font-semibold text-brand-navy">Preview on Signage</h4>
        
        <!-- Mockup Container -->
        <div
          ref="mockupContainer"
          class="relative aspect-video bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg overflow-hidden"
          @mousedown="startDragging"
          @touchstart="startDragging"
        >
          <!-- Background Signage Image -->
          <div class="absolute inset-0 flex items-center justify-center opacity-30">
            <svg class="w-64 h-64 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
            </svg>
          </div>

          <!-- Logo Overlay -->
          <div
            class="absolute cursor-move select-none"
            :style="{
              left: logoPosition.x + '%',
              top: logoPosition.y + '%',
              transform: `translate(-50%, -50%) scale(${logoScale / 100})`
            }"
          >
            <img
              :src="uploadedLogo"
              alt="Logo preview"
              class="max-w-[200px] pointer-events-none"
              draggable="false"
            />
          </div>

          <!-- Instruction Overlay -->
          <div class="absolute top-4 left-4 bg-black bg-opacity-60 text-white px-3 py-2 rounded-lg text-sm">
            Click and drag to position your logo
          </div>
        </div>

        <!-- Size Adjustment -->
        <div class="space-y-2">
          <label class="block text-sm font-semibold text-gray-700">
            Logo Size: {{ logoScale }}%
          </label>
          <input
            v-model.number="logoScale"
            type="range"
            min="50"
            max="150"
            step="5"
            class="w-full accent-brand-blue"
          />
          <div class="flex justify-between text-xs text-gray-500">
            <span>50%</span>
            <span>100%</span>
            <span>150%</span>
          </div>
        </div>

        <!-- Position Reset -->
        <button
          @click="resetPosition"
          class="w-full px-4 py-2 text-sm font-semibold text-brand-navy bg-brand-gray-light hover:bg-gray-300 rounded-lg transition-colors"
        >
          Reset Position
        </button>

        <!-- Action Buttons -->
        <div class="flex gap-4">
          <ButtonGlow
            variant="primary"
            @click="$emit('add-to-cart', { logo: uploadedLogo, position: logoPosition, scale: logoScale })"
            class="flex-1"
          >
            Add to Cart with Logo
          </ButtonGlow>
          
          <ButtonGlow
            variant="secondary"
            @click="requestProfessionalMockup"
            class="flex-1"
          >
            Request Professional Mockup
          </ButtonGlow>
        </div>

        <!-- Info Box -->
        <div class="p-4 bg-brand-blue bg-opacity-10 rounded-lg border border-brand-blue">
          <div class="flex items-start gap-3">
            <svg class="w-5 h-5 text-brand-blue flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div class="text-sm text-brand-navy">
              <p class="font-semibold mb-1">Professional Design Service Available</p>
              <p>Our design team can create a professional mockup showing exactly how your logo will look on the finished signage. Click "Request Professional Mockup" to get started.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import ButtonGlow from '../ui/ButtonGlow.vue'

interface LogoData {
  logo: string
  position: { x: number; y: number }
  scale: number
}

const emit = defineEmits<{
  'add-to-cart': [data: LogoData]
  'request-mockup': [data: LogoData]
}>()

// State
const uploadedLogo = ref<string | null>(null)
const fileName = ref('')
const fileSize = ref('')
const isDragging = ref(false)
const errorMessage = ref('')

// Logo positioning
const logoPosition = ref({ x: 50, y: 50 })
const logoScale = ref(100)
const isPositioning = ref(false)
const mockupContainer = ref<HTMLElement | null>(null)

// File size limit (5MB)
const MAX_FILE_SIZE = 5 * 1024 * 1024

// Validate file
const validateFile = (file: File): boolean => {
  errorMessage.value = ''

  // Check file type
  const validTypes = ['image/png', 'image/jpeg', 'image/jpg', 'image/svg+xml']
  if (!validTypes.includes(file.type)) {
    errorMessage.value = 'Invalid file type. Please upload PNG, JPG, or SVG.'
    return false
  }

  // Check file size
  if (file.size > MAX_FILE_SIZE) {
    errorMessage.value = 'File size exceeds 5MB. Please choose a smaller file.'
    return false
  }

  return true
}

// Process uploaded file
const processFile = (file: File) => {
  if (!validateFile(file)) return

  const reader = new FileReader()
  reader.onload = (e) => {
    uploadedLogo.value = e.target?.result as string
    fileName.value = file.name
    fileSize.value = formatFileSize(file.size)
  }
  reader.readAsDataURL(file)
}

// Format file size
const formatFileSize = (bytes: number): string => {
  if (bytes < 1024) return bytes + ' B'
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB'
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}

// Handle file selection
const handleFileSelect = (event: Event) => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  if (file) {
    processFile(file)
  }
}

// Handle drag and drop
const handleDrop = (event: DragEvent) => {
  isDragging.value = false
  const file = event.dataTransfer?.files[0]
  if (file) {
    processFile(file)
  }
}

// Clear uploaded logo
const clearLogo = () => {
  uploadedLogo.value = null
  fileName.value = ''
  fileSize.value = ''
  errorMessage.value = ''
  resetPosition()
}

// Reset logo position
const resetPosition = () => {
  logoPosition.value = { x: 50, y: 50 }
  logoScale.value = 100
}

// Start dragging logo
const startDragging = (event: MouseEvent | TouchEvent) => {
  if (!uploadedLogo.value || !mockupContainer.value) return
  
  isPositioning.value = true
  updateLogoPosition(event)

  const handleMove = (e: MouseEvent | TouchEvent) => {
    if (isPositioning.value) {
      updateLogoPosition(e)
    }
  }

  const stopDragging = () => {
    isPositioning.value = false
    document.removeEventListener('mousemove', handleMove)
    document.removeEventListener('mouseup', stopDragging)
    document.removeEventListener('touchmove', handleMove)
    document.removeEventListener('touchend', stopDragging)
  }

  document.addEventListener('mousemove', handleMove)
  document.addEventListener('mouseup', stopDragging)
  document.addEventListener('touchmove', handleMove)
  document.addEventListener('touchend', stopDragging)
}

// Update logo position based on mouse/touch
const updateLogoPosition = (event: MouseEvent | TouchEvent) => {
  if (!mockupContainer.value) return

  const rect = mockupContainer.value.getBoundingClientRect()
  let clientX: number, clientY: number

  if (event instanceof MouseEvent) {
    clientX = event.clientX
    clientY = event.clientY
  } else {
    clientX = event.touches[0].clientX
    clientY = event.touches[0].clientY
  }

  const x = ((clientX - rect.left) / rect.width) * 100
  const y = ((clientY - rect.top) / rect.height) * 100

  logoPosition.value = {
    x: Math.max(10, Math.min(90, x)),
    y: Math.max(10, Math.min(90, y))
  }
}

// Request professional mockup
const requestProfessionalMockup = () => {
  emit('request-mockup', {
    logo: uploadedLogo.value!,
    position: logoPosition.value,
    scale: logoScale.value
  })
}
</script>

<style scoped>
.select-none {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
</style>
