<template>
  <div class="min-h-screen bg-omnicom-bg page-home">
    
    <!-- HERO SECTION - Omnicom Minimal with Gradient -->
    <section class="relative min-h-screen flex items-center justify-center bg-gradient-to-b from-omnicom-black to-omnicom-black overflow-hidden">
      <div class="noise-texture"></div>
      <div class="max-w-content mx-auto px-6 text-center hero-content">
        <h1 class="text-8xl md:text-10xl font-black text-omnicom-text-light leading-none tracking-[-0.04em] mb-12">
          Your Brand<br>Deserves to Shine
        </h1>
        <p class="text-xl md:text-2xl text-omnicom-text-light/60 font-light max-w-2xl mx-auto mb-16">
          Premium illuminated signage that transforms businesses into landmarks
        </p>
        <ButtonGlow 
          variant="primary" 
          :use-page-accent="true" 
          class="mt-2"
          @click="$router.push('/products')"
        >
          Explore Our Work
        </ButtonGlow>
      </div>
    </section>
    
    <!-- ABOUT SECTION - Omnicom Narrative with Accent Line -->
    <section class="py-32 bg-omnicom-bg-alt">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <div class="grid md:grid-cols-2 gap-32 items-center">
          <!-- Left: Floating Text (40% of space) -->
          <div>
            <!-- Decorative Accent Line -->
            <OmnicomAccentLine size="md" class="mb-8" />
            
            <!-- Section Label -->
            <p class="text-xs uppercase tracking-[0.2em] font-semibold text-omnicom-muted mb-6">Our Story</p>
            
            <h2 class="text-5xl md:text-6xl font-heading font-bold text-omnicom-text mb-12 leading-tight">
              15 Years of Illumination Excellence
            </h2>
            <p class="text-lg md:text-xl text-omnicom-muted font-light leading-relaxed max-w-text">
              Since our founding, we've transformed ordinary facades into extraordinary brand experiences. Our craft combines precision engineering with artistic vision, delivering illuminated signage that doesn't just light up buildings—it defines them. Every project reflects our commitment to quality, innovation, and the belief that your brand deserves nothing less than brilliance.
            </p>
          </div>
          <!-- Right: Empty Space (60% whitespace) -->
          <div></div>
        </div>
      </div>
    </section>
    
    <!-- SERVICES SECTION - Omnicom Minimal Grid -->
    <section class="relative py-60 bg-omnicom-black overflow-hidden">
      <div class="noise-texture"></div>
      <div class="max-w-content mx-auto px-6 md:px-32">
        
        <!-- Section Header -->
        <div class="mb-20">
          <OmnicomAccentLine size="md" class="mb-8" custom-color="#FFFFFF" />
          <p class="text-xs uppercase tracking-[0.2em] font-semibold text-omnicom-text-light/60 mb-6">What We Do</p>
          <h2 class="text-5xl md:text-6xl font-heading font-bold text-omnicom-text-light leading-tight">Our Services</h2>
        </div>
        
        <div class="grid md:grid-cols-3 gap-20">
          <div 
            v-for="service in services" 
            :key="service"
            class="group cursor-pointer py-12 border-b border-omnicom-white/20 hover:border-omnicom-white transition-all duration-800"
            @click="$router.push('/products')"
          >
            <h3 class="font-heading text-4xl md:text-5xl font-bold text-omnicom-text-light group-hover:text-omnicom-text-light/80 transition-all duration-500">
              {{ service }}
            </h3>
          </div>
        </div>
      </div>
    </section>
    
    <!-- CTA SECTION - Omnicom Dramatic -->
    <section class="relative py-60 bg-omnicom-black overflow-hidden">
      <div class="noise-texture"></div>
      <div class="max-w-content mx-auto px-6 md:px-32 text-center">
        <h2 class="text-6xl md:text-8xl font-heading font-black text-omnicom-text-light mb-16 leading-none tracking-[-0.02em]">
          Let's Create Something<br>Extraordinary
        </h2>
        <p class="text-xl text-omnicom-text-light/70 font-light mb-12">
          contact@prem-lichtwerbung.de
        </p>
        <ButtonGlow 
          variant="secondary" 
          :use-page-accent="true" 
          @click="$router.push('/contact')"
        >
          Start Project
        </ButtonGlow>
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import OmnicomAccentLine from '@/components/ui/OmnicomAccentLine.vue'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import { useScrollAnimation } from '@/composables/useScrollAnimation'

const router = useRouter()
const { animateOnScroll, fadeInHero } = useScrollAnimation()

// Omnicom Minimal Services
const services = [
  'Lightboxes',
  'Channel Letters',
  'Neon',
  'Pylons',
  'Windows',
  'Terminal'
]

onMounted(() => {
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  if (reduce) return
  fadeInHero()
  animateOnScroll('.accent-line', { y: 40, duration: 0.8, ease: 'power3.out' })
  animateOnScroll('h1', { y: 40, duration: 1.0 })
  animateOnScroll('h2', { y: 40, duration: 0.9 })
  animateOnScroll('p', { y: 30, duration: 0.8 })
  animateOnScroll('button', { y: 20, duration: 0.7 })
})
</script>
