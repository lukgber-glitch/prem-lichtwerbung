import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createI18n } from 'vue-i18n'
import App from './App.vue'
import router from './router'

// Omnicom-Inspired Premium Fonts - Extended Weight Range
// Using Helvetica Neue / Arial system fonts as per Omnicom style (see style.css)

import './style.css'
import en from './locales/en.json'
import de from './locales/de.json'

// Get saved language from localStorage or use browser language or default to 'en'
const savedLocale = localStorage.getItem('locale')
const browserLocale = navigator.language.split('-')[0]
const defaultLocale = savedLocale || (browserLocale === 'de' ? 'de' : 'en')

// Create i18n instance
const i18n = createI18n({
  legacy: false,
  locale: defaultLocale,
  fallbackLocale: 'en',
  messages: {
    en,
    de
  }
})

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(i18n)

app.mount('#app')
