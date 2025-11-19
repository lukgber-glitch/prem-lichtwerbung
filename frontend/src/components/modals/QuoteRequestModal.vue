<template>
  <Transition name="fade">
    <div 
      v-if="isOpen"
      class="fixed inset-0 z-50 flex items-center justify-center p-4"
      @click.self="closeModal"
    >
      <!-- Backdrop with blur -->
      <div 
        class="absolute inset-0 bg-black bg-opacity-50 backdrop-blur-sm"
        @click="closeModal"
      ></div>

      <!-- Modal Content -->
      <div 
        class="relative bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto"
        @click.stop
      >
        <!-- Close Button -->
        <button 
          @click="closeModal"
          class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition-colors z-10"
          aria-label="Close modal"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>

        <!-- Success State -->
        <div v-if="isSuccess" class="p-8 text-center">
          <div class="w-20 h-20 mx-auto mb-6 bg-green-100 rounded-full flex items-center justify-center">
            <svg class="w-10 h-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
          </div>
          <h3 class="text-3xl font-bold mb-4 font-accent text-brand-navy">Quote Request Submitted!</h3>
          <p class="text-lg text-gray-600 mb-6">
            Thank you for your interest! We'll respond within 24 hours with a detailed quote tailored to your needs.
          </p>
          <ButtonGlow variant="primary" @click="closeModal">
            Close
          </ButtonGlow>
        </div>

        <!-- Form State -->
        <div v-else class="p-8">
          <!-- Header -->
          <div class="mb-6">
            <h2 class="text-3xl font-bold mb-2 font-accent text-brand-navy">Request a Custom Quote</h2>
            <p class="text-gray-600">Tell us about your project and we'll provide a personalized quote</p>
          </div>

          <!-- Error Alert -->
          <div v-if="errorMessage" class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
            <svg class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div class="flex-grow">
              <p class="text-sm font-semibold text-red-800">{{ errorMessage }}</p>
            </div>
          </div>

          <!-- Form -->
          <form @submit.prevent="submitQuote" class="space-y-6">
            <!-- Name -->
            <div>
              <label for="quoteName" class="block text-sm font-semibold text-gray-700 mb-2">
                Full Name <span class="text-red-500">*</span>
              </label>
              <input 
                v-model="form.name"
                type="text" 
                id="quoteName"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="John Doe"
              />
            </div>

            <!-- Email & Phone -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label for="quoteEmail" class="block text-sm font-semibold text-gray-700 mb-2">
                  Email Address <span class="text-red-500">*</span>
                </label>
                <input 
                  v-model="form.email"
                  type="email" 
                  id="quoteEmail"
                  required
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                  placeholder="john@example.com"
                />
              </div>

              <div>
                <label for="quotePhone" class="block text-sm font-semibold text-gray-700 mb-2">
                  Phone Number
                </label>
                <input 
                  v-model="form.phone"
                  type="tel" 
                  id="quotePhone"
                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                  placeholder="+49 123 456789"
                />
              </div>
            </div>

            <!-- Company Name -->
            <div>
              <label for="quoteCompany" class="block text-sm font-semibold text-gray-700 mb-2">
                Company Name
              </label>
              <input 
                v-model="form.company"
                type="text" 
                id="quoteCompany"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="Your Company Ltd."
              />
            </div>

            <!-- Product Selection -->
            <div>
              <label for="quoteProduct" class="block text-sm font-semibold text-gray-700 mb-2">
                Product Interest
              </label>
              <select 
                v-model="form.productId"
                id="quoteProduct"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
              >
                <option value="">Select a product (optional)</option>
                <option value="lightbox-single">Single-Sided Lightbox</option>
                <option value="lightbox-double">Double-Sided Lightbox</option>
                <option value="lightbox-slim">Ultra-Slim LED Lightbox</option>
                <option value="channel-frontlit">Front-Lit Channel Letters</option>
                <option value="channel-backlit">Back-Lit Halo Channel Letters</option>
                <option value="channel-facehalo">Face and Halo Channel Letters</option>
                <option value="neon-logo">LED Neon Logo Sign</option>
                <option value="neon-text">Custom Text Neon Sign</option>
                <option value="pylon">Illuminated Pylon</option>
                <option value="monument">Monument Sign</option>
                <option value="fascia">Illuminated Fascia</option>
                <option value="window">Window Graphics/Display</option>
                <option value="terminal-bundle">POS Terminal + Menu Board Bundle</option>
                <option value="custom">Custom Project</option>
              </select>
            </div>

            <!-- Project Description -->
            <div>
              <label for="quoteDescription" class="block text-sm font-semibold text-gray-700 mb-2">
                Project Description <span class="text-red-500">*</span>
              </label>
              <textarea 
                v-model="form.description"
                id="quoteDescription"
                required
                rows="4"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all resize-none"
                placeholder="Tell us about your project: size requirements, location, installation needs, timeline, etc."
              ></textarea>
              <p class="text-xs text-gray-500 mt-1">{{ form.description.length }} / 1000 characters</p>
            </div>

            <!-- File Upload -->
            <div>
              <label class="block text-sm font-semibold text-gray-700 mb-2">
                Upload Files (Logo, References, Photos)
              </label>
              <div 
                @dragover.prevent="isDragging = true"
                @dragleave.prevent="isDragging = false"
                @drop.prevent="handleFileDrop"
                :class="[
                  'border-2 border-dashed rounded-lg p-6 text-center transition-all cursor-pointer',
                  isDragging ? 'border-brand-blue bg-brand-blue bg-opacity-5' : 'border-gray-300 hover:border-brand-blue'
                ]"
                @click="$refs.fileInput.click()"
              >
                <input 
                  ref="fileInput"
                  type="file" 
                  multiple
                  accept="image/*,.pdf,.doc,.docx"
                  @change="handleFileSelect"
                  class="hidden"
                />
                
                <svg class="w-12 h-12 mx-auto mb-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                </svg>
                <p class="text-sm text-gray-600 mb-1">
                  <span class="text-brand-blue font-semibold">Click to upload</span> or drag and drop
                </p>
                <p class="text-xs text-gray-500">PNG, JPG, PDF up to 10MB each</p>
              </div>

              <!-- File List -->
              <div v-if="uploadedFiles.length > 0" class="mt-3 space-y-2">
                <div 
                  v-for="(file, index) in uploadedFiles"
                  :key="index"
                  class="flex items-center justify-between p-3 bg-gray-50 rounded-lg"
                >
                  <div class="flex items-center gap-3 flex-grow min-w-0">
                    <svg class="w-5 h-5 text-brand-blue flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <span class="text-sm text-gray-700 truncate">{{ file.name }}</span>
                    <span class="text-xs text-gray-500 flex-shrink-0">({{ formatFileSize(file.size) }})</span>
                  </div>
                  <button 
                    type="button"
                    @click="removeFile(index)"
                    class="ml-2 text-red-500 hover:text-red-700 transition-colors flex-shrink-0"
                    aria-label="Remove file"
                  >
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </div>
              </div>
            </div>

            <!-- Budget Range Slider -->
            <div>
              <label class="block text-sm font-semibold text-gray-700 mb-2">
                Estimated Budget Range
              </label>
              <div class="space-y-3">
                <input 
                  v-model.number="form.budgetMax"
                  type="range"
                  min="500"
                  max="10000"
                  step="100"
                  class="w-full accent-brand-blue h-2"
                />
                <div class="flex justify-between items-center">
                  <span class="text-sm text-gray-600">€500</span>
                  <div class="px-4 py-2 bg-brand-blue text-white rounded-lg font-semibold">
                    {{ form.budgetMax >= 10000 ? '€10,000+' : `€${form.budgetMax.toLocaleString()}` }}
                  </div>
                  <span class="text-sm text-gray-600">€10,000+</span>
                </div>
              </div>
            </div>

            <!-- Urgency -->
            <div>
              <label for="quoteUrgency" class="block text-sm font-semibold text-gray-700 mb-2">
                Project Timeline
              </label>
              <select 
                v-model="form.urgency"
                id="quoteUrgency"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
              >
                <option value="asap">ASAP - Need it urgently</option>
                <option value="1-2weeks">1-2 weeks</option>
                <option value="1-2months">1-2 months</option>
                <option value="browsing">Just browsing</option>
              </select>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row gap-3 pt-4">
              <ButtonGlow 
                variant="primary" 
                type="submit"
                :disabled="isSubmitting"
                class="flex-grow"
              >
                <span v-if="!isSubmitting">Submit Quote Request</span>
                <span v-else class="flex items-center justify-center gap-2">
                  <svg class="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                  Submitting...
                </span>
              </ButtonGlow>
              <ButtonGlow 
                variant="secondary" 
                type="button"
                @click="closeModal"
                :disabled="isSubmitting"
              >
                Cancel
              </ButtonGlow>
            </div>
          </form>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import ButtonGlow from '../ui/ButtonGlow.vue'

