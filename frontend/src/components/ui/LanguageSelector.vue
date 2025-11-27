<template>
  <div class="flex items-center gap-2">
    <button
      @click="changeLanguage('en')"
      :class="[
        'px-3 py-1.5 text-sm font-medium transition-all duration-300',
        currentLocale === 'en'
          ? 'text-primary border-b-2 border-primary'
          : 'text-gray-600 hover:text-primary'
      ]"
    >
      EN
    </button>
    <span class="text-gray-300">|</span>
    <button
      @click="changeLanguage('de')"
      :class="[
        'px-3 py-1.5 text-sm font-medium transition-all duration-300',
        currentLocale === 'de'
          ? 'text-primary border-b-2 border-primary'
          : 'text-gray-600 hover:text-primary'
      ]"
    >
      DE
    </button>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale } = useI18n()

const currentLocale = computed(() => locale.value)

const changeLanguage = (lang: string) => {
  locale.value = lang
  localStorage.setItem('locale', lang)
}
</script>
