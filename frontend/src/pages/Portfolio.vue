<template>
  <div class="min-h-screen bg-omnicom-bg page-portfolio">
    <div class="container mx-auto px-6 py-12">
      
      <div class="text-center mb-12">
        <OmnicomAccentLine size="md" class="mb-6 mx-auto" />
        <p class="text-xs uppercase tracking-[0.2em] font-semibold text-omnicom-muted mb-4">Portfolio</p>
        <h1 class="text-5xl md:text-6xl font-heading font-bold text-omnicom-text tracking-[-0.02em] mb-4">Our Work</h1>
        <p class="text-xl text-omnicom-muted">See how we've helped businesses stand out</p>
      </div>
      
      <!-- Filter Tabs -->
      <div class="flex justify-center gap-4 mb-12 flex-wrap">
        <button 
          v-for="filter in industryFilters" 
          :key="filter"
          @click="selectedIndustry = filter"
          :class="[
            'px-6 py-3 rounded-lg font-semibold transition-all border-2 cursor-pointer',
            selectedIndustry === filter 
              ? 'bg-omnicom-black text-omnicom-text-light border-omnicom-black' 
              : 'bg-omnicom-bg-alt text-omnicom-text border-omnicom-gray-300 hover:border-omnicom-black hover:text-omnicom-black'
          ]"
        >
          {{ filter }}
        </button>
      </div>
      
      <!-- Projects Grid -->
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div 
          v-for="project in filteredProjects" 
          :key="project.id"
          class="bg-omnicom-bg-alt border border-omnicom-gray-300/25 overflow-hidden hover:border-omnicom-black transition-all cursor-pointer"
        >
          <div class="aspect-video bg-omnicom-bg flex items-center justify-center">
            <span class="text-6xl">{{ project.icon }}</span>
          </div>
          
          <div class="p-6">
            <div class="flex items-center gap-2 mb-3">
              <span class="px-3 py-1 bg-omnicom-black/5 text-omnicom-text text-xs font-semibold border border-omnicom-gray-300">
                {{ project.industry }}
              </span>
            </div>
            
            <h3 class="text-xl font-bold text-omnicom-text mb-2">{{ project.name }}</h3>
            <p class="text-omnicom-muted mb-4">{{ project.description }}</p>
            
            <div class="flex items-center justify-between">
              <span class="text-sm text-omnicom-muted">{{ project.location }}</span>
              <button class="text-omnicom-text font-semibold hover:accent-text transition-colors cursor-pointer">
                View Details →
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <div v-if="filteredProjects.length === 0" class="text-center py-12">
        <p class="text-xl text-omnicom-muted">No projects found for this category</p>
      </div>
      
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import OmnicomAccentLine from '@/components/ui/OmnicomAccentLine.vue'
import { useScrollAnimation } from '@/composables/useScrollAnimation'

const selectedIndustry = ref('All')

const industryFilters = ['All', 'Restaurant', 'Retail', 'Office', 'Hotel']

const sampleProjects = [
  {
    id: 1,
    name: 'Downtown Bistro Signage',
    industry: 'Restaurant',
    description: 'Complete illuminated signage package including pylon, channel letters, and menu boards.',
    location: 'Berlin, Germany',
    icon: '🍽️'
  },
  {
    id: 2,
    name: 'Fashion Boutique Fascia',
    industry: 'Retail',
    description: 'Elegant backlit fascia sign with custom typography and LED neon accent.',
    location: 'Munich, Germany',
    icon: '👗'
  },
  {
    id: 3,
    name: 'Tech Startup Logo Wall',
    industry: 'Office',
    description: 'Modern LED neon logo installation for office reception area.',
    location: 'Hamburg, Germany',
    icon: '💻'
  },
]

const filteredProjects = computed(() => {
  if (selectedIndustry.value === 'All') {
    return sampleProjects
  }
  return sampleProjects.filter(p => p.industry === selectedIndustry.value)
})

onMounted(() => {
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  if (reduce) return
  const { animateOnScroll } = useScrollAnimation()
  animateOnScroll('.accent-line', { y: 40, duration: 0.8 })
  animateOnScroll('h1', { y: 40, duration: 1.0 })
  animateOnScroll('p', { y: 30, duration: 0.8 })
  animateOnScroll('button', { y: 20, duration: 0.7 })
})
</script>