const props = defineProps<{
  isOpen: boolean
  prefilledProductId?: string
}>()

const emit = defineEmits(['close', 'submit'])

// Form state
const form = ref({
  name: '',
  email: '',
  phone: '',
  company: '',
  productId: '',
  description: '',
  budgetMax: 2000,
  urgency: '1-2weeks'
})

const uploadedFiles = ref<File[]>([])
const isDragging = ref(false)
const isSubmitting = ref(false)
const isSuccess = ref(false)
const errorMessage = ref('')

// Watch for prefilled product
watch(() => props.prefilledProductId, (newValue) => {
  if (newValue) {
    form.value.productId = newValue
  }
}, { immediate: true })

// File handling
const handleFileSelect = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files) {
    addFiles(Array.from(target.files))
  }
}

const handleFileDrop = (event: DragEvent) => {
  isDragging.value = false
  if (event.dataTransfer?.files) {
    addFiles(Array.from(event.dataTransfer.files))
  }
}

const addFiles = (files: File[]) => {
  const validFiles = files.filter(file => {
    // Check file size (max 10MB)
    if (file.size > 10 * 1024 * 1024) {
      errorMessage.value = `File ${file.name} is too large (max 10MB)`
      setTimeout(() => errorMessage.value = '', 3000)
      return false
    }
    // Check file type
    const validTypes = ['image/png', 'image/jpeg', 'image/jpg', 'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
    if (!validTypes.includes(file.type)) {
      errorMessage.value = `File ${file.name} has invalid type`
      setTimeout(() => errorMessage.value = '', 3000)
      return false
    }
    return true
  })
  
  uploadedFiles.value = [...uploadedFiles.value, ...validFiles]
}

const removeFile = (index: number) => {
  uploadedFiles.value.splice(index, 1)
}

const formatFileSize = (bytes: number): string => {
  if (bytes < 1024) return bytes + ' B'
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB'
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}

// Form submission
const submitQuote = async () => {
  errorMessage.value = ''
  
  // Validate required fields
  if (!form.value.name || !form.value.email || !form.value.description) {
    errorMessage.value = 'Please fill in all required fields'
    return
  }

  // Validate email format
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(form.value.email)) {
    errorMessage.value = 'Please enter a valid email address'
    return
  }

  isSubmitting.value = true

  try {
    // Simulate API call (would be replaced with actual API endpoint)
    await new Promise(resolve => setTimeout(resolve, 1500))

    // In production, you would send the form data and files to your backend
    const quoteData = {
      ...form.value,
      files: uploadedFiles.value.map(f => f.name)
    }

    console.log('Quote submitted:', quoteData)

    // Show success state
    isSuccess.value = true

    // Emit submit event
    emit('submit', quoteData)

    // Reset form after 2 seconds and close modal
    setTimeout(() => {
      resetForm()
      isSuccess.value = false
      emit('close')
    }, 3000)

  } catch (error) {
    errorMessage.value = 'Failed to submit quote request. Please try again.'
    console.error('Quote submission error:', error)
  } finally {
    isSubmitting.value = false
  }
}

const resetForm = () => {
  form.value = {
    name: '',
    email: '',
    phone: '',
    company: '',
    productId: props.prefilledProductId || '',
    description: '',
    budgetMax: 2000,
    urgency: '1-2weeks'
  }
  uploadedFiles.value = []
  errorMessage.value = ''
}

const closeModal = () => {
  if (!isSubmitting.value) {
    emit('close')
  }
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

/* Custom scrollbar for modal content */
.overflow-y-auto::-webkit-scrollbar {
  width: 8px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #00D9FF;
  border-radius: 4px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #00b8d9;
}
</style>
