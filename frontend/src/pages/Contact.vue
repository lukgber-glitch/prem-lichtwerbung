<template>
  <div class="min-h-screen bg-white">
    
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-black overflow-hidden px-6">
      <div class="max-w-content mx-auto text-center">
        <h1 class="text-7xl md:text-9xl font-heading font-black text-white leading-none tracking-tighter">
          Contact
        </h1>
      </div>
    </section>
    
    <!-- CONTACT FORM SECTION - Single Column Minimal -->
    <section class="py-44 bg-white">
      <div class="max-w-text mx-auto px-6">
        
        <h2 class="text-4xl md:text-5xl font-heading font-bold text-black mb-16 leading-tight">
          Let's start a conversation
        </h2>
        
        <!-- Contact Form -->
        <form @submit.prevent="submitForm" class="mb-20">
          <div class="mb-8">
            <label class="block text-sm font-light text-black/60 mb-3">Name *</label>
            <input 
              v-model="form.name"
              type="text" 
              required
              class="w-full px-6 py-4 border border-black/20 bg-white text-black font-light focus:outline-none focus:border-black transition-all duration-500"
            />
          </div>
          
          <div class="mb-8">
            <label class="block text-sm font-light text-black/60 mb-3">Email *</label>
            <input 
              v-model="form.email"
              type="email" 
              required
              class="w-full px-6 py-4 border border-black/20 bg-white text-black font-light focus:outline-none focus:border-black transition-all duration-500"
            />
          </div>
          
          <div class="mb-8">
            <label class="block text-sm font-light text-black/60 mb-3">Phone</label>
            <input 
              v-model="form.phone"
              type="tel"
              class="w-full px-6 py-4 border border-black/20 bg-white text-black font-light focus:outline-none focus:border-black transition-all duration-500"
            />
          </div>
          
          <div class="mb-8">
            <label class="block text-sm font-light text-black/60 mb-3">Subject *</label>
            <select 
              v-model="form.subject"
              required
              class="w-full px-6 py-4 border border-black/20 bg-white text-black font-light cursor-pointer focus:outline-none focus:border-black transition-all duration-500"
            >
              <option value="">Select a subject</option>
              <option value="quote">Request a Quote</option>
              <option value="question">General Question</option>
              <option value="support">Technical Support</option>
              <option value="other">Other</option>
            </select>
          </div>
          
          <div class="mb-12">
            <label class="block text-sm font-light text-black/60 mb-3">Message *</label>
            <textarea 
              v-model="form.message"
              required
              rows="8"
              class="w-full px-6 py-4 border border-black/20 bg-white text-black font-light focus:outline-none focus:border-black transition-all duration-500 resize-none"
            ></textarea>
          </div>
          
          <button 
            type="submit"
            :disabled="submitting"
            class="px-16 py-6 bg-black text-white text-lg font-semibold hover:bg-white hover:text-black border-2 border-black transition-all duration-500 cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {{ submitting ? 'Sending...' : 'Send Message' }}
          </button>
          
          <p v-if="submitSuccess" class="mt-8 text-black font-light">
            Message sent successfully. We'll respond within 24 hours.
          </p>
          <p v-if="submitError" class="mt-8 text-black font-light">
            {{ submitError }}
          </p>
        </form>
        
        <!-- Contact Information - Minimal List -->
        <div class="pt-16 border-t border-black/10">
          <h3 class="text-2xl font-heading font-semibold text-black mb-12">
            Contact Information
          </h3>
          
          <div class="space-y-8">
            <div>
              <div class="text-sm font-light text-black/60 mb-2">Email</div>
              <a href="mailto:info@prem-lichtwerbung.de" class="text-lg text-black hover:text-black/60 transition-all duration-500">
                info@prem-lichtwerbung.de
              </a>
            </div>
            
            <div>
              <div class="text-sm font-light text-black/60 mb-2">Phone</div>
              <a href="tel:+49123456789" class="text-lg text-black hover:text-black/60 transition-all duration-500">
                +49 123 456 789
              </a>
            </div>
            
            <div>
              <div class="text-sm font-light text-black/60 mb-2">Location</div>
              <p class="text-lg text-black font-light">Berlin, Germany</p>
            </div>
            
            <div>
              <div class="text-sm font-light text-black/60 mb-2">Business Hours</div>
              <p class="text-lg text-black font-light">Monday - Friday: 9:00 - 18:00</p>
              <p class="text-lg text-black font-light">Saturday: 10:00 - 14:00</p>
            </div>
          </div>
        </div>
        
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

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
