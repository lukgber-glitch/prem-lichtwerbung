<template>
  <div class="min-h-screen bg-white">
    <!-- Hero Section -->
    <section class="bg-dark-bg text-white relative overflow-hidden">
      <div class="max-w-content mx-auto px-6 py-32 md:py-40">
        <div class="text-center">
          <h1 class="text-6xl md:text-7xl font-bold mb-8">{{ content?.hero?.title }}</h1>
          <p class="text-xl md:text-2xl font-light max-w-3xl mx-auto">
            {{ content?.hero?.subtitle }}
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
              {{ content?.narrative?.title }}
              <br />
              {{ content?.narrative?.titleLine2 }}
            </h2>
            <p class="text-lg text-gray-700 mb-8 leading-relaxed">
              {{ content?.narrative?.paragraph1 }}
            </p>
            <p class="text-lg text-gray-700 leading-relaxed">
              {{ content?.narrative?.paragraph2 }}
            </p>
          </div>
          <div class="grid grid-cols-1 gap-6">
            <div class="overflow-hidden rounded-sm">
              <img
                :src="galleryImages[0]?.url || 'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop'"
                :alt="galleryImages[0]?.title || 'Our Work'"
                class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
              />
            </div>
            <div class="grid grid-cols-2 gap-6">
              <div class="overflow-hidden rounded-sm">
                <img
                  :src="galleryImages[1]?.url || 'https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=400&h=400&fit=crop'"
                  :alt="galleryImages[1]?.title || 'Team Collaboration'"
                  class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
                />
              </div>
              <div class="overflow-hidden rounded-sm">
                <img
                  :src="galleryImages[2]?.url || 'https://images.unsplash.com/photo-1553877522-43269d4ea984?w=400&h=400&fit=crop'"
                  :alt="galleryImages[2]?.title || 'Workshop'"
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
          <h2 class="text-2xl font-bold uppercase tracking-wide">{{ content?.values?.title }}</h2>
          <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </div>

        <div class="grid md:grid-cols-2 gap-12">
          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ content?.values?.quality?.title }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ content?.values?.quality?.description }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ content?.values?.custom?.title }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ content?.values?.custom?.description }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ content?.values?.turnaround?.title }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ content?.values?.turnaround?.description }}
            </p>
          </article>

          <article class="group cursor-pointer">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-300 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold mb-4 text-gray-900 transition-colors duration-300 group-hover:text-primary">{{ content?.values?.expertise?.title }}</h3>
            <p class="text-gray-700 leading-relaxed">
              {{ content?.values?.expertise?.description }}
            </p>
          </article>
        </div>
      </div>
    </section>

    <!-- Capabilities Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="w-16 h-1 bg-primary mb-8"></div>
        <h2 class="text-4xl md:text-5xl font-bold mb-12 text-gray-900 leading-tight">{{ content?.capabilities?.title }}</h2>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-5xl">
          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ content?.capabilities?.channelLetters?.title }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ content?.capabilities?.channelLetters?.description }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ content?.capabilities?.ledNeon?.title }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ content?.capabilities?.ledNeon?.description }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ content?.capabilities?.lightboxes?.title }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ content?.capabilities?.lightboxes?.description }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ content?.capabilities?.pylons?.title }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ content?.capabilities?.pylons?.description }}</p>
          </div>

          <div class="group">
            <div class="w-16 h-1 bg-primary mb-6 transition-all duration-500 group-hover:w-24"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-4 leading-tight transition-colors duration-500 group-hover:text-primary">{{ content?.capabilities?.digital?.title }}</h3>
            <p class="text-lg text-gray-700 font-light leading-relaxed">{{ content?.capabilities?.digital?.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="bg-dark-bg text-white py-20">
      <div class="max-w-content mx-auto px-6 text-center">
        <h2 class="text-5xl md:text-6xl font-bold mb-8 leading-tight">
          {{ content?.cta?.title }}<br />{{ content?.cta?.titleLine2 }}
        </h2>
        <router-link to="/contact" class="inline-block px-12 py-4 border-2 border-white text-white hover:bg-white hover:text-dark-bg transition-all duration-500 font-medium">
          {{ content?.cta?.button }}
        </router-link>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { usePageContent } from '@/composables/usePageContent'

const router = useRouter()
const { content, galleryImages, loading, error } = usePageContent('about')
</script>
