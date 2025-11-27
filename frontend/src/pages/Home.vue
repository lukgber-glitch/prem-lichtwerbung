<template>
  <div class="min-h-screen">
    <!-- Hero Section -->
    <section class="bg-dark-bg text-white relative overflow-hidden">
      <div class="max-w-content mx-auto px-6 py-20 md:py-32">
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <h1 class="text-6xl md:text-7xl font-bold mb-8">{{ t('homeNew.hero.title') }}</h1>
          </div>
          <div class="text-center">
            <!-- Award Badge -->
            <div class="mb-6 flex justify-center">
              <div class="w-48 h-48 md:w-64 md:h-64 rounded-full border-4 border-gold flex items-center justify-center bg-dark-bg/50">
                <div class="text-center">
                  <div class="text-6xl md:text-7xl font-black text-gold mb-2">{{ t('homeNew.hero.award') }}</div>
                  <div class="text-sm md:text-base font-light text-white uppercase tracking-wider">{{ t('homeNew.hero.awardLine1') }}</div>
                  <div class="text-sm md:text-base font-light text-white uppercase tracking-wider">{{ t('homeNew.hero.awardLine2') }}</div>
                </div>
              </div>
            </div>
            <h2 class="text-3xl md:text-4xl font-light mb-2">
              {{ t('homeNew.hero.premierTitle') }}
              <br />
              {{ t('homeNew.hero.premierSubtitle') }} <span class="text-gold">{{ t('homeNew.hero.year') }}</span>
            </h2>
          </div>
        </div>
      </div>

      <!-- Red Banner -->
      <div class="bg-primary py-8 md:py-12">
        <div class="max-w-content mx-auto px-6">
          <h2 class="text-4xl md:text-5xl font-light text-white">
            {{ t('homeNew.hero.bannerTitle') }}
          </h2>
        </div>
      </div>
    </section>

    <!-- Intro Text -->
    <section class="bg-white py-16">
      <div class="max-w-text mx-auto px-6">
        <p class="text-lg md:text-xl text-gray-700 leading-relaxed mb-6">
          {{ t('homeNew.intro.paragraph') }}
        </p>
        <router-link to="/products" class="inline-flex items-center text-primary hover:underline italic">
          {{ t('homeNew.intro.seeProducts') }}
          <svg class="w-5 h-5 ml-2" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </router-link>
      </div>
    </section>

    <!-- Services Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <div class="w-16 h-1 bg-primary mb-6"></div>
            <h2 class="text-4xl md:text-5xl font-bold mb-8 text-gray-900">
              {{ t('homeNew.services.title') }}
              <br />
              {{ t('homeNew.services.titleLine2') }}
            </h2>
            <p class="text-lg text-gray-700 mb-8 leading-relaxed">
              {{ t('homeNew.services.description') }}
            </p>
            <router-link to="/about" class="inline-flex items-center text-primary hover:underline italic">
              {{ t('homeNew.services.learnMore') }}
              <svg class="w-5 h-5 ml-2" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
            </router-link>
          </div>
          <div class="grid grid-cols-1 gap-6">
            <div class="overflow-hidden rounded-sm">
              <img
                src="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop"
                alt="Signage Solutions"
                class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
              />
            </div>
            <div class="grid grid-cols-2 gap-6">
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1565008576549-57569a49371d?w=400&h=400&fit=crop"
                  alt="LED Signage"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=400&fit=crop"
                  alt="Neon Lights"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Projects Section -->
    <section class="bg-white py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="flex items-center gap-3 mb-12">
          <h2 class="text-2xl font-bold uppercase tracking-wide">{{ t('homeNew.projects.title') }}</h2>
          <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </div>

        <div class="grid md:grid-cols-2 gap-12">
          <!-- Main Project -->
          <article class="group cursor-pointer" @click="$router.push('/products')">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-3xl font-bold mb-6 leading-tight text-gray-900 transition-colors duration-300 group-hover:text-primary">
              {{ t('homeNew.projects.mainTitle') }}
            </h3>
            <p class="text-gray-700 mb-6 leading-relaxed">
              {{ t('homeNew.projects.mainDescription') }}
            </p>
            <span class="inline-flex items-center text-primary hover:underline italic">
              {{ t('homeNew.projects.viewProject') }}
              <svg class="w-5 h-5 ml-2 transition-transform duration-300 group-hover:translate-x-1" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
            </span>
          </article>

          <!-- Secondary Projects -->
          <div class="space-y-10">
            <article class="group cursor-pointer" @click="$router.push('/products')">
              <div class="w-16 h-1 bg-primary mb-4 transition-all duration-300 group-hover:w-24"></div>
              <h4 class="text-xl font-bold mb-2 text-gray-900 transition-colors duration-300 group-hover:text-primary">
                {{ t('homeNew.projects.project2') }}
              </h4>
            </article>

            <article class="group cursor-pointer" @click="$router.push('/products')">
              <div class="w-16 h-1 bg-primary mb-4 transition-all duration-300 group-hover:w-24"></div>
              <h4 class="text-xl font-bold mb-2 text-gray-900 transition-colors duration-300 group-hover:text-primary">
                {{ t('homeNew.projects.project3') }}
              </h4>
            </article>
          </div>
        </div>
      </div>
    </section>

    <!-- Expertise Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="flex items-center gap-3 mb-12">
          <h2 class="text-2xl font-bold uppercase tracking-wide">{{ t('homeNew.expertise.title') }}</h2>
          <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </div>

        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <div class="w-16 h-1 bg-primary mb-6"></div>
            <h3 class="text-4xl font-bold mb-6 text-gray-900">{{ t('homeNew.expertise.mainTitle') }}</h3>
            <p class="text-lg text-gray-700 mb-8 leading-relaxed">
              {{ t('homeNew.expertise.description') }}
            </p>
            <router-link to="/about" class="inline-flex items-center text-primary hover:underline italic">
              {{ t('homeNew.expertise.readMore') }}
              <svg class="w-5 h-5 ml-2" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
            </router-link>
          </div>
          <div class="grid grid-cols-1 gap-6">
            <div class="overflow-hidden rounded-sm">
              <img
                src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=800&h=600&fit=crop"
                alt="Expertise"
                class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
              />
            </div>
            <div class="grid grid-cols-2 gap-6">
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1553877522-43269d4ea984?w=400&h=400&fit=crop"
                  alt="Team"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
              <div class="overflow-hidden rounded-sm">
                <img
                  src="https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=400&h=400&fit=crop"
                  alt="Collaboration"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
            </div>
          </div>
        </div>
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
