<template>
  <div>
    <!-- Breadcrumbs -->
    <nav class="bg-brand-gray-light py-4">
      <div class="container mx-auto px-4">
        <ol class="flex items-center space-x-2 text-sm">
          <li>
            <router-link to="/" class="text-brand-navy hover:text-brand-blue transition-colors">
              Home
            </router-link>
          </li>
          <li class="text-gray-400">/</li>
          <li class="text-brand-gray-dark font-semibold">Portfolio</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
      <!-- Page Title -->
      <div class="text-center mb-12">
        <h1 class="text-5xl font-bold mb-4 font-accent text-brand-navy">Our Work</h1>
        <p class="text-xl text-gray-600 max-w-2xl mx-auto">
          See how we've transformed businesses with stunning illuminated signage
        </p>
      </div>

      <!-- Industry Filter -->
      <div class="flex justify-center mb-12">
        <div class="flex flex-wrap items-center justify-center gap-3">
          <button
            v-for="industry in industries"
            :key="industry.value"
            @click="selectedIndustry = industry.value"
            :class="[
              'px-6 py-3 rounded-full transition-all font-semibold',
              selectedIndustry === industry.value
                ? 'bg-brand-blue text-white shadow-glow-blue'
                : 'bg-white text-brand-navy hover:bg-brand-blue hover:text-white shadow-md'
            ]"
          >
            {{ industry.label }}
          </button>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="text-center py-20">
        <div class="inline-block animate-spin rounded-full h-16 w-16 border-4 border-brand-blue border-t-transparent"></div>
        <p class="text-gray-600 mt-4 text-lg">Loading projects...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="text-center py-20">
        <p class="text-red-600 text-lg">{{ error }}</p>
      </div>

      <!-- Empty State -->
      <div v-else-if="filteredProjects.length === 0" class="text-center py-20">
        <svg class="w-24 h-24 mx-auto mb-6 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
        </svg>
        <p class="text-gray-600 text-lg mb-2">No projects found</p>
        <p class="text-gray-500">Try selecting a different industry filter</p>
      </div>

      <!-- Projects Grid -->
      <div 
        v-else
        class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-12"
      >
        <div 
          v-for="project in paginatedProjects"
          :key="project.id"
          class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-glow-blue transition-all duration-300"
        >
          <!-- Before/After Slider -->
          <BeforeAfterSlider 
            :before-image="project.beforeImage"
            :after-image="project.afterImage"
          />

          <!-- Project Info -->
          <div class="p-6">
            <!-- Industry Badge -->
            <span :class="[
              'inline-block px-3 py-1 rounded-full text-sm font-semibold mb-3',
              getIndustryBadgeClass(project.industry)
            ]">
              {{ project.industry }}
            </span>

            <!-- Project Name -->
            <h3 class="text-xl font-semibold mb-2 font-accent text-brand-navy">
              {{ project.name }}
            </h3>

            <!-- Description -->
            <p class="text-gray-600 text-sm mb-4 line-clamp-3">
              {{ project.description }}
            </p>

            <!-- View Details Link -->
            <a 
              href="#" 
              class="inline-flex items-center gap-2 text-brand-blue hover:text-brand-pink transition-colors font-semibold"
              @click.prevent="viewProjectDetails(project.id)"
            >
              View Details
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </a>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <div v-if="totalPages > 1" class="flex justify-center items-center gap-2">
        <button 
          @click="currentPage > 1 && currentPage--"
          :disabled="currentPage === 1"
          :class="[
            'px-4 py-2 rounded-lg transition-all',
            currentPage === 1 
              ? 'bg-gray-100 text-gray-400 cursor-not-allowed' 
              : 'bg-white text-brand-navy hover:bg-brand-blue hover:text-white shadow-md'
          ]"
        >
          Previous
        </button>

        <button 
          v-for="page in displayedPages"
          :key="page"
          @click="currentPage = page"
          :class="[
            'px-4 py-2 rounded-lg transition-all',
            page === currentPage 
              ? 'bg-brand-blue text-white shadow-glow-blue' 
              : 'bg-white text-brand-navy hover:bg-brand-blue hover:text-white shadow-md'
          ]"
        >
          {{ page }}
        </button>

        <button 
          @click="currentPage < totalPages && currentPage++"
          :disabled="currentPage === totalPages"
          :class="[
            'px-4 py-2 rounded-lg transition-all',
            currentPage === totalPages 
              ? 'bg-gray-100 text-gray-400 cursor-not-allowed' 
              : 'bg-white text-brand-navy hover:bg-brand-blue hover:text-white shadow-md'
          ]"
        >
          Next
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import BeforeAfterSlider from '@/components/ui/BeforeAfterSlider.vue'

// Industry filters
const industries = [
  { label: 'All', value: 'all' },
  { label: 'Restaurant', value: 'restaurant' },
  { label: 'Retail', value: 'retail' },
  { label: 'Office', value: 'office' },
  { label: 'Hotel', value: 'hotel' },
  { label: 'Other', value: 'other' }
]

const selectedIndustry = ref('all')
const loading = ref(false)
const error = ref<string | null>(null)

// Pagination
const currentPage = ref(1)
const itemsPerPage = 9

