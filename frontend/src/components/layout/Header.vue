<template>
  <header class="bg-white border-b border-gray-200 sticky top-0 z-50">
    <div class="max-w-content mx-auto px-6 py-4 flex items-center justify-between">
      <!-- Logo -->
      <router-link to="/" class="flex items-center">
        <img 
          src="/logo.png" 
          alt="Prem-Lichtwerbung" 
          class="h-8 md:h-10"
        />
      </router-link>

      <!-- Desktop Navigation -->
      <nav class="hidden lg:flex items-center gap-8">
        <router-link to="/about" class="text-gray-700 hover:text-primary transition-colors font-medium">{{ t('nav.about') }}</router-link>
        <router-link to="/products" class="text-gray-700 hover:text-primary transition-colors font-medium">{{ t('nav.products') }}</router-link>
        <router-link to="/terminal-demo" class="text-gray-700 hover:text-primary transition-colors font-medium">Terminal</router-link>
        <router-link to="/contact" class="text-gray-700 hover:text-primary transition-colors font-medium">{{ t('nav.contact') }}</router-link>
        
        <!-- Language Selector -->
        <LanguageSelector />
        
        <!-- Cart Icon with Badge -->
        <router-link to="/cart" class="relative text-gray-700 hover:text-primary transition-colors">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
          </svg>
          <span v-if="itemCount > 0" class="absolute -top-2 -right-2 bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
            {{ itemCount }}
          </span>
        </router-link>
      </nav>

      <!-- Mobile Menu Button -->
      <button
        @click="mobileMenuOpen = !mobileMenuOpen"
        class="lg:hidden w-10 h-10 flex flex-col items-center justify-center gap-1.5 z-50 relative"
        aria-label="Toggle menu"
      >
        <span :class="['w-7 h-0.5 bg-primary transition-all duration-300', mobileMenuOpen ? 'rotate-45 translate-y-2' : '']"></span>
        <span :class="['w-7 h-0.5 bg-primary transition-all duration-300', mobileMenuOpen ? 'opacity-0' : '']"></span>
        <span :class="['w-7 h-0.5 bg-primary transition-all duration-300', mobileMenuOpen ? '-rotate-45 -translate-y-2' : '']"></span>
      </button>
    </div>

    <!-- Mobile Menu -->
    <div :class="['lg:hidden fixed inset-0 bg-white z-40 transform transition-transform duration-300', mobileMenuOpen ? 'translate-x-0' : 'translate-x-full']">
      <nav class="flex flex-col h-full pt-24 px-8">
        <router-link to="/about" @click="mobileMenuOpen = false" class="text-2xl font-bold py-4 border-b border-gray-200 hover:text-primary transition-colors">{{ t('nav.about') }}</router-link>
        <router-link to="/products" @click="mobileMenuOpen = false" class="text-2xl font-bold py-4 border-b border-gray-200 hover:text-primary transition-colors">{{ t('nav.products') }}</router-link>
        <router-link to="/terminal-demo" @click="mobileMenuOpen = false" class="text-2xl font-bold py-4 border-b border-gray-200 hover:text-primary transition-colors">Terminal</router-link>
        <router-link to="/contact" @click="mobileMenuOpen = false" class="text-2xl font-bold py-4 border-b border-gray-200 hover:text-primary transition-colors">{{ t('nav.contact') }}</router-link>
        <router-link to="/cart" @click="mobileMenuOpen = false" class="text-2xl font-bold py-4 border-b border-gray-200 hover:text-primary transition-colors flex items-center gap-3">
          {{ t('nav.cart') }}
          <span v-if="itemCount > 0" class="bg-primary text-white text-sm font-bold rounded-full w-7 h-7 flex items-center justify-center">
            {{ itemCount }}
          </span>
        </router-link>
        
        <!-- Language Selector in Mobile Menu -->
        <div class="py-4 border-b border-gray-200">
          <LanguageSelector />
        </div>
      </nav>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { useCart } from '@/composables/useCart'
import LanguageSelector from '@/components/ui/LanguageSelector.vue'

const { t } = useI18n()
const mobileMenuOpen = ref(false)
const { itemCount } = useCart()
</script>
