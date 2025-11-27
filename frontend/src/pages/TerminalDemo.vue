<template>
  <div class="terminal-demo-page bg-white">
    <!-- HERO SECTION -->
    <section class="bg-dark-bg text-white relative overflow-hidden">
      <div class="max-w-content mx-auto px-6 py-32 md:py-40">
        <div class="text-center">
          <h1 class="text-6xl md:text-7xl font-bold mb-8">{{ content?.hero?.title }}</h1>
          <p class="text-xl md:text-2xl font-light max-w-3xl mx-auto mb-12">
            {{ content?.hero?.subtitle }}
          </p>
          <div class="flex gap-6 justify-center flex-wrap">
            <a href="#demo" class="px-12 py-4 bg-primary text-white border-2 border-primary hover:bg-primary-dark transition-all duration-500 font-medium cursor-pointer">
              {{ content?.hero?.tryDemo }}
            </a>
            <router-link to="/contact" class="px-12 py-4 bg-transparent text-white border-2 border-white hover:bg-white hover:text-dark-bg transition-all duration-500 font-medium cursor-pointer">
              {{ content?.hero?.requestQuote }}
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- LIVE DEMO SECTION -->
    <section id="demo" class="py-20 bg-dark-bg">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-4xl md:text-5xl font-bold text-white mb-8 leading-tight">
          {{ content?.liveDemo?.title }}
        </h2>
        <p class="text-white/80 text-lg mb-12 max-w-2xl leading-relaxed">
          {{ content?.liveDemo?.subtitle }}
        </p>
        
        <!-- Language Selector for Terminal -->
        <div class="flex justify-start mb-8">
          <LanguageSwitcher />
        </div>
        
        <div class="terminal-demo-wrapper flex justify-center">
          <POSTerminal />
        </div>
      </div>
    </section>

    <!-- FEATURES SECTION -->
    <section class="py-20 bg-white">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-12 leading-tight">
          {{ content?.features?.title }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-12 gap-y-16">
          <div v-for="feature in features" :key="feature.icon" class="feature-card py-8 border-b border-gray-200 hover:border-primary transition-all duration-500">
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight">{{ feature.title }}</h3>
            <p class="text-gray-700 text-base leading-relaxed">{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- TECHNICAL SPECIFICATIONS -->
    <section class="py-20 bg-light-bg">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-6"></div>
        <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-16 leading-tight">
          {{ content?.specs?.title }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-5xl">
          <div 
            v-for="(spec, index) in specifications" 
            :key="index" 
            class="group"
          >
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">
              {{ spec.label }}
            </h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">
              {{ spec.value }}
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- PRICING SECTION -->
    <section class="py-20 bg-light-bg">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-12 leading-tight">
          {{ content?.pricing?.title }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
          <div v-for="plan in pricingPlans" :key="plan.size" class="pricing-card p-12 border border-gray-200 hover:border-primary transition-all duration-500 text-center" :class="{ 'bg-primary text-white': plan.popular }">
            <div v-if="plan.popular" class="text-white font-semibold text-sm mb-4 uppercase tracking-wider">{{ content?.pricing?.popular }}</div>
            <h3 class="text-3xl font-bold mb-6" :class="plan.popular ? 'text-white' : 'text-gray-900'">{{ plan.size }}</h3>
            <div class="text-5xl font-black mb-4" :class="plan.popular ? 'text-white' : 'text-gray-900'">€{{ plan.price.toLocaleString() }}</div>
            <p class="text-base mb-12" :class="plan.popular ? 'text-white/80' : 'text-gray-700'">{{ plan.description }}</p>
            <ul class="text-left mb-12 space-y-4">
              <li v-for="feature in plan.features" :key="feature" class="flex items-start">
                <span class="mr-3" :class="plan.popular ? 'text-white' : 'text-gray-900'">—</span>
                <span :class="plan.popular ? 'text-white/80' : 'text-gray-700'">{{ feature }}</span>
              </li>
            </ul>
            <router-link to="/contact" class="inline-block px-12 py-4 text-base font-medium border-2 transition-all duration-500 cursor-pointer w-full text-center" :class="plan.popular ? 'bg-white text-primary border-white hover:bg-transparent hover:text-white' : 'bg-primary text-white border-primary hover:bg-primary-dark'">
              {{ content?.pricing?.getStarted }}
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA SECTION -->
    <section class="py-20 bg-dark-bg">
      <div class="max-w-content mx-auto px-6 text-center">
        <h2 class="text-5xl md:text-6xl font-bold text-white mb-8 leading-tight">
          {{ content?.cta?.title }}
        </h2>
        <p class="text-xl text-white/80 font-light mb-16 max-w-2xl mx-auto leading-relaxed">
          {{ content?.cta?.subtitle }}
        </p>
        <div class="flex gap-6 justify-center flex-wrap">
          <router-link to="/contact" class="px-16 py-6 bg-white text-black text-lg font-semibold border-2 border-white hover:bg-black hover:text-white transition-all duration-500 cursor-pointer">
            {{ content?.cta?.contactSales }}
          </router-link>
          <router-link to="/products/pos-terminal-gas-station" class="px-16 py-6 bg-transparent text-white text-lg font-semibold border-2 border-white hover:bg-white hover:text-black transition-all duration-500 cursor-pointer">
            {{ content?.cta?.viewProduct }}
          </router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { usePageContent } from '@/composables/usePageContent'
import POSTerminal from '@/components/terminal/POSTerminal.vue'
import LanguageSwitcher from '@/components/ui/LanguageSwitcher.vue'

const { content, loading, error } = usePageContent('terminal')

const features = computed(() => {
  if (!content.value?.features) return []
  return [
    { icon: '🖥️', ...content.value.features.touchscreen },
    { icon: '⛽', ...content.value.features.pumpManagement },
    { icon: '💳', ...content.value.features.payments },
    { icon: '🛒', ...content.value.features.upselling },
    { icon: '🌐', ...content.value.features.multilingual },
    { icon: '🔒', ...content.value.features.weatherproof },
    { icon: '📊', ...content.value.features.analytics },
    { icon: '🔌', ...content.value.features.offline },
    { icon: '🕐', ...content.value.features.support }
  ]
})

const specifications = computed(() => {
  if (!content.value?.specs) return []
  return [
    { label: content.value.specs.screens, value: content.value.specs.screensValue },
    { label: content.value.specs.display, value: content.value.specs.displayValue },
    { label: content.value.specs.enclosure, value: content.value.specs.enclosureValue },
    { label: content.value.specs.rating, value: content.value.specs.ratingValue },
    { label: content.value.specs.power, value: content.value.specs.powerValue },
    { label: content.value.specs.dimensions, value: content.value.specs.dimensionsValue },
    { label: content.value.specs.mounting, value: content.value.specs.mountingValue },
    { label: content.value.specs.languages, value: content.value.specs.languagesValue },
    { label: content.value.specs.warranty, value: content.value.specs.warrantyValue },
    { label: content.value.specs.leadTime, value: content.value.specs.leadTimeValue }
  ]
})

const pricingPlans = computed(() => {
  if (!content.value?.pricing) return []
  return [
    {
      size: content.value.pricing.basic.size,
      price: content.value.pricing.basic.price,
      description: content.value.pricing.basic.description,
      popular: false,
      features: [
        content.value.pricing.basic.feature1,
        content.value.pricing.basic.feature2,
        content.value.pricing.basic.feature3,
        content.value.pricing.basic.feature4,
        content.value.pricing.basic.feature5
      ]
    },
    {
      size: content.value.pricing.professional.size,
      price: content.value.pricing.professional.price,
      description: content.value.pricing.professional.description,
      popular: true,
      features: [
        content.value.pricing.professional.feature1,
        content.value.pricing.professional.feature2,
        content.value.pricing.professional.feature3,
        content.value.pricing.professional.feature4,
        content.value.pricing.professional.feature5,
        content.value.pricing.professional.feature6
      ]
    },
    {
      size: content.value.pricing.enterprise.size,
      price: content.value.pricing.enterprise.price,
      description: content.value.pricing.enterprise.description,
      popular: false,
      features: [
        content.value.pricing.enterprise.feature1,
        content.value.pricing.enterprise.feature2,
        content.value.pricing.enterprise.feature3,
        content.value.pricing.enterprise.feature4,
        content.value.pricing.enterprise.feature5,
        content.value.pricing.enterprise.feature6,
        content.value.pricing.enterprise.feature7
      ]
    }
  ]
})
</script>

<style scoped>
/* Omnicom Minimal Terminal Demo Page - Pure Black/White Aesthetic */
.terminal-demo-page {
  min-height: 100vh;
  background: #FFFFFF;
}

/* Terminal Demo Wrapper - Overflow Handling for Content Cutoff Fix */
.terminal-demo-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  overflow-y: auto;
  max-height: 800px;
}

/* Feature Cards - Minimal Border Hover */
.feature-card {
  transition: border-color 0.5s cubic-bezier(0.4, 0.0, 0.2, 1);
}

/* Pricing Cards - Minimal Transitions */
.pricing-card {
  transition: all 0.5s cubic-bezier(0.4, 0.0, 0.2, 1);
}

/* Responsive - Mobile Optimization */
@media (max-width: 768px) {
  .terminal-demo-wrapper {
    max-height: 600px;
  }
}
</style>
