<template>
  <div class="terminal-demo-page bg-white">
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-white overflow-hidden px-6">
      <div class="max-w-content mx-auto text-center">
        <h1 class="text-7xl md:text-9xl font-heading font-black text-black leading-none tracking-tighter mb-16">
          {{ $t('terminalDemo.title') }}
        </h1>
        <p class="text-xl md:text-2xl text-black font-light max-w-2xl mx-auto leading-relaxed mb-16">
          {{ $t('terminalDemo.subtitle') }}
        </p>
        <div class="flex gap-6 justify-center flex-wrap">
          <a href="#demo" class="px-16 py-6 bg-black text-white text-lg font-semibold border-2 border-black hover:bg-white hover:text-black transition-all duration-500 cursor-pointer">
            {{ $t('terminalDemo.tryDemo') }}
          </a>
          <router-link to="/contact" class="px-16 py-6 bg-transparent text-black text-lg font-semibold border-2 border-black hover:bg-black hover:text-white transition-all duration-500 cursor-pointer">
            {{ $t('terminalDemo.requestQuote') }}
          </router-link>
        </div>
      </div>
    </section>

    <!-- LIVE DEMO SECTION - Omnicom Black Background -->
    <section id="demo" class="py-44 bg-black">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <h2 class="text-5xl md:text-6xl font-heading font-bold text-white text-center mb-12 leading-tight">
          {{ $t('terminalDemo.liveDemoTitle') }}
        </h2>
        <p class="text-center text-white/80 font-light text-lg mb-20 max-w-2xl mx-auto leading-relaxed">
          {{ $t('terminalDemo.liveDemoSubtitle') }}
        </p>
        
        <!-- Language Selector for Terminal -->
        <div class="flex justify-center mb-8">
          <LanguageSwitcher />
        </div>
        
        <div class="terminal-demo-wrapper flex justify-center">
          <POSTerminal />
        </div>
      </div>
    </section>

    <!-- FEATURES SECTION - Omnicom Minimal Grid -->
    <section class="py-44 bg-white">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <h2 class="text-5xl md:text-6xl font-heading font-bold text-black text-center mb-20 leading-tight">
          {{ $t('terminalDemo.featuresTitle') }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-12 gap-y-16">
          <div v-for="feature in features" :key="feature.icon" class="feature-card py-8 border-b border-black/10 hover:border-black transition-all duration-500">
            <h3 class="text-2xl font-heading font-semibold text-black mb-4 leading-tight">{{ $t(feature.title) }}</h3>
            <p class="text-black/60 font-light text-base leading-relaxed">{{ $t(feature.description) }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- TECHNICAL SPECIFICATIONS - Omnicom Minimal Table -->
    <section class="py-44 bg-black">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <h2 class="text-5xl md:text-6xl font-heading font-bold text-white text-center mb-20 leading-tight">
          {{ $t('terminalDemo.specsTitle') }}
        </h2>
        <div class="max-w-4xl mx-auto bg-white border border-black overflow-hidden">
          <table class="w-full">
            <tbody>
              <tr v-for="(spec, index) in specifications" :key="index" class="border-b border-black/10 last:border-b-0">
                <td class="px-8 py-6 font-semibold text-black font-light">
                  {{ $t(spec.label) }}
                </td>
                <td class="px-8 py-6 text-black/60 font-light">
                  {{ $t(spec.value) }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <!-- PRICING SECTION - Omnicom Minimal Cards -->
    <section class="py-44 bg-white">
      <div class="max-w-content mx-auto px-6 md:px-32">
        <h2 class="text-5xl md:text-6xl font-heading font-bold text-black text-center mb-20 leading-tight">
          {{ $t('terminalDemo.pricingTitle') }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12 max-w-6xl mx-auto">
          <div v-for="plan in pricingPlans" :key="plan.size" class="pricing-card p-12 border border-black/10 hover:border-black transition-all duration-500 text-center" :class="{ 'bg-black text-white': plan.popular }">
            <div v-if="plan.popular" class="text-white font-semibold text-sm mb-4 uppercase tracking-wider">{{ $t('terminalDemo.popular') }}</div>
            <h3 class="text-3xl font-heading font-bold mb-6" :class="plan.popular ? 'text-white' : 'text-black'">{{ $t(plan.size) }}</h3>
            <div class="text-5xl font-black mb-4" :class="plan.popular ? 'text-white' : 'text-black'">€{{ plan.price.toLocaleString() }}</div>
            <p class="font-light text-base mb-12" :class="plan.popular ? 'text-white/60' : 'text-black/60'">{{ $t(plan.description) }}</p>
            <ul class="text-left mb-12 space-y-4">
              <li v-for="feature in plan.features" :key="feature" class="flex items-start">
                <span class="mr-3" :class="plan.popular ? 'text-white' : 'text-black'">—</span>
                <span class="font-light" :class="plan.popular ? 'text-white/80' : 'text-black/60'">{{ $t(feature) }}</span>
              </li>
            </ul>
            <router-link to="/contact" class="inline-block px-12 py-4 text-base font-semibold border-2 transition-all duration-500 cursor-pointer w-full text-center" :class="plan.popular ? 'bg-white text-black border-white hover:bg-transparent hover:text-white' : 'bg-black text-white border-black hover:bg-white hover:text-black'">
              {{ $t('terminalDemo.getStarted') }}
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA SECTION - Omnicom Black Background -->
    <section class="py-44 bg-black">
      <div class="max-w-content mx-auto px-6 md:px-32 text-center">
        <h2 class="text-6xl md:text-8xl font-heading font-black text-white mb-16 leading-none tracking-tight">
          {{ $t('terminalDemo.ctaTitle') }}
        </h2>
        <p class="text-xl text-white/80 font-light mb-16 max-w-2xl mx-auto leading-relaxed">
          {{ $t('terminalDemo.ctaSubtitle') }}
        </p>
        <div class="flex gap-6 justify-center flex-wrap">
          <router-link to="/contact" class="px-16 py-6 bg-white text-black text-lg font-semibold border-2 border-white hover:bg-black hover:text-white transition-all duration-500 cursor-pointer">
            {{ $t('terminalDemo.contactSales') }}
          </router-link>
          <router-link to="/products/pos-terminal-gas-station" class="px-16 py-6 bg-transparent text-white text-lg font-semibold border-2 border-white hover:bg-white hover:text-black transition-all duration-500 cursor-pointer">
            {{ $t('terminalDemo.viewProduct') }}
          </router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import POSTerminal from '@/components/terminal/POSTerminal.vue'
import LanguageSwitcher from '@/components/ui/LanguageSwitcher.vue'

const { t } = useI18n()

const features = [
  {
    icon: '🖥️',
    title: 'terminalDemo.features.touchscreen.title',
    description: 'terminalDemo.features.touchscreen.description'
  },
  {
    icon: '⛽',
    title: 'terminalDemo.features.pumpManagement.title',
    description: 'terminalDemo.features.pumpManagement.description'
  },
  {
    icon: '💳',
    title: 'terminalDemo.features.payments.title',
    description: 'terminalDemo.features.payments.description'
  },
  {
    icon: '🛒',
    title: 'terminalDemo.features.upselling.title',
    description: 'terminalDemo.features.upselling.description'
  },
  {
    icon: '🌐',
    title: 'terminalDemo.features.multilingual.title',
    description: 'terminalDemo.features.multilingual.description'
  },
  {
    icon: '🔒',
    title: 'terminalDemo.features.weatherproof.title',
    description: 'terminalDemo.features.weatherproof.description'
  },
  {
    icon: '📊',
    title: 'terminalDemo.features.analytics.title',
    description: 'terminalDemo.features.analytics.description'
  },
  {
    icon: '🔌',
    title: 'terminalDemo.features.offline.title',
    description: 'terminalDemo.features.offline.description'
  },
  {
    icon: '🕐',
    title: 'terminalDemo.features.support.title',
    description: 'terminalDemo.features.support.description'
  }
]

const specifications = [
  { label: 'terminalDemo.specs.screens', value: 'terminalDemo.specs.screensValue' },
  { label: 'terminalDemo.specs.display', value: 'terminalDemo.specs.displayValue' },
  { label: 'terminalDemo.specs.enclosure', value: 'terminalDemo.specs.enclosureValue' },
  { label: 'terminalDemo.specs.rating', value: 'terminalDemo.specs.ratingValue' },
  { label: 'terminalDemo.specs.power', value: 'terminalDemo.specs.powerValue' },
  { label: 'terminalDemo.specs.dimensions', value: 'terminalDemo.specs.dimensionsValue' },
  { label: 'terminalDemo.specs.mounting', value: 'terminalDemo.specs.mountingValue' },
  { label: 'terminalDemo.specs.languages', value: 'terminalDemo.specs.languagesValue' },
  { label: 'terminalDemo.specs.warranty', value: 'terminalDemo.specs.warrantyValue' },
  { label: 'terminalDemo.specs.leadTime', value: 'terminalDemo.specs.leadTimeValue' }
]

const pricingPlans = [
  {
    size: 'terminalDemo.pricing.basic.size',
    price: 4999,
    description: 'terminalDemo.pricing.basic.description',
    popular: false,
    features: [
      'terminalDemo.pricing.basic.feature1',
      'terminalDemo.pricing.basic.feature2',
      'terminalDemo.pricing.basic.feature3',
      'terminalDemo.pricing.basic.feature4',
      'terminalDemo.pricing.basic.feature5'
    ]
  },
  {
    size: 'terminalDemo.pricing.professional.size',
    price: 6499,
    description: 'terminalDemo.pricing.professional.description',
    popular: true,
    features: [
      'terminalDemo.pricing.professional.feature1',
      'terminalDemo.pricing.professional.feature2',
      'terminalDemo.pricing.professional.feature3',
      'terminalDemo.pricing.professional.feature4',
      'terminalDemo.pricing.professional.feature5',
      'terminalDemo.pricing.professional.feature6'
    ]
  },
  {
    size: 'terminalDemo.pricing.enterprise.size',
    price: 8999,
    description: 'terminalDemo.pricing.enterprise.description',
    popular: false,
    features: [
      'terminalDemo.pricing.enterprise.feature1',
      'terminalDemo.pricing.enterprise.feature2',
      'terminalDemo.pricing.enterprise.feature3',
      'terminalDemo.pricing.enterprise.feature4',
      'terminalDemo.pricing.enterprise.feature5',
      'terminalDemo.pricing.enterprise.feature6',
      'terminalDemo.pricing.enterprise.feature7'
    ]
  }
]
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
