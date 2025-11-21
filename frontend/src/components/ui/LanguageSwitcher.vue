<template>
  <div class="relative">
    <button
      @click="toggleDropdown"
      class="flex items-center gap-2 px-3 py-2 hover:bg-primary/10 rounded-lg transition-colors text-primary"
      :title="currentLanguage === 'en' ? 'Switch language' : 'Sprache wechseln'"
    >
      <Globe :size="20" :stroke-width="2" />
      <span class="text-sm font-medium">{{ currentLanguage.toUpperCase() }}</span>
      <ChevronDown :size="16" :stroke-width="2" :class="{ 'rotate-180': isOpen }" />
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
        class="absolute right-0 mt-2 w-40 bg-surface border border-primary/20 rounded-lg shadow-xl overflow-hidden z-50"
      >
        <button
          @click="changeLanguage('en')"
          class="w-full flex items-center gap-3 px-4 py-3 hover:bg-primary/10 transition-colors text-left"
          :class="{ 'bg-primary/20': currentLanguage === 'en' }"
        >
          <span class="text-sm font-semibold text-primary">EN</span>
          <span class="text-text-main font-medium">English</span>
        </button>
        <button
          @click="changeLanguage('de')"
          class="w-full flex items-center gap-3 px-4 py-3 hover:bg-primary/10 transition-colors text-left"
          :class="{ 'bg-primary/20': currentLanguage === 'de' }"
        >
          <span class="text-sm font-semibold text-primary">DE</span>
          <span class="text-text-main font-medium">Deutsch</span>
        </button>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { ChevronDown, Globe } from 'lucide-vue-next'

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
