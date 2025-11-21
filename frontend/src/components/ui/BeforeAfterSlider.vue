<template>
  <div
    ref="containerRef"
    class="relative w-full overflow-hidden select-none"
    :style="{ aspectRatio: '16/9' }"
    @mousedown="startDrag"
    @touchstart="startDrag"
  >
    <!-- Before Image (Full) -->
    <div class="absolute inset-0">
      <img
        :src="beforeImage"
        alt="Before"
        loading="lazy"
        class="w-full h-full object-cover"
      />
      <!-- BEFORE Label - Minimal -->
      <div class="absolute top-6 left-6 bg-black text-white px-4 py-2 text-xs font-light uppercase tracking-wider">
        Before
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
        loading="lazy"
        class="w-full h-full object-cover"
      />
      <!-- AFTER Label - Minimal -->
      <div class="absolute top-6 right-6 bg-white text-black px-4 py-2 text-xs font-light uppercase tracking-wider border border-black">
        After
      </div>
    </div>

    <!-- Slider Handle - Minimal -->
    <div
      class="absolute top-0 bottom-0 w-0.5 bg-white cursor-ew-resize transition-opacity duration-800"
      :style="{ left: `${sliderPosition}%` }"
    >
      <!-- Handle Arrows Only -->
      <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex items-center gap-1">
        <ChevronLeft :size="20" :stroke-width="2" class="text-white" />
        <ChevronRight :size="20" :stroke-width="2" class="text-white" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onUnmounted } from 'vue'
import { ChevronLeft, ChevronRight } from 'lucide-vue-next'

const props = defineProps<{
  beforeImage: string
  afterImage: string
}>()

const containerRef = ref<HTMLElement | null>(null)
const sliderPosition = ref(50) // Start at 50%
const isDragging = ref(false)

const startDrag = (event: MouseEvent | TouchEvent) => {
  isDragging.value = true
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
