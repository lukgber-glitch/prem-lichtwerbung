<template>
  <div class="fixed bottom-6 right-6 z-50">
    <button
      @click="toggleMode"
      class="group relative w-16 h-16 rounded-full bg-gradient-to-br from-brand-blue to-brand-pink shadow-2xl hover:scale-110 transition-all duration-500 overflow-hidden"
      :class="{ 'animate-glow-pulse': isDark }"
      aria-label="Toggle day/night mode"
    >
      
      <!-- Day icon -->
      <div 
        class="absolute inset-0 flex items-center justify-center transition-all duration-700"
        :class="{ 'opacity-0 rotate-180 scale-0': isDark, 'opacity-100 rotate-0 scale-100': !isDark }"
      >
        <span class="text-3xl">☀️</span>
      </div>
      
      <!-- Night icon -->
      <div 
        class="absolute inset-0 flex items-center justify-center transition-all duration-700"
        :class="{ 'opacity-100 rotate-0 scale-100': isDark, 'opacity-0 -rotate-180 scale-0': !isDark }"
      >
        <span class="text-3xl">🌙</span>
      </div>
      
      <!-- Tooltip -->
      <div class="absolute right-full mr-4 top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none whitespace-nowrap">
        <div class="bg-brand-navy text-brand-warm px-4 py-2 rounded-lg shadow-xl border border-brand-blue/30">
          {{ isDark ? 'See in daylight' : 'See the glow' }}
        </div>
      </div>
      
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

const isDark = ref(false)

const toggleMode = () => {
  isDark.value = !isDark.value
  
  if (isDark.value) {
    document.documentElement.classList.add('night-mode')
  } else {
    document.documentElement.classList.remove('night-mode')
  }
}

watch(isDark, (newValue) => {
  window.dispatchEvent(new CustomEvent('shine-mode-change', { detail: { isDark: newValue } }))
})
</script>
