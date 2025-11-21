<template>
  <div class="min-h-screen bg-white">
    
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-white overflow-hidden px-6 py-32">
      
      <!-- Hero content -->
      <div class="relative z-10 text-center max-w-content mx-auto">
        
        <!-- Main headline - Massive Bold Typography -->
        <h1 class="text-7xl md:text-9xl font-heading font-black text-black mb-12 leading-none tracking-tighter">
          Your Brand<br>Deserves to Shine
        </h1>
        
        <!-- Minimal subtext - Ultra-light -->
        <p class="text-xl md:text-2xl text-black font-light mb-16 max-w-2xl mx-auto leading-relaxed">
          Premium illuminated signage crafted with precision
        </p>
        
        <!-- Single Ghost Button -->
        <button 
          @click="$router.push('/products')"
          class="px-16 py-6 bg-transparent text-black text-lg font-semibold border-2 border-black hover:bg-black hover:text-white transition-all duration-500 ease-omnicom cursor-pointer"
        >
          Explore Our Work
        </button>
        
      </div>
      
    </section>
    
    <!-- ABOUT SECTION - Omnicom Narrative -->
    <section class="py-44 bg-white">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <div class="grid md:grid-cols-2 gap-32 items-center">
          <!-- Left: Floating Text (40% of space) -->
          <div>
            <h2 class="text-5xl md:text-6xl font-heading font-bold text-black mb-12 leading-tight">
              15 Years of Illumination Excellence
            </h2>
            <p class="text-lg md:text-xl text-black font-light leading-relaxed max-w-text">
              Since our founding, we've transformed ordinary facades into extraordinary brand experiences. Our craft combines precision engineering with artistic vision, delivering illuminated signage that doesn't just light up buildings—it defines them. Every project reflects our commitment to quality, innovation, and the belief that your brand deserves nothing less than brilliance.
            </p>
          </div>
          <!-- Right: Empty Space (60% whitespace) -->
          <div></div>
        </div>
      </div>
    </section>
    
    <!-- SERVICES SECTION - Omnicom Minimal Grid -->
    <section class="py-44 bg-black">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <div class="grid md:grid-cols-3 gap-20">
          <div 
            v-for="service in services" 
            :key="service"
            class="group cursor-pointer py-12 border-b border-white/20 hover:border-white transition-all duration-800"
            @click="$router.push('/products')"
          >
            <h3 class="font-heading text-4xl md:text-5xl font-bold text-white group-hover:text-white/80 transition-all duration-500">
              {{ service }}
            </h3>
          </div>
        </div>
      </div>
    </section>
    
    <!-- CTA SECTION - Omnicom Dramatic -->
    <section class="py-44 bg-black">
      <div class="max-w-content mx-auto px-6 md:px-32 text-center">
        <h2 class="text-6xl md:text-8xl font-heading font-black text-white mb-16 leading-none tracking-tight">
          Let's Create Something<br>Extraordinary
        </h2>
        <p class="text-xl text-white/80 font-light mb-12">
          contact@prem-lichtwerbung.de
        </p>
        <button 
          @click="$router.push('/contact')"
          class="px-16 py-6 bg-transparent text-white text-lg font-semibold border-2 border-white hover:bg-white hover:text-black transition-all duration-500 ease-omnicom cursor-pointer"
        >
          Start Project
        </button>
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

// Omnicom Minimal Services
const services = [
  'Lightboxes',
  'Channel Letters',
  'Neon',
  'Pylons',
  'Windows',
  'Terminal'
]
</script>
