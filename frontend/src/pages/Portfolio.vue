<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      
      <div class="text-center mb-12">
        <h1 class="text-5xl font-heading font-bold text-text-main mb-4">Our Work</h1>
        <p class="text-xl text-text-muted">
          See how we've helped businesses stand out
        </p>
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
              ? 'bg-primary text-background border-primary' 
              : 'bg-surface text-text-main border-text-muted hover:border-primary hover:text-primary'
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
          class="bg-surface rounded-xl border border-primary/20 overflow-hidden hover:border-primary transition-all cursor-pointer"
        >
          <div class="aspect-video bg-surface-alt flex items-center justify-center">
            <span class="text-6xl">{{ project.icon }}</span>
          </div>
          
          <div class="p-6">
            <div class="flex items-center gap-2 mb-3">
              <span class="px-3 py-1 bg-primary/10 text-primary text-xs font-semibold rounded-full border border-primary/30">
                {{ project.industry }}
              </span>
            </div>
            
            <h3 class="text-xl font-bold text-text-main mb-2">{{ project.name }}</h3>
            <p class="text-text-muted mb-4">{{ project.description }}</p>
            
            <div class="flex items-center justify-between">
              <span class="text-sm text-text-muted">{{ project.location }}</span>
              <button class="text-primary font-semibold hover:text-accent transition-colors cursor-pointer">
                View Details →
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <div v-if="filteredProjects.length === 0" class="text-center py-12">
        <p class="text-xl text-text-muted">No projects found for this category</p>
      </div>
      
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

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
</script>
