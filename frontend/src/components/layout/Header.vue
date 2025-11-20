<template>
  <header class="bg-surface/95 backdrop-blur-sm text-text-main sticky top-0 z-50 border-b border-primary/20">
    <div class="container mx-auto px-6">
      <div class="flex items-center justify-between h-20">
        
        <!-- Logo -->
        <router-link to="/" class="flex items-center gap-3 group cursor-pointer">
          <div class="w-12 h-12 bg-primary rounded-full flex items-center justify-center group-hover:scale-105 transition-transform duration-300">
            <span class="text-2xl">💡</span>
          </div>
          <div>
            <div class="text-2xl font-heading font-bold text-primary group-hover:text-accent transition-all">
              Prem-Lichtwerbung
            </div>
            <div class="text-xs text-text-muted">{{ t('header.tagline') }}</div>
          </div>
        </router-link>
        
        <!-- Desktop Navigation -->
        <nav class="hidden md:flex items-center gap-8">
          <router-link 
            to="/" 
            class="text-text-main hover:text-primary transition-colors font-medium relative group cursor-pointer"
            active-class="text-primary"
          >
            {{ t('nav.home') }}
            <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
          </router-link>
          <router-link 
            to="/products" 
            class="text-text-main hover:text-primary transition-colors font-medium relative group cursor-pointer"
            active-class="text-primary"
          >
            {{ t('nav.products') }}
            <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
          </router-link>
          <router-link 
            to="/portfolio" 
            class="text-text-main hover:text-primary transition-colors font-medium relative group cursor-pointer"
            active-class="text-primary"
          >
            {{ t('nav.portfolio') }}
            <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
          </router-link>
          <router-link 
            to="/about" 
            class="text-text-main hover:text-primary transition-colors font-medium relative group cursor-pointer"
            active-class="text-primary"
          >
            {{ t('nav.about') }}
            <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
          </router-link>
          <router-link 
            to="/contact" 
            class="text-text-main hover:text-primary transition-colors font-medium relative group cursor-pointer"
            active-class="text-primary"
          >
            {{ t('nav.contact') }}
            <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
          </router-link>
        </nav>
        
        <!-- Actions -->
        <div class="flex items-center gap-4">
          <!-- Language Switcher -->
          <LanguageSwitcher />
          
          <router-link 
            to="/cart"
            class="relative p-2 hover:bg-primary/10 rounded-lg transition-colors group cursor-pointer"
          >
            <span class="text-2xl group-hover:scale-110 transition-transform inline-block">🛒</span>
            <span class="absolute -top-1 -right-1 w-5 h-5 bg-accent rounded-full text-xs font-bold flex items-center justify-center text-background">
              0
            </span>
          </router-link>
          
          <button 
            @click="$router.push('/contact')"
            class="px-6 py-2 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary hidden md:block cursor-pointer"
          >
            {{ t('header.getQuote') }}
          </button>
          
          <!-- Mobile menu button -->
          <button 
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="md:hidden p-2 hover:bg-primary/10 rounded-lg transition-colors cursor-pointer"
          >
            <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
            </svg>
          </button>
        </div>
        
      </div>
    </div>
    
    <!-- Mobile Menu -->
    <div 
      v-if="mobileMenuOpen"
      class="md:hidden bg-surface border-t border-primary/20 py-4"
    >
      <nav class="container mx-auto px-6 flex flex-col gap-4">
        <router-link to="/" class="text-text-main hover:text-primary transition-colors font-medium py-2 cursor-pointer" @click="mobileMenuOpen = false">
          {{ t('nav.home') }}
        </router-link>
        <router-link to="/products" class="text-text-main hover:text-primary transition-colors font-medium py-2 cursor-pointer" @click="mobileMenuOpen = false">
          {{ t('nav.products') }}
        </router-link>
        <router-link to="/portfolio" class="text-text-main hover:text-primary transition-colors font-medium py-2 cursor-pointer" @click="mobileMenuOpen = false">
          {{ t('nav.portfolio') }}
        </router-link>
        <router-link to="/about" class="text-text-main hover:text-primary transition-colors font-medium py-2 cursor-pointer" @click="mobileMenuOpen = false">
          {{ t('nav.about') }}
        </router-link>
        <router-link to="/contact" class="text-text-main hover:text-primary transition-colors font-medium py-2 cursor-pointer" @click="mobileMenuOpen = false">
          {{ t('nav.contact') }}
        </router-link>
        <button 
          @click="$router.push('/contact'); mobileMenuOpen = false"
          class="px-6 py-3 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all text-center border-2 border-primary cursor-pointer"
        >
          {{ t('header.getQuote') }}
        </button>
      </nav>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import LanguageSwitcher from '@/components/ui/LanguageSwitcher.vue'

const { t } = useI18n()
const mobileMenuOpen = ref(false)
</script>
