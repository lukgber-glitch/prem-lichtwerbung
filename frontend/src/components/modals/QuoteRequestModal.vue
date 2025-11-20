<template>
  <Teleport to="body">
    <Transition name="modal">
      <div v-if="isOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm" @click.self="close">
        <div class="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
          
          <!-- Header -->
          <div class="bg-gradient-to-r from-brand-blue to-brand-pink p-6 relative">
            <button @click="close" class="absolute top-4 right-4 text-white hover:text-brand-yellow transition-colors text-3xl leading-none">&times;</button>
            <h2 class="text-3xl font-accent font-bold text-white">Request a Custom Quote</h2>
            <p class="text-brand-warm mt-2">Tell us about your project and we'll respond within 24 hours</p>
          </div>
          
          <!-- Form -->
          <form @submit.prevent="handleSubmit" class="p-6 space-y-6">
            
            <div class="grid md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-semibold text-brand-navy mb-2">Name *</label>
                <input v-model="formData.name" required type="text" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors" placeholder="John Doe">
              </div>
              <div>
                <label class="block text-sm font-semibold text-brand-navy mb-2">Email *</label>
                <input v-model="formData.email" required type="email" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors" placeholder="john@example.com">
              </div>
            </div>
            
            <div class="grid md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-semibold text-brand-navy mb-2">Phone</label>
                <input v-model="formData.phone" type="tel" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors" placeholder="+49 123 456 789">
              </div>
              <div>
                <label class="block text-sm font-semibold text-brand-navy mb-2">Company Name</label>
                <input v-model="formData.company" type="text" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors" placeholder="Your Company">
              </div>
            </div>
            
            <div>
              <label class="block text-sm font-semibold text-brand-navy mb-2">Product Interest</label>
              <select v-model="formData.productType" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors">
                <option value="">Select a product type...</option>
                <option value="lightbox">Lightbox</option>
                <option value="channel-letters">Channel Letters</option>
                <option value="neon-sign">LED Neon Sign</option>
                <option value="pylon">Pylon/Totem</option>
                <option value="fascia">Fascia Sign</option>
                <option value="window">Window Sign</option>
                <option value="terminal-bundle">POS Terminal Bundle</option>
                <option value="custom">Custom Project</option>
              </select>
            </div>
            
            <div>
              <label class="block text-sm font-semibold text-brand-navy mb-2">Project Description *</label>
              <textarea v-model="formData.description" required rows="5" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors" placeholder="Tell us about your project, dimensions, installation location, timeline, etc."></textarea>
            </div>
            
            <div>
              <label class="block text-sm font-semibold text-brand-navy mb-2">Upload Files (Logo, References, Photos)</label>
              <input @change="handleFileUpload" type="file" multiple accept="image/*,.pdf" class="w-full px-4 py-3 rounded-lg border-2 border-dashed border-gray-300 hover:border-brand-blue focus:border-brand-blue focus:outline-none transition-colors cursor-pointer">
              <p class="text-sm text-gray-500 mt-2">Max 5MB per file. Accepted: JPG, PNG, PDF</p>
            </div>
            
            <div>
              <label class="block text-sm font-semibold text-brand-navy mb-4">Estimated Budget Range</label>
              <input v-model="formData.budget" type="range" min="500" max="10000" step="500" class="w-full">
              <div class="flex justify-between text-sm text-gray-600 mt-2">
                <span>€500</span>
                <span class="font-bold text-brand-blue text-lg">€{{ formData.budget }}{{ formData.budget >= 10000 ? '+' : '' }}</span>
                <span>€10,000+</span>
              </div>
            </div>
            
            <div>
              <label class="block text-sm font-semibold text-brand-navy mb-2">Urgency</label>
              <select v-model="formData.urgency" class="w-full px-4 py-3 rounded-lg border-2 border-gray-300 focus:border-brand-blue focus:outline-none transition-colors">
                <option value="asap">ASAP - Need it urgently</option>
                <option value="1-2-weeks">1-2 weeks</option>
                <option value="1-2-months">1-2 months</option>
                <option value="browsing">Just browsing</option>
              </select>
            </div>
            
            <div v-if="successMessage" class="bg-green-50 border-2 border-green-500 text-green-700 p-4 rounded-lg">
              {{ successMessage }}
            </div>
            
            <div v-if="errorMessage" class="bg-red-50 border-2 border-red-500 text-red-700 p-4 rounded-lg">
              {{ errorMessage }}
            </div>
            
            <div class="flex gap-4">
              <ButtonGlow variant="accent" type="submit" :disabled="isSubmitting" class="flex-1 text-lg">
                {{ isSubmitting ? 'Sending...' : 'Submit Quote Request' }}
              </ButtonGlow>
              <button type="button" @click="close" class="px-8 py-3 rounded-lg border-2 border-gray-300 hover:border-brand-navy transition-colors">
                Cancel
              </button>
            </div>
            
          </form>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const props = defineProps<{
  isOpen: boolean
  prefilledProduct?: string
}>()

const emit = defineEmits<{
  close: []
}>()

const formData = reactive({
  name: '',
  email: '',
  phone: '',
  company: '',
  productType: props.prefilledProduct || '',
  description: '',
  budget: 2500,
  urgency: '1-2-weeks',
  files: [] as File[]
})

const isSubmitting = ref(false)
const successMessage = ref('')
const errorMessage = ref('')

const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files) {
    formData.files = Array.from(target.files)
  }
}

const handleSubmit = async () => {
  isSubmitting.value = true
  successMessage.value = ''
  errorMessage.value = ''
  
  try {
    // TODO: Implement API call to send quote request
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    successMessage.value = 'Quote request submitted successfully! We\'ll respond within 24 hours.'
    
    setTimeout(() => {
      close()
    }, 2000)
  } catch (error) {
    errorMessage.value = 'Failed to submit quote request. Please try again or contact us directly.'
  } finally {
    isSubmitting.value = false
  }
}

const close = () => {
  emit('close')
}
</script>

<style scoped>
.modal-enter-active, .modal-leave-active {
  transition: opacity 0.3s ease;
}
.modal-enter-from, .modal-leave-to {
  opacity: 0;
}
</style>
