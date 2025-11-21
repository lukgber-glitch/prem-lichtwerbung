<template>
  <div class="terminal-demo-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="container mx-auto px-4 py-16 text-center">
        <h1 class="text-5xl font-bold mb-6 bg-gradient-to-r from-blue-600 to-cyan-500 bg-clip-text text-transparent">
          {{ $t('terminalDemo.title') }}
        </h1>
        <p class="text-xl text-gray-600 dark:text-gray-300 mb-8 max-w-3xl mx-auto">
          {{ $t('terminalDemo.subtitle') }}
        </p>
        <div class="flex gap-4 justify-center flex-wrap">
          <a href="#demo" class="btn btn-primary btn-lg">
            {{ $t('terminalDemo.tryDemo') }}
          </a>
          <router-link to="/contact" class="btn btn-outline btn-lg">
            {{ $t('terminalDemo.requestQuote') }}
          </router-link>
        </div>
      </div>
    </section>

    <!-- Live Demo Section -->
    <section id="demo" class="demo-section py-16 bg-gray-50 dark:bg-gray-900">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold text-center mb-4">
          {{ $t('terminalDemo.liveDemoTitle') }}
        </h2>
        <p class="text-center text-gray-600 dark:text-gray-300 mb-12 max-w-2xl mx-auto">
          {{ $t('terminalDemo.liveDemoSubtitle') }}
        </p>
        
        <div class="terminal-demo-wrapper flex justify-center">
          <POSTerminal />
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features-section py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold text-center mb-12">
          {{ $t('terminalDemo.featuresTitle') }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div v-for="feature in features" :key="feature.icon" class="feature-card p-6 bg-white dark:bg-gray-800 rounded-lg shadow-md hover:shadow-xl transition-shadow">
            <div class="text-4xl mb-4">{{ feature.icon }}</div>
            <h3 class="text-xl font-bold mb-2">{{ $t(feature.title) }}</h3>
            <p class="text-gray-600 dark:text-gray-300">{{ $t(feature.description) }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Technical Specifications -->
    <section class="specs-section py-16 bg-gray-50 dark:bg-gray-900">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold text-center mb-12">
          {{ $t('terminalDemo.specsTitle') }}
        </h2>
        <div class="max-w-4xl mx-auto bg-white dark:bg-gray-800 rounded-lg shadow-lg overflow-hidden">
          <table class="w-full">
            <tbody>
              <tr v-for="(spec, index) in specifications" :key="index" class="border-b dark:border-gray-700">
                <td class="px-6 py-4 font-semibold text-gray-700 dark:text-gray-300">
                  {{ $t(spec.label) }}
                </td>
                <td class="px-6 py-4 text-gray-600 dark:text-gray-400">
                  {{ $t(spec.value) }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section class="pricing-section py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold text-center mb-12">
          {{ $t('terminalDemo.pricingTitle') }}
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
          <div v-for="plan in pricingPlans" :key="plan.size" class="pricing-card p-8 bg-white dark:bg-gray-800 rounded-lg shadow-lg hover:shadow-xl transition-shadow text-center" :class="{ 'ring-2 ring-blue-500': plan.popular }">
            <div v-if="plan.popular" class="text-blue-600 font-bold text-sm mb-2 uppercase">{{ $t('terminalDemo.popular') }}</div>
            <h3 class="text-2xl font-bold mb-4">{{ $t(plan.size) }}</h3>
            <div class="text-4xl font-bold mb-2">€{{ plan.price.toLocaleString() }}</div>
            <p class="text-gray-500 dark:text-gray-400 mb-6">{{ $t(plan.description) }}</p>
            <ul class="text-left mb-8 space-y-2">
              <li v-for="feature in plan.features" :key="feature" class="flex items-start">
                <span class="text-green-500 mr-2">✓</span>
                <span class="text-gray-600 dark:text-gray-300">{{ $t(feature) }}</span>
              </li>
            </ul>
            <router-link to="/contact" class="btn btn-primary w-full">
              {{ $t('terminalDemo.getStarted') }}
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section py-16 bg-gradient-to-r from-blue-600 to-cyan-500 text-white">
      <div class="container mx-auto px-4 text-center">
        <h2 class="text-4xl font-bold mb-6">
          {{ $t('terminalDemo.ctaTitle') }}
        </h2>
        <p class="text-xl mb-8 max-w-2xl mx-auto">
          {{ $t('terminalDemo.ctaSubtitle') }}
        </p>
        <div class="flex gap-4 justify-center flex-wrap">
          <router-link to="/contact" class="btn bg-white text-blue-600 hover:bg-gray-100 btn-lg">
            {{ $t('terminalDemo.contactSales') }}
          </router-link>
          <router-link to="/products/pos-terminal-gas-station" class="btn btn-outline border-white text-white hover:bg-white hover:text-blue-600 btn-lg">
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
.terminal-demo-page {
  min-height: 100vh;
}

.hero-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 4rem 0;
}

.hero-section h1 {
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.terminal-demo-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 100%);
  border-radius: 1rem;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.feature-card {
  transition: transform 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-5px);
}

.pricing-card {
  transition: transform 0.3s ease;
}

.pricing-card:hover {
  transform: translateY(-5px);
}

.btn {
  padding: 0.75rem 2rem;
  border-radius: 0.5rem;
  font-weight: 600;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn-primary:hover {
  box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
}

.btn-outline {
  border: 2px solid currentColor;
  background: transparent;
}

.btn-outline:hover {
  background: currentColor;
  color: white;
}

.btn-lg {
  padding: 1rem 2.5rem;
  font-size: 1.125rem;
}

table td {
  border-bottom: 1px solid;
}
</style>
