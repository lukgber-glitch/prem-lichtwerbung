<template>
  <div class="relative">
    <button
      @click="toggleDropdown"
      class="flex items-center gap-2 px-3 py-2 hover:opacity-60 transition-opacity duration-500 text-black cursor-pointer"
      :title="currentLanguage === 'en' ? 'Switch language' : 'Sprache wechseln'"
    >
      <span class="text-sm font-light">{{ currentLanguage.toUpperCase() }}</span>
      <ChevronDown :size="14" :stroke-width="1.5" class="transition-transform duration-500" :class="{ 'rotate-180': isOpen }" />
    </button>
    
    <transition
      enter-active-class="transition ease-out duration-300"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition ease-in duration-200"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="isOpen"
        class="absolute right-0 mt-2 w-32 bg-white border border-black overflow-hidden z-50"
      >
        <button
          @click="changeLanguage('en')"
          class="w-full px-4 py-3 hover:bg-black hover:text-white transition-all duration-500 text-left text-sm font-light cursor-pointer"
          :class="{ 'bg-black text-white': currentLanguage === 'en', 'bg-white text-black': currentLanguage !== 'en' }"
        >
          English
        </button>
        <button
          @click="changeLanguage('de')"
          class="w-full px-4 py-3 hover:bg-black hover:text-white transition-all duration-500 text-left text-sm font-light border-t border-black cursor-pointer"
          :class="{ 'bg-black text-white': currentLanguage === 'de', 'bg-white text-black': currentLanguage !== 'de' }"
        >
          Deutsch
        </button>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { ChevronDown } from 'lucide-vue-next'

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
