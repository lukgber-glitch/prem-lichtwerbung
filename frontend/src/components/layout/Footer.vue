<template>
  <footer class="bg-omnicom-bg border-t border-omnicom-gray-300/25 mt-auto">
    <div class="max-w-content mx-auto px-6 md:px-32">
      <div class="flex flex-col md:flex-row items-center justify-between py-6 md:h-20 gap-4">
        
        <!-- Copyright Left -->
        <div class="text-sm font-light text-omnicom-muted">
          &copy; {{ new Date().getFullYear() }} Prem-Lichtwerbung
        </div>
        
        <!-- Social Icons Center -->
        <div class="flex items-center gap-6">
          <a 
            href="#" 
            class="text-omnicom-muted hover:accent-text transition-colors duration-300 cursor-pointer" 
            aria-label="Facebook"
          >
            <Facebook :size="20" :stroke-width="1.5" />
          </a>
          <a 
            href="#" 
            class="text-omnicom-muted hover:accent-text transition-colors duration-300 cursor-pointer" 
            aria-label="Instagram"
          >
            <Instagram :size="20" :stroke-width="1.5" />
          </a>
          <a 
            href="#" 
            class="text-omnicom-muted hover:accent-text transition-colors duration-300 cursor-pointer" 
            aria-label="Twitter"
          >
            <Twitter :size="20" :stroke-width="1.5" />
          </a>
        </div>
        
        <!-- Email Contact Right -->
        <div class="text-sm font-light text-omnicom-muted">
          contact@prem-lichtwerbung.de
        </div>
        
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { Facebook, Instagram, Twitter } from 'lucide-vue-next'
</script>
