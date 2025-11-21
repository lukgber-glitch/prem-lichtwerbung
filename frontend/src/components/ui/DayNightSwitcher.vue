<template>
  <div class="relative w-full">
    <!-- Image Container -->
    <div class="relative w-full overflow-hidden" :style="{ aspectRatio: '16/9' }">
      <!-- Day Image -->
      <Transition name="fade" mode="out-in">
        <img
          v-if="isDayMode"
          key="day"
          :src="dayImage"
          alt="Day view"
          loading="lazy"
          class="w-full h-full object-cover"
        />
        <!-- Night Image -->
        <img
          v-else
          key="night"
          :src="nightImage"
          alt="Night view - Illuminated"
          loading="lazy"
          class="w-full h-full object-cover"
        />
      </Transition>

      <!-- Mode Label - Minimal -->
      <div class="absolute top-6 right-6 bg-black text-white px-4 py-2 text-xs font-light uppercase tracking-wider">
        {{ isDayMode ? 'Day' : 'Night' }}
      </div>
    </div>

    <!-- Toggle Control - Minimal Two Buttons -->
    <div class="flex items-center justify-center gap-0 mt-8">
      <!-- Day Button -->
      <button
        @click="isDayMode = true"
        class="px-8 py-3 font-semibold text-sm transition-all duration-500 border border-black cursor-pointer"
        :class="isDayMode 
          ? 'bg-black text-white' 
          : 'bg-white text-black hover:bg-black hover:text-white'"
      >
        Day
      </button>

      <!-- Night Button -->
      <button
        @click="isDayMode = false"
        class="px-8 py-3 font-semibold text-sm transition-all duration-500 border border-black border-l-0 cursor-pointer"
        :class="!isDayMode 
          ? 'bg-black text-white' 
          : 'bg-white text-black hover:bg-black hover:text-white'"
      >
        Night
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps<{
  dayImage: string
  nightImage: string
  initialMode?: 'day' | 'night'
}>()

const isDayMode = ref(props.initialMode === 'night' ? false : true)

const toggleMode = () => {
  isDayMode.value = !isDayMode.value
}
</script>

<style scoped>
/* Fade transition for image switching */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