// Sample projects data (would come from API in production)
const projects = ref([
  {
    id: 1,
    name: 'Downtown Boutique',
    industry: 'Retail',
    description: 'Custom LED lightbox and channel letters transformed this storefront into a nighttime landmark, increasing foot traffic by 35%.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28Illuminated%29'
  },
  {
    id: 2,
    name: 'Urban Bar & Grill',
    industry: 'Restaurant',
    description: 'Eye-catching LED neon signage created a vibrant atmosphere and increased foot traffic by 40%. Modern aesthetic that perfectly matches the venue.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FF006E/ffffff?text=After+%28Neon%29'
  },
  {
    id: 3,
    name: 'Business Park Gateway',
    industry: 'Office',
    description: '5-meter illuminated pylon provides 24/7 visibility from the highway. Professional monument sign with elegant LED backlighting.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FFD600/000000?text=After+%28Pylon%29'
  },
  {
    id: 4,
    name: 'Fashion Flagship Store',
    industry: 'Retail',
    description: 'Premium backlit halo channel letters create a sophisticated look that elevated the brand presence in the shopping district.',
    beforeImage: 'https://via.placeholder.com/600x400/2a2a2a/777777?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28Halo+Letters%29'
  },
  {
    id: 5,
    name: 'Luxury Hotel Entrance',
    industry: 'Hotel',
    description: 'Elegant illuminated fascia with built-up letters created a stunning first impression for guests arriving day or night.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FFD600/000000?text=After+%28Fascia%29'
  },
  {
    id: 6,
    name: 'Coffee Corner Cafe',
    industry: 'Restaurant',
    description: 'Custom neon logo sign and illuminated menu board package created a cozy inviting atmosphere that draws customers in.',
    beforeImage: 'https://via.placeholder.com/600x400/2a2a2a/777777?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FF006E/ffffff?text=After+%28Neon+Logo%29'
  },
  {
    id: 7,
    name: 'Tech Startup HQ',
    industry: 'Office',
    description: 'Modern ultra-slim LED lightboxes throughout the office space communicate innovation and cutting-edge technology.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28LED+Boxes%29'
  },
  {
    id: 8,
    name: 'Gourmet Pizza Restaurant',
    industry: 'Restaurant',
    description: 'Double-sided illuminated hanging sign ensures visibility from both directions of the busy pedestrian street.',
    beforeImage: 'https://via.placeholder.com/600x400/2a2a2a/777777?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FFD600/000000?text=After+%28Double-Sided%29'
  },
  {
    id: 9,
    name: 'Medical Clinic Complex',
    industry: 'Other',
    description: 'Professional monument sign with LED illumination provides clear wayfinding and establishes trust with patients.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28Monument%29'
  },
  {
    id: 10,
    name: 'Boutique Hotel Rooftop',
    industry: 'Hotel',
    description: 'Large-scale LED neon logo on rooftop creates a stunning nighttime landmark visible throughout the city.',
    beforeImage: 'https://via.placeholder.com/600x400/2a2a2a/777777?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FF006E/ffffff?text=After+%28Rooftop+Neon%29'
  },
  {
    id: 11,
    name: 'Jewelry Store Premium',
    industry: 'Retail',
    description: 'Face and halo channel letters combine front illumination and glow effect for maximum luxury brand impact.',
    beforeImage: 'https://via.placeholder.com/600x400/1a1a1a/666666?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/FFD600/000000?text=After+%28Face+Halo%29'
  },
  {
    id: 12,
    name: 'Corporate Office Tower',
    industry: 'Office',
    description: 'Illuminated fascia with company logo creates professional presence on building exterior visible from major highway.',
    beforeImage: 'https://via.placeholder.com/600x400/2a2a2a/777777?text=Before',
    afterImage: 'https://via.placeholder.com/600x400/00D9FF/ffffff?text=After+%28Tower+Fascia%29'
  }
])

// Computed properties
const filteredProjects = computed(() => {
  if (selectedIndustry.value === 'all') {
    return projects.value
  }
  return projects.value.filter(p => p.industry.toLowerCase() === selectedIndustry.value.toLowerCase())
})

const totalPages = computed(() => Math.ceil(filteredProjects.value.length / itemsPerPage))

const paginatedProjects = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredProjects.value.slice(start, end)
})

const displayedPages = computed(() => {
  const pages: number[] = []
  const maxVisible = 5
  let start = Math.max(1, currentPage.value - Math.floor(maxVisible / 2))
  let end = Math.min(totalPages.value, start + maxVisible - 1)
  
  if (end - start < maxVisible - 1) {
    start = Math.max(1, end - maxVisible + 1)
  }
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})

// Methods
const getIndustryBadgeClass = (industry: string) => {
  switch (industry.toLowerCase()) {
    case 'restaurant':
      return 'bg-brand-pink text-white'
    case 'retail':
      return 'bg-brand-blue text-white'
    case 'office':
      return 'bg-brand-navy text-white'
    case 'hotel':
      return 'bg-brand-yellow text-brand-navy'
    default:
      return 'bg-gray-200 text-gray-800'
  }
}

const viewProjectDetails = (projectId: number) => {
  // TODO: Implement project details modal or page
  alert(`View project details for project #${projectId} - Feature coming soon!`)
}
</script>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
