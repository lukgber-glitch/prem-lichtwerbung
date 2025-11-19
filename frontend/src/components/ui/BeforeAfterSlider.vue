<template>
  <div
    ref="containerRef"
    class="relative w-full overflow-hidden rounded-lg shadow-lg select-none"
    :style="{ aspectRatio: '16/9' }"
    @mousedown="startDrag"
    @touchstart="startDrag"
  >
    <!-- Before Image (Full) -->
    <div class="absolute inset-0">
      <img
        :src="beforeImage"
        alt="Before"
        class="w-full h-full object-cover"
      />
      <!-- BEFORE Label -->
      <div class="absolute top-4 left-4 bg-brand-navy bg-opacity-80 text-brand-warm px-4 py-2 rounded-lg font-bold">
        BEFORE
      </div>
    </div>

    <!-- After Image (Clipped) -->
    <div
      class="absolute inset-0"
      :style="{ clipPath: `inset(0 ${100 - sliderPosition}% 0 0)` }"
    >
      <img
        :src="afterImage"
        alt="After"
        class="w-full h-full object-cover"
      />
      <!-- AFTER Label -->
      <div class="absolute top-4 right-4 bg-brand-blue text-brand-navy px-4 py-2 rounded-lg font-bold">
        AFTER
      </div>
    </div>

    <!-- Slider Handle -->
    <div
      class="absolute top-0 bottom-0 w-1 bg-white cursor-ew-resize"
      :style="{ left: `${sliderPosition}%` }"
    >
      <!-- Handle Circle -->
      <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-12 h-12 bg-white rounded-full shadow-lg flex items-center justify-center">
        <!-- Left Arrow -->
        <svg class="w-4 h-4 text-brand-navy -ml-2" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
        </svg>
        <!-- Right Arrow -->
        <svg class="w-4 h-4 text-brand-navy -mr-2" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
        </svg>
      </div>
    </div>

    <!-- Instructions Overlay (shown initially) -->
    <div
      v-if="showInstructions"
      class="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center transition-opacity duration-300"
      @click="hideInstructions"
    >
      <div class="text-center text-white">
        <svg class="w-16 h-16 mx-auto mb-4 animate-pulse" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
        </svg>
        <p class="text-lg font-semibold">Drag to compare</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const props = defineProps<{
  beforeImage: string
  afterImage: string
}>()

const containerRef = ref<HTMLElement | null>(null)
const sliderPosition = ref(50) // Start at 50%
const isDragging = ref(false)
const showInstructions = ref(true)

const hideInstructions = () => {
  showInstructions.value = false
}

const startDrag = (event: MouseEvent | TouchEvent) => {
  isDragging.value = true
  showInstructions.value = false
  updateSliderPosition(event)
  
  // Add event listeners for drag
  if (event instanceof MouseEvent) {
    document.addEventListener('mousemove', updateSliderPosition)
    document.addEventListener('mouseup', stopDrag)
  } else {
    document.addEventListener('touchmove', updateSliderPosition)
    document.addEventListener('touchend', stopDrag)
  }
}

const stopDrag = () => {
  isDragging.value = false
  document.removeEventListener('mousemove', updateSliderPosition)
  document.removeEventListener('mouseup', stopDrag)
  document.removeEventListener('touchmove', updateSliderPosition)
  document.removeEventListener('touchend', stopDrag)
}

const updateSliderPosition = (event: MouseEvent | TouchEvent) => {
  if (!containerRef.value) return

  const rect = containerRef.value.getBoundingClientRect()
  let clientX: number

  if (event instanceof MouseEvent) {
    clientX = event.clientX
  } else {
    clientX = event.touches[0].clientX
  }

  const x = clientX - rect.left
  const percentage = (x / rect.width) * 100

  // Clamp between 0 and 100
  sliderPosition.value = Math.max(0, Math.min(100, percentage))
}

// Auto-hide instructions after 3 seconds
onMounted(() => {
  setTimeout(() => {
    showInstructions.value = false
  }, 3000)
})

// Cleanup event listeners
onUnmounted(() => {
  stopDrag()
})
</script>

<style scoped>
/* Prevent text selection during drag */
.select-none {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
</style>
