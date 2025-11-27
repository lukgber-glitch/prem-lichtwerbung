<template>
  <div class="min-h-screen bg-white">
    <!-- Hero Section -->
    <section class="bg-dark-bg text-white relative overflow-hidden">
      <div class="max-w-content mx-auto px-6 py-32 md:py-40">
        <div class="text-center">
          <h1 class="text-6xl md:text-7xl font-bold mb-8">{{ t('aboutNew.hero.title') }}</h1>
          <p class="text-xl md:text-2xl font-light max-w-3xl mx-auto">
            {{ t('aboutNew.hero.subtitle') }}
          </p>
        </div>
      </div>
    </section>

    <!-- Narrative Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <div class="w-16 h-1 bg-primary mb-6"></div>
            <h2 class="text-4xl md:text-5xl font-bold mb-8 text-gray-900">
              {{ t('aboutNew.narrative.title') }}
              <br />
              {{ t('aboutNew.narrative.titleLine2') }}
            </h2>
            <p class="text-lg text-gray-700 mb-8 leading-relaxed">
              {{ t('aboutNew.narrative.paragraph1') }}
            </p>
            <p class="text-lg text-gray-700 leading-relaxed">
              {{ t('aboutNew.narrative.paragraph2') }}
            </p>
          </div>
          <div class="grid grid-cols-1 gap-6">
            <div class="overflow-hidden rounded-sm">
              <img
                src="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop"
                alt="Our Work"
                class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
              />
            </div>
            <div class="grid grid-cols-2 gap-6">
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=400&h=400&fit=crop"
                  alt="Team Collaboration"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1553877522-43269d4ea984?w=400&h=400&fit=crop"
                  alt="Workshop"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Philosophy Section -->
    <section class="bg-white py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="flex items-center gap-3 mb-12">
          <h2 class="text-2xl font-bold uppercase tracking-wide">{{ t('aboutNew.values.title') }}</h2>
          <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </div>

        <div class="grid md:grid-cols-2 gap-12">
          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ t('aboutNew.values.quality.title') }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ t('aboutNew.values.quality.description') }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ t('aboutNew.values.custom.title') }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ t('aboutNew.values.custom.description') }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ t('aboutNew.values.turnaround.title') }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ t('aboutNew.values.turnaround.description') }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ t('aboutNew.values.expertise.title') }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ t('aboutNew.values.expertise.description') }}
            </p>
          </article>
        </div>
      </div>
    </section>

    <!-- Capabilities Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-4xl md:text-5xl font-bold mb-12 text-gray-900 leading-tight">{{ t('aboutNew.capabilities.title') }}</h2>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-5xl">
          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ t('aboutNew.capabilities.channelLetters.title') }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ t('aboutNew.capabilities.channelLetters.description') }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ t('aboutNew.capabilities.ledNeon.title') }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ t('aboutNew.capabilities.ledNeon.description') }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ t('aboutNew.capabilities.lightboxes.title') }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ t('aboutNew.capabilities.lightboxes.description') }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ t('aboutNew.capabilities.pylons.title') }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ t('aboutNew.capabilities.pylons.description') }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ t('aboutNew.capabilities.digital.title') }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ t('aboutNew.capabilities.digital.description') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="bg-dark-bg text-white py-20">
      <div class="max-w-content mx-auto px-6 text-center">
        <h2 class="text-5xl md:text-6xl font-bold mb-8 leading-tight">
          {{ t('aboutNew.cta.title') }}<br />{{ t('aboutNew.cta.titleLine2') }}
        </h2>
        <router-link to="/contact" class="inline-block px-12 py-4 border-2 border-white text-white hover:bg-white hover:text-dark-bg transition-all duration-500 font-medium">
          {{ t('aboutNew.cta.button') }}
        </router-link>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'

const router = useRouter()
const { t } = useI18n()
</script>
