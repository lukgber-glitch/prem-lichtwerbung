<template>
  <div class="relative w-full">
    <!-- Image Container -->
    <div class="relative w-full overflow-hidden rounded-lg shadow-lg" :style="{ aspectRatio: '16/9' }">
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

      <!-- Mode Label -->
      <div class="absolute top-4 left-4 bg-black bg-opacity-60 text-white px-4 py-2 rounded-lg font-semibold">
        {{ isDayMode ? 'Daytime View' : 'Nighttime Illuminated' }}
      </div>
    </div>

    <!-- Toggle Control -->
    <div class="flex items-center justify-center gap-4 mt-6">
      <!-- Day Button -->
      <button
        @click="isDayMode = true"
        class="flex items-center gap-2 px-6 py-3 rounded-lg font-semibold transition-all duration-300"
        :class="isDayMode 
          ? 'bg-primary text-background shadow-lg scale-105' 
          : 'bg-surface-alt text-text-muted hover:bg-surface hover:text-text-main'"
      >
        <Sun :size="20" :stroke-width="2.5" />
        <span>Day</span>
      </button>

      <!-- Toggle Switch -->
      <div
        @click="toggleMode"
        class="relative w-16 h-8 bg-surface-alt rounded-full cursor-pointer transition-colors duration-300 border-2 border-primary/20"
        :class="{ 'bg-primary/20': !isDayMode }"
      >
        <div
          class="absolute top-1 w-6 h-6 bg-primary rounded-full shadow-md transition-transform duration-300 ease-in-out"
          :class="isDayMode ? 'left-1' : 'left-9'"
        >
          <Sun v-if="isDayMode" :size="16" :stroke-width="2.5" class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-background" />
          <Moon v-else :size="16" :stroke-width="2.5" class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-background" />
        </div>
      </div>

      <!-- Night Button -->
      <button
        @click="isDayMode = false"
        class="flex items-center gap-2 px-6 py-3 rounded-lg font-semibold transition-all duration-300"
        :class="!isDayMode 
          ? 'bg-primary text-background shadow-lg scale-105' 
          : 'bg-surface-alt text-text-muted hover:bg-surface hover:text-text-main'"
      >
        <Moon :size="20" :stroke-width="2.5" />
        <span>Night</span>
      </button>
    </div>

    <!-- Description -->
    <p class="text-center text-text-muted mt-4 text-sm">
      Click the buttons or toggle to switch between day and night views
    </p>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Sun, Moon } from 'lucide-vue-next'

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
