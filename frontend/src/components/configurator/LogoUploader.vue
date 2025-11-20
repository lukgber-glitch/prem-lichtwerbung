<template>
  <div class="bg-white rounded-xl shadow-lg p-6">
    <h3 class="text-2xl font-accent font-bold text-brand-navy mb-4">Upload Your Logo</h3>
    
    <!-- Upload Area -->
    <div v-if="!uploadedLogo" 
         @drop.prevent="handleDrop" 
         @dragover.prevent 
         class="border-4 border-dashed border-brand-blue/30 rounded-xl p-12 text-center hover:border-brand-blue hover:bg-brand-blue/5 transition-all cursor-pointer"
         @click="triggerFileInput">
      <div class="text-6xl mb-4">📤</div>
      <p class="text-lg font-semibold text-brand-navy mb-2">Drag & drop your logo here</p>
      <p class="text-sm text-gray-500 mb-4">or click to browse</p>
      <p class="text-xs text-gray-400">Accepts: PNG, SVG, JPG (Max 5MB)</p>
      <input ref="fileInput" type="file" accept=".png,.svg,.jpg,.jpeg" @change="handleFileSelect" class="hidden">
    </div>
    
    <!-- Preview Area -->
    <div v-else class="space-y-6">
      
      <!-- Mockup Preview -->
      <div class="relative bg-gradient-to-br from-gray-100 to-gray-200 rounded-xl p-8 aspect-video flex items-center justify-center overflow-hidden">
        <div class="absolute inset-0 bg-brand-navy/10"></div>
        <img 
          :src="uploadedLogo" 
          alt="Logo Preview" 
          loading="lazy"
          class="relative z-10 max-w-full max-h-full object-contain transition-all"
          :style="{ 
            width: logoSize + '%', 
            transform: `translate(${logoPosition.x}px, ${logoPosition.y}px)` 
          }"
          draggable="true"
          @dragstart="startDrag"
          @drag="drag"
        >
      </div>
      
      <!-- Size Control -->
      <div>
        <label class="block text-sm font-semibold text-brand-navy mb-2">Logo Size: {{ logoSize }}%</label>
        <input v-model="logoSize" type="range" min="50" max="150" class="w-full">
        <div class="flex justify-between text-xs text-gray-500 mt-1">
          <span>50%</span>
          <span>100%</span>
          <span>150%</span>
        </div>
      </div>
      
      <!-- Position Info -->
      <div class="bg-brand-gray-light p-4 rounded-lg">
        <p class="text-sm text-gray-600">💡 <strong>Tip:</strong> Drag the logo to reposition it on the mockup</p>
      </div>
      
      <!-- Actions -->
      <div class="flex gap-4">
        <ButtonGlow variant="primary" @click="requestProfessionalMockup" class="flex-1">
          🎨 Request Professional Mockup
        </ButtonGlow>
        <button @click="clearLogo" class="px-6 py-3 rounded-lg border-2 border-gray-300 hover:border-red-500 hover:text-red-500 transition-colors">
          🗑️ Clear Logo
        </button>
      </div>
      
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const emit = defineEmits<{
  requestMockup: [logoData: string]
}>()

const fileInput = ref<HTMLInputElement | null>(null)
const uploadedLogo = ref<string | null>(null)
const logoSize = ref(100)
const logoPosition = ref({ x: 0, y: 0 })

let dragStartX = 0
let dragStartY = 0

const triggerFileInput = () => {
  fileInput.value?.click()
}

const handleFileSelect = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files && target.files[0]) {
    processFile(target.files[0])
  }
}

const handleDrop = (event: DragEvent) => {
  if (event.dataTransfer?.files && event.dataTransfer.files[0]) {
    processFile(event.dataTransfer.files[0])
  }
}

const processFile = (file: File) => {
  if (file.size > 5 * 1024 * 1024) {
    alert('File size must be less than 5MB')
    return
  }
  
  const reader = new FileReader()
  reader.onload = (e) => {
    uploadedLogo.value = e.target?.result as string
  }
  reader.readAsDataURL(file)
}

const startDrag = (event: DragEvent) => {
  dragStartX = event.clientX - logoPosition.value.x
  dragStartY = event.clientY - logoPosition.value.y
}

const drag = (event: DragEvent) => {
  if (event.clientX === 0 && event.clientY === 0) return
  logoPosition.value = {
    x: event.clientX - dragStartX,
    y: event.clientY - dragStartY
  }
}

const clearLogo = () => {
  uploadedLogo.value = null
  logoSize.value = 100
  logoPosition.value = { x: 0, y: 0 }
  if (fileInput.value) fileInput.value.value = ''
}

const requestProfessionalMockup = () => {
  if (uploadedLogo.value) {
    emit('requestMockup', uploadedLogo.value)
  }
}
</script>
