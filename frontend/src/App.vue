<template>
  <div id="app" :class="['flex flex-col min-h-screen bg-white', pageClass]">
    <Header />
    
    <main class="flex-grow">
      <RouterView />
    </main>
    
    <Footer />
    
    <!-- Global UI Components -->
    <ShineSwitcher />
    <ChatWidget />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { RouterView, useRoute } from 'vue-router'
import Header from '@/components/layout/Header.vue'
import Footer from '@/components/layout/Footer.vue'
import ShineSwitcher from '@/components/ui/ShineSwitcher.vue'
import ChatWidget from '@/components/ui/ChatWidget.vue'

const route = useRoute()

// Dynamic page class based on current route for page-specific accent colors
const pageClass = computed(() => {
  const path = route.path
  if (path === '/' || path === '/home') return 'page-home'
  if (path.includes('/about')) return 'page-about'
  if (path.includes('/products') || path.includes('/services')) return 'page-services'
  if (path.includes('/work') || path.includes('/portfolio')) return 'page-work'
  if (path.includes('/news') || path.includes('/blog')) return 'page-news'
  if (path.includes('/careers')) return 'page-careers'
  if (path.includes('/contact')) return 'page-contact'
  return 'page-default'
})
</script>
