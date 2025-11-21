<template>
  <div class="language-switcher">
    <button @click="toggleLanguage" class="lang-btn">
      <Languages :size="20" />
      <span>{{ locale === 'en' ? '🇬🇧 EN' : '🇩🇪 DE' }}</span>
    </button>
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { Languages } from 'lucide-vue-next'

const { locale } = useI18n()

const toggleLanguage = () => {
  locale.value = locale.value === 'en' ? 'de' : 'en'
  localStorage.setItem('locale', locale.value)
}
</script>

<style scoped>
.language-switcher {
  position: absolute;
  top: 1rem;
  right: 1rem;
  z-index: 10;
}

.lang-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid #4b5563;
  border-radius: 0.5rem;
  color: #fff;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s;
}

.lang-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: #6b7280;
}
</style>