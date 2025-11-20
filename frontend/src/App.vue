<template>
  <div id="app" class="flex flex-col min-h-screen bg-white">
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
import { RouterView } from 'vue-router'
import Header from '@/components/layout/Header.vue'
import Footer from '@/components/layout/Footer.vue'
import ShineSwitcher from '@/components/ui/ShineSwitcher.vue'
import ChatWidget from '@/components/ui/ChatWidget.vue'
</script>
