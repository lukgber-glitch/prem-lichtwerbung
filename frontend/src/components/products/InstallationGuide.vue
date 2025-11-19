<template>
  <div class="space-y-8">
    <!-- Installation Guide Header -->
    <div class="text-center mb-8">
      <h2 class="text-3xl font-bold mb-3 font-accent text-brand-navy">Installation Guide</h2>
      <p class="text-gray-600 max-w-2xl mx-auto">
        Follow these steps to properly install your {{ productName }}. For best results, we recommend professional installation.
      </p>
    </div>

    <!-- Video Tutorial (if available) -->
    <div v-if="videoUrl" class="aspect-video rounded-xl overflow-hidden shadow-lg mb-8">
      <iframe 
        :src="getEmbedUrl(videoUrl)"
        class="w-full h-full"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
        title="Installation video tutorial"
      ></iframe>
    </div>

    <!-- Safety Warnings -->
    <div v-if="safetyWarnings.length > 0" class="bg-yellow-50 border-l-4 border-yellow-400 p-6 rounded-lg mb-8">
      <div class="flex items-start gap-4">
        <div class="flex-shrink-0">
          <svg class="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
          </svg>
        </div>
        <div class="flex-grow">
          <h3 class="text-lg font-bold text-yellow-900 mb-3">⚠️ Safety Warnings</h3>
          <ul class="space-y-2">
            <li 
              v-for="(warning, index) in safetyWarnings"
              :key="index"
              class="text-sm text-yellow-800 flex items-start gap-2"
            >
              <span class="text-yellow-600 font-bold">•</span>
              <span>{{ warning }}</span>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Tools Required -->
    <div v-if="toolsRequired.length > 0" class="bg-brand-gray-light rounded-xl p-6 mb-8">
      <h3 class="text-xl font-bold mb-4 font-accent text-brand-navy flex items-center gap-2">
        <svg class="w-6 h-6 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
        Tools Required
      </h3>
      <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        <div 
          v-for="(tool, index) in toolsRequired"
          :key="index"
          class="flex items-center gap-3 p-3 bg-white rounded-lg shadow-sm"
        >
          <div class="w-10 h-10 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center flex-shrink-0">
            <svg class="w-5 h-5 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <span class="text-sm font-medium text-gray-700">{{ tool }}</span>
        </div>
      </div>
    </div>

    <!-- Installation Steps -->
    <div class="space-y-6">
      <div 
        v-for="(step, index) in installationSteps"
        :key="index"
        class="flex gap-6 p-6 bg-white rounded-xl shadow-md hover:shadow-lg transition-shadow"
      >
        <!-- Step Number -->
        <div class="flex-shrink-0">
          <div class="w-16 h-16 bg-gradient-to-br from-brand-blue to-brand-pink rounded-full flex items-center justify-center shadow-lg">
            <span class="text-3xl font-bold text-white">{{ index + 1 }}</span>
          </div>
        </div>

        <!-- Step Content -->
        <div class="flex-grow">
          <h3 class="text-xl font-bold mb-2 text-brand-navy">{{ step.title }}</h3>
          <p class="text-gray-700 mb-4 leading-relaxed">{{ step.description }}</p>
          
          <!-- Step Image (if available) -->
          <div v-if="step.image" class="mt-4 rounded-lg overflow-hidden shadow-md">
            <img 
              :src="step.image"
              :alt="`Step ${index + 1}: ${step.title}`"
              class="w-full h-auto"
            />
          </div>

          <!-- Additional Notes -->
          <div v-if="step.note" class="mt-4 p-3 bg-blue-50 border-l-4 border-brand-blue rounded">
            <p class="text-sm text-blue-900">
              <span class="font-semibold">💡 Tip: </span>{{ step.note }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Download PDF Guide -->
    <div v-if="pdfUrl" class="text-center py-6">
      <ButtonGlow 
        variant="secondary" 
        @click="downloadPDF"
        class="inline-flex items-center gap-2"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
        Download Complete PDF Guide
      </ButtonGlow>
    </div>

    <!-- Professional Installation CTA -->
    <div class="bg-gradient-to-br from-brand-navy to-brand-blue rounded-xl p-8 text-white shadow-2xl">
      <div class="max-w-3xl mx-auto">
        <div class="flex items-start gap-6">
          <div class="flex-shrink-0 hidden md:block">
            <div class="w-20 h-20 bg-white bg-opacity-20 rounded-full flex items-center justify-center">
              <svg class="w-10 h-10 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
              </svg>
            </div>
          </div>
          
          <div class="flex-grow">
            <h3 class="text-2xl font-bold mb-3 font-accent">Need Professional Installation?</h3>
            <p class="text-brand-warm mb-6">
              Our experienced technicians can install your signage quickly and safely, ensuring optimal performance and longevity.
            </p>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-brand-yellow" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span class="text-sm">Licensed & Insured</span>
              </div>
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-brand-yellow" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span class="text-sm">Same-Day Service Available</span>
              </div>
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-brand-yellow" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span class="text-sm">1-Year Warranty</span>
              </div>
            </div>

            <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4">
              <div v-if="installationPrice" class="text-left">
                <div class="text-sm text-brand-warm opacity-80">Installation Service</div>
                <div class="text-3xl font-bold text-brand-yellow">€{{ installationPrice.toFixed(2) }}</div>
              </div>
              
              <div class="flex flex-col sm:flex-row gap-3 sm:ml-auto">
                <ButtonGlow 
                  variant="accent" 
                  @click="addInstallationToCart"
                  class="whitespace-nowrap"
                >
                  Add Installation to Cart
                </ButtonGlow>
                <button 
                  @click="contactUs"
                  class="px-6 py-3 bg-white bg-opacity-20 hover:bg-opacity-30 text-white font-semibold rounded-lg transition-all"
                >
                  Contact Us
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import ButtonGlow from '../ui/ButtonGlow.vue'

interface InstallationStep {
  title: string
  description: string
  image?: string
  note?: string
}

const props = defineProps<{
  productName?: string
  installationSteps?: InstallationStep[]
  toolsRequired?: string[]
  safetyWarnings?: string[]
  videoUrl?: string
  pdfUrl?: string
  installationPrice?: number
}>()

const emit = defineEmits(['add-installation', 'contact'])

// Default installation steps if none provided
const defaultSteps: InstallationStep[] = [
  {
    title: 'Prepare the Installation Site',
    description: 'Clean the mounting surface thoroughly. Ensure the area is free from dust, grease, and moisture. Mark the exact position where the sign will be mounted using a level and measuring tape.',
    note: 'Use a stud finder to locate solid mounting points for heavy signs.'
  },
  {
    title: 'Install Mounting Hardware',
    description: 'Drill pilot holes at marked positions. Insert appropriate anchors or mounting brackets. Ensure all hardware is securely fastened and level before proceeding.',
    note: 'For masonry surfaces, use masonry drill bits and appropriate anchors.'
  },
  {
    title: 'Connect Electrical Components',
    description: 'Turn off power at the breaker. Connect the power supply according to the wiring diagram. Secure all connections with wire nuts and electrical tape. Ensure all connections meet local electrical codes.',
    note: 'Electrical work must be performed by a licensed electrician.'
  },
  {
    title: 'Mount the Sign',
    description: 'With assistance, carefully lift the sign into position. Align mounting holes with installed hardware. Secure the sign using provided fasteners. Double-check that the sign is level and secure.',
    note: 'Heavy signs require at least two people for safe installation.'
  },
  {
    title: 'Test and Finalize',
    description: 'Restore power and test all lighting functions. Check for proper illumination across the entire sign. Clean any fingerprints or marks. Verify all fasteners are tight and the sign is securely mounted.',
    note: 'Allow LED signs to run for 24 hours to ensure proper operation.'
  }
]

// Default tools if none provided
const defaultTools = [
  'Power Drill',
  'Level',
  'Measuring Tape',
  'Screwdriver Set',
  'Wire Strippers',
  'Ladder',
  'Safety Glasses',
  'Work Gloves'
]

// Default safety warnings if none provided
const defaultSafetyWarnings = [
  'Always turn off power at the breaker before working with electrical components',
  'Use proper ladder safety techniques and never work alone at heights',
  'Wear appropriate safety equipment including gloves and safety glasses',
  'Heavy signs require at least two people to lift and position safely',
  'Electrical installation must comply with local building codes and regulations',
  'If you are unsure about any step, consult a professional installer'
]

// Use provided props or defaults
const installationSteps = props.installationSteps || defaultSteps
const toolsRequired = props.toolsRequired || defaultTools
const safetyWarnings = props.safetyWarnings || defaultSafetyWarnings

// Methods
const getEmbedUrl = (url: string): string => {
  if (url.includes('youtube.com/watch')) {
    const videoId = url.split('v=')[1]?.split('&')[0]
    return `https://www.youtube.com/embed/${videoId}`
  } else if (url.includes('youtu.be/')) {
    const videoId = url.split('youtu.be/')[1]?.split('?')[0]
    return `https://www.youtube.com/embed/${videoId}`
  }
  return url
}

const downloadPDF = () => {
  if (props.pdfUrl) {
    window.open(props.pdfUrl, '_blank')
  }
}

const addInstallationToCart = () => {
  emit('add-installation')
}

const contactUs = () => {
  emit('contact')
}
</script>

<style scoped>
/* Ensure smooth transitions */
* {
  transition-property: background-color, border-color, color, fill, stroke, opacity, box-shadow, transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 150ms;
}
</style>
