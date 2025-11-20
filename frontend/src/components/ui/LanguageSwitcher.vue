<template>
  <div class="relative">
    <button
      @click="toggleDropdown"
      class="flex items-center gap-2 px-3 py-2 hover:bg-brand-blue/10 rounded-lg transition-colors text-brand-warm"
      :title="currentLanguage === 'en' ? 'Switch language' : 'Sprache wechseln'"
    >
      <span class="text-xl">{{ currentLanguage === 'en' ? '🇬🇧' : '🇩🇪' }}</span>
      <span class="hidden md:inline text-sm font-medium">{{ currentLanguage.toUpperCase() }}</span>
      <svg class="w-4 h-4" :class="{ 'rotate-180': isOpen }" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
      </svg>
    </button>
    
    <transition
      enter-active-class="transition ease-out duration-100"
      enter-from-class="transform opacity-0 scale-95"
      enter-to-class="transform opacity-100 scale-100"
      leave-active-class="transition ease-in duration-75"
      leave-from-class="transform opacity-100 scale-100"
      leave-to-class="transform opacity-0 scale-95"
    >
      <div
        v-if="isOpen"
        class="absolute right-0 mt-2 w-40 bg-brand-navy border border-brand-blue/20 rounded-lg shadow-xl overflow-hidden z-50"
      >
        <button
          @click="changeLanguage('en')"
          class="w-full flex items-center gap-3 px-4 py-3 hover:bg-brand-blue/10 transition-colors text-left"
          :class="{ 'bg-brand-blue/20': currentLanguage === 'en' }"
        >
          <span class="text-xl">🇬🇧</span>
          <span class="text-brand-warm font-medium">English</span>
        </button>
        <button
          @click="changeLanguage('de')"
          class="w-full flex items-center gap-3 px-4 py-3 hover:bg-brand-blue/10 transition-colors text-left"
          :class="{ 'bg-brand-blue/20': currentLanguage === 'de' }"
        >
          <span class="text-xl">🇩🇪</span>
          <span class="text-brand-warm font-medium">Deutsch</span>
        </button>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale } = useI18n()
const isOpen = ref(false)

const currentLanguage = computed(() => locale.value)

const toggleDropdown = () => {
  isOpen.value = !isOpen.value
}

const changeLanguage = (lang: string) => {
  locale.value = lang
  localStorage.setItem('locale', lang)
  isOpen.value = false
}

// Close dropdown when clicking outside
const handleClickOutside = (event: MouseEvent) => {
  const target = event.target as HTMLElement
  if (!target.closest('.relative')) {
    isOpen.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>
