<template>
  <div class="min-h-screen bg-omnicom-bg page-contact">
    
    <!-- HERO SECTION - Omnicom Minimal -->
    <section class="relative min-h-screen flex items-center justify-center bg-omnicom-black overflow-hidden px-6">
      <div class="noise-texture"></div>
      <div class="max-w-content mx-auto text-center">
        <h1 class="text-7xl md:text-9xl font-heading font-black text-omnicom-text-light leading-none tracking-[-0.03em]">
          Contact
        </h1>
      </div>
    </section>
    
    <!-- CONTACT FORM SECTION - Two Column Layout with Accent Line -->
    <section class="py-32 bg-omnicom-bg-alt">
      <div class="max-w-7xl mx-auto px-6">
        
        <!-- Decorative Accent Line -->
        <OmnicomAccentLine size="md" class="mb-8" />
        
        <!-- Section Label -->
        <p class="text-xs uppercase tracking-[0.2em] font-semibold text-omnicom-muted mb-6">Get In Touch</p>
        
        <h2 class="text-4xl md:text-5xl font-heading font-bold text-omnicom-text mb-16 leading-tight">
          Let's start a conversation
        </h2>
        
        <!-- Two Column Grid: Form + Contact Info -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-16">
          
          <!-- LEFT COLUMN: Contact Form -->
          <div>
            <form @submit.prevent="submitForm">
              <div class="mb-8">
                <label class="block text-sm font-light text-omnicom-muted mb-3">Name *</label>
                <input 
                  v-model="form.name"
                  type="text" 
                  required
                  class="w-full px-6 py-4 border border-omnicom-black/20 bg-omnicom-white text-omnicom-text font-light focus:outline-none focus:border-omnicom-black transition-all duration-500 focus-accent"
                />
              </div>
              
              <div class="mb-8">
                <label class="block text-sm font-light text-omnicom-muted mb-3">Email *</label>
                <input 
                  v-model="form.email"
                  type="email" 
                  required
                  class="w-full px-6 py-4 border border-omnicom-black/20 bg-omnicom-white text-omnicom-text font-light focus:outline-none focus:border-omnicom-black transition-all duration-500 focus-accent"
                />
              </div>
              
              <div class="mb-8">
                <label class="block text-sm font-light text-omnicom-muted mb-3">Phone</label>
                <input 
                  v-model="form.phone"
                  type="tel"
                  class="w-full px-6 py-4 border border-omnicom-black/20 bg-omnicom-white text-omnicom-text font-light focus:outline-none focus:border-omnicom-black transition-all duration-500 focus-accent"
                />
              </div>
              
              <div class="mb-8">
                <label class="block text-sm font-light text-omnicom-muted mb-3">Subject *</label>
                <select 
                  v-model="form.subject"
                  required
                  class="w-full px-6 py-4 border border-omnicom-black/20 bg-omnicom-white text-omnicom-text font-light cursor-pointer focus:outline-none focus:border-omnicom-black transition-all duration-500 focus-accent"
                >
                  <option value="">Select a subject</option>
                  <option value="quote">Request a Quote</option>
                  <option value="question">General Question</option>
                  <option value="support">Technical Support</option>
                  <option value="other">Other</option>
                </select>
              </div>
              
              <div class="mb-12">
                <label class="block text-sm font-light text-omnicom-muted mb-3">Message *</label>
                <textarea 
                  v-model="form.message"
                  required
                  rows="8"
                  class="w-full px-6 py-4 border border-omnicom-black/20 bg-omnicom-white text-omnicom-text font-light focus:outline-none focus:border-omnicom-black transition-all duration-500 resize-none focus-accent"
                ></textarea>
              </div>
              
              <ButtonGlow 
                type="submit"
                :disabled="submitting"
                :use-page-accent="true"
              >
                {{ submitting ? 'Sending...' : 'Send Message' }}
              </ButtonGlow>
              
              <p v-if="submitSuccess" class="mt-8 text-omnicom-text font-light">
                Message sent successfully. We'll respond within 24 hours.
              </p>
              <p v-if="submitError" class="mt-8 text-omnicom-text font-light">
                {{ submitError }}
              </p>
            </form>
          </div>
          
          <!-- RIGHT COLUMN: Contact Information -->
          <div>
            <h3 class="text-2xl font-heading font-semibold text-omnicom-text mb-12">
              Contact Information
            </h3>
            
            <div class="space-y-8">
              <div>
                <div class="text-sm font-light text-omnicom-muted mb-2">Email</div>
                <a href="mailto:info@prem-lichtwerbung.de" class="text-lg text-omnicom-text hover:text-omnicom-muted transition-all duration-500">
                  info@prem-lichtwerbung.de
                </a>
              </div>
              
              <div>
                <div class="text-sm font-light text-omnicom-muted mb-2">Phone</div>
                <a href="tel:+49123456789" class="text-lg text-omnicom-text hover:text-omnicom-muted transition-all duration-500">
                  +49 123 456 789
                </a>
              </div>
              
              <div>
                <div class="text-sm font-light text-omnicom-muted mb-2">Location</div>
                <p class="text-lg text-omnicom-text font-light">Berlin, Germany</p>
              </div>
              
              <div>
                <div class="text-sm font-light text-omnicom-muted mb-2">Business Hours</div>
                <p class="text-lg text-omnicom-text font-light">Monday - Friday: 9:00 - 18:00</p>
                <p class="text-lg text-omnicom-text font-light">Saturday: 10:00 - 14:00</p>
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import OmnicomAccentLine from '@/components/ui/OmnicomAccentLine.vue'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import { useScrollAnimation } from '@/composables/useScrollAnimation'

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

onMounted(() => {
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  if (reduce) return
  const { animateOnScroll } = useScrollAnimation()
  animateOnScroll('.accent-line', { y: 40, duration: 0.8 })
  animateOnScroll('h1', { y: 40, duration: 1.0 })
  animateOnScroll('h2', { y: 40, duration: 0.9 })
  animateOnScroll('p', { y: 30, duration: 0.8 })
  animateOnScroll('button', { y: 20, duration: 0.7 })
  animateOnScroll('label', { y: 10, duration: 0.6 })
})
</script>
