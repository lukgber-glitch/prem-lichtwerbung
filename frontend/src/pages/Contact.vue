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

    <!-- Contact Form Section -->
    <section class="bg-light-bg py-20">
      <div class="max-w-content mx-auto px-6">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-16">
          <!-- LEFT COLUMN: Contact Form -->
          <div>
            <div class="w-16 h-1 bg-primary mb-8"></div>
            <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-12 leading-tight">
              {{ content?.form?.title }}
            </h2>

            <form @submit.prevent="submitForm">
              <div class="mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-2">{{ content?.form?.nameLabel }}</label>
                <input 
                  v-model="form.name"
                  type="text" 
                  required
                  class="w-full px-4 py-3 border border-gray-300 bg-white text-gray-900 focus:outline-none focus:border-primary transition-all duration-500"
                />
              </div>
              
              <div class="mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-2">{{ content?.form?.emailLabel }}</label>
                <input 
                  v-model="form.email"
                  type="email" 
                  required
                  class="w-full px-4 py-3 border border-gray-300 bg-white text-gray-900 focus:outline-none focus:border-primary transition-all duration-500"
                />
              </div>
              
              <div class="mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-2">{{ content?.form?.phoneLabel }}</label>
                <input 
                  v-model="form.phone"
                  type="tel"
                  class="w-full px-4 py-3 border border-gray-300 bg-white text-gray-900 focus:outline-none focus:border-primary transition-all duration-500"
                />
              </div>
              
              <div class="mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-2">{{ content?.form?.subjectLabel }}</label>
                <select 
                  v-model="form.subject"
                  required
                  class="w-full px-4 py-3 border border-gray-300 bg-white text-gray-900 cursor-pointer focus:outline-none focus:border-primary transition-all duration-500"
                >
                  <option value="">{{ content?.form?.subjectPlaceholder }}</option>
                  <option value="quote">{{ content?.form?.subjectQuote }}</option>
                  <option value="question">{{ content?.form?.subjectQuestion }}</option>
                  <option value="support">{{ content?.form?.subjectSupport }}</option>
                  <option value="other">{{ content?.form?.subjectOther }}</option>
                </select>
              </div>
              
              <div class="mb-8">
                <label class="block text-sm font-medium text-gray-700 mb-2">{{ content?.form?.messageLabel }}</label>
                <textarea 
                  v-model="form.message"
                  required
                  rows="6"
                  class="w-full px-4 py-3 border border-gray-300 bg-white text-gray-900 focus:outline-none focus:border-primary transition-all duration-500 resize-none"
                ></textarea>
              </div>
              
              <button 
                type="submit"
                :disabled="submitting"
                class="px-12 py-4 border-2 border-primary bg-primary text-white hover:bg-primary-dark transition-all duration-500 font-medium disabled:opacity-50"
              >
                {{ submitting ? content?.form?.sending : content?.form?.sendButton }}
              </button>
              
              <p v-if="submitSuccess" class="mt-6 text-gray-700">
                {{ content?.form?.successMessage }}
              </p>
              <p v-if="submitError" class="mt-6 text-primary">
                {{ submitError }}
              </p>
            </form>
          </div>
          
          <!-- RIGHT COLUMN: Contact Information -->
          <div>
            <div class="w-16 h-1 bg-primary mb-8"></div>
            <h3 class="text-2xl font-bold text-gray-900 mb-12">
              {{ content?.info?.title }}
            </h3>
            
            <div class="space-y-8">
              <div>
                <div class="text-sm font-medium text-gray-600 mb-2">{{ content?.info?.emailLabel }}</div>
                <a href="mailto:info@prem-lichtwerbung.de" class="text-lg text-gray-900 hover:text-primary transition-all duration-500">
                  info@prem-lichtwerbung.de
                </a>
              </div>
              
              <div>
                <div class="text-sm font-medium text-gray-600 mb-2">{{ content?.info?.phoneLabel }}</div>
                <a href="tel:+49123456789" class="text-lg text-gray-900 hover:text-primary transition-all duration-500">
                  +49 123 456 789
                </a>
              </div>
              
              <div>
                <div class="text-sm font-medium text-gray-600 mb-2">{{ content?.info?.locationLabel }}</div>
                <p class="text-lg text-gray-900">{{ content?.info?.locationValue }}</p>
              </div>
              
              <div>
                <div class="text-sm font-medium text-gray-600 mb-2">{{ content?.info?.hoursLabel }}</div>
                <p class="text-lg text-gray-900">{{ content?.info?.hoursWeekday }}</p>
                <p class="text-lg text-gray-900">{{ content?.info?.hoursSaturday }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { usePageContent } from '@/composables/usePageContent'

const { content, loading: pageLoading, error: pageError } = usePageContent('contact')

const form = ref({
  name: '',
  email: '',
  phone: '',
  subject: '',
  message: ''
})

const submitting = ref(false)
const submitSuccess = ref(false)
const submitError = ref('')

const submitForm = async () => {
  submitting.value = true
  submitSuccess.value = false
  submitError.value = ''
  
  try {
    // Simulate form submission
    await new Promise(resolve => setTimeout(resolve, 1000))
    
    console.log('Form submitted:', form.value)
    
    submitSuccess.value = true
    
    // Reset form
    form.value = {
      name: '',
      email: '',
      phone: '',
      subject: '',
      message: ''
    }
  } catch (e: any) {
    submitError.value = e.message || 'Failed to send message'
  } finally {
    submitting.value = false
  }
}
</script>
