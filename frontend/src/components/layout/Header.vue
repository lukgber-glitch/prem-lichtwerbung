<template>
  <header class="bg-white text-black fixed top-0 left-0 right-0 z-50 border-b border-black/10">
    <div class="max-w-content mx-auto px-6 md:px-32">
      <div class="flex items-center justify-between h-24">
        
        <!-- Logo - Text Only -->
        <router-link to="/" class="font-heading text-xl font-bold text-black hover:text-black/70 transition-all duration-500 cursor-pointer">
          Prem-Lichtwerbung
        </router-link>
        
        <!-- Desktop Navigation - 4 Core Links -->
        <nav class="hidden md:flex items-center gap-12">
          <router-link 
            to="/about" 
            class="text-black font-light text-base relative group cursor-pointer transition-all duration-500"
          >
            Story
            <span class="absolute bottom-0 left-0 w-0 h-px bg-black group-hover:w-full transition-all duration-500"></span>
          </router-link>
          <router-link 
            to="/products" 
            class="text-black font-light text-base relative group cursor-pointer transition-all duration-500"
          >
            Work
            <span class="absolute bottom-0 left-0 w-0 h-px bg-black group-hover:w-full transition-all duration-500"></span>
          </router-link>
          <router-link 
            to="/terminal-demo" 
            class="text-black font-light text-base relative group cursor-pointer transition-all duration-500"
          >
            Terminal
            <span class="absolute bottom-0 left-0 w-0 h-px bg-black group-hover:w-full transition-all duration-500"></span>
          </router-link>
          <router-link 
            to="/contact" 
            class="text-black font-light text-base relative group cursor-pointer transition-all duration-500"
          >
            Contact
            <span class="absolute bottom-0 left-0 w-0 h-px bg-black group-hover:w-full transition-all duration-500"></span>
          </router-link>
        </nav>
        
        <!-- Actions -->
        <div class="flex items-center gap-6">
          <!-- Language Switcher -->
          <LanguageSwitcher />
          
          <!-- Mobile menu button -->
          <button 
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="md:hidden p-2 cursor-pointer"
          >
            <Menu :size="24" :stroke-width="1.5" class="text-black" />
          </button>
        </div>
        
      </div>
    </div>
    
    <!-- Mobile Menu -->
    <div 
      v-if="mobileMenuOpen"
      class="md:hidden bg-white border-t border-black/10 py-8"
    >
      <nav class="max-w-content mx-auto px-6 flex flex-col gap-6">
        <router-link to="/about" class="text-black font-light text-lg py-2 cursor-pointer" @click="mobileMenuOpen = false">
          Story
        </router-link>
        <router-link to="/products" class="text-black font-light text-lg py-2 cursor-pointer" @click="mobileMenuOpen = false">
          Work
        </router-link>
        <router-link to="/terminal-demo" class="text-black font-light text-lg py-2 cursor-pointer" @click="mobileMenuOpen = false">
          Terminal
        </router-link>
        <router-link to="/contact" class="text-black font-light text-lg py-2 cursor-pointer" @click="mobileMenuOpen = false">
          Contact
        </router-link>
      </nav>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Menu } from 'lucide-vue-next'
import LanguageSwitcher from '@/components/ui/LanguageSwitcher.vue'

const mobileMenuOpen = ref(false)
</script>
