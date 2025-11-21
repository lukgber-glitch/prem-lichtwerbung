<template>
  <div class="min-h-screen bg-background">
    <div class="container mx-auto px-6 py-12">
      
      <div class="max-w-4xl mx-auto">
        <h1 class="text-5xl font-heading font-bold text-text-main mb-4 text-center">Get in Touch</h1>
        <p class="text-xl text-text-muted mb-12 text-center">
          Have a question or ready to start your project? We're here to help!
        </p>
        
        <div class="grid md:grid-cols-2 gap-12">
          
          <!-- Contact Form -->
          <div class="bg-surface p-8 rounded-xl border border-primary/20">
            <h2 class="text-2xl font-heading font-bold text-text-main mb-6">Send us a message</h2>
            
            <form @submit.prevent="submitForm">
              <div class="mb-4">
                <label class="block text-text-main font-semibold mb-2">Name *</label>
                <input 
                  v-model="form.name"
                  type="text" 
                  required
                  class="w-full px-4 py-3 border border-surface-alt rounded-lg focus:ring-2 focus:ring-primary focus:border-primary bg-surface-alt text-text-main placeholder-text-muted"
                />
              </div>
              
              <div class="mb-4">
                <label class="block text-text-main font-semibold mb-2">Email *</label>
                <input 
                  v-model="form.email"
                  type="email" 
                  required
                  class="w-full px-4 py-3 border border-surface-alt rounded-lg focus:ring-2 focus:ring-primary focus:border-primary bg-surface-alt text-text-main placeholder-text-muted"
                />
              </div>
              
              <div class="mb-4">
                <label class="block text-text-main font-semibold mb-2">Phone</label>
                <input 
                  v-model="form.phone"
                  type="tel"
                  class="w-full px-4 py-3 border border-surface-alt rounded-lg focus:ring-2 focus:ring-primary focus:border-primary bg-surface-alt text-text-main placeholder-text-muted"
                />
              </div>
              
              <div class="mb-4">
                <label class="block text-text-main font-semibold mb-2">Subject *</label>
                <select 
                  v-model="form.subject"
                  required
                  class="w-full px-4 py-3 border border-surface-alt rounded-lg focus:ring-2 focus:ring-primary focus:border-primary bg-surface-alt text-text-main cursor-pointer"
                >
                  <option value="">Select a subject</option>
                  <option value="quote">Request a Quote</option>
                  <option value="question">General Question</option>
                  <option value="support">Technical Support</option>
                  <option value="other">Other</option>
                </select>
              </div>
              
              <div class="mb-6">
                <label class="block text-text-main font-semibold mb-2">Message *</label>
                <textarea 
                  v-model="form.message"
                  required
                  rows="5"
                  class="w-full px-4 py-3 border border-surface-alt rounded-lg focus:ring-2 focus:ring-primary focus:border-primary bg-surface-alt text-text-main placeholder-text-muted"
                ></textarea>
              </div>
              
              <button 
                type="submit"
                :disabled="submitting"
                class="w-full px-8 py-4 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary disabled:bg-text-muted disabled:cursor-not-allowed cursor-pointer flex items-center justify-center gap-2"
              >
                <Mail v-if="!submitting" :size="24" :stroke-width="2" />
                {{ submitting ? 'Sending...' : 'Send Message' }}
              </button>
              
              <p v-if="submitSuccess" class="mt-4 text-green-600 text-center flex items-center justify-center gap-2">
                <Check :size="20" :stroke-width="2" />
                Message sent successfully! We'll respond within 24 hours.
              </p>
              <p v-if="submitError" class="mt-4 text-red-600 text-center flex items-center justify-center gap-2">
                <X :size="20" :stroke-width="2" />
                {{ submitError }}
              </p>
            </form>
          </div>
          
          <!-- Contact Info -->
          <div>
            <div class="bg-surface p-8 rounded-xl border border-primary/20 hover:border-primary transition-all mb-6">
              <h3 class="text-2xl font-heading font-bold text-text-main mb-6">Contact Information</h3>
              
              <div class="space-y-4">
                <div class="flex items-start gap-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                    <MapPin :size="24" :stroke-width="1.5" class="text-primary" />
                  </div>
                  <div>
                    <h4 class="font-semibold text-text-main">Address</h4>
                    <p class="text-text-muted">Berlin, Germany</p>
                  </div>
                </div>
                
                <div class="flex items-start gap-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                    <Mail :size="24" :stroke-width="1.5" class="text-primary" />
                  </div>
                  <div>
                    <h4 class="font-semibold text-text-main">Email</h4>
                    <a href="mailto:info@prem-lichtwerbung.de" class="text-primary hover:text-accent hover:underline transition-colors cursor-pointer">
                      info@prem-lichtwerbung.de
                    </a>
                  </div>
                </div>
                
                <div class="flex items-start gap-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                    <Phone :size="24" :stroke-width="1.5" class="text-primary" />
                  </div>
                  <div>
                    <h4 class="font-semibold text-text-main">Phone</h4>
                    <a href="tel:+49123456789" class="text-primary hover:text-accent hover:underline transition-colors cursor-pointer">
                      +49 123 456 789
                    </a>
                  </div>
                </div>
                
                <div class="flex items-start gap-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                    <Clock :size="24" :stroke-width="1.5" class="text-primary" />
                  </div>
                  <div>
                    <h4 class="font-semibold text-text-main">Business Hours</h4>
                    <p class="text-text-muted">Monday - Friday: 9:00 - 18:00</p>
                    <p class="text-text-muted">Saturday: 10:00 - 14:00</p>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="bg-surface p-8 rounded-xl border-2 border-accent hover:border-accent transition-all">
              <h3 class="text-2xl font-heading font-bold mb-4 text-primary">Need Urgent Help?</h3>
              <p class="mb-6 text-text-muted">For immediate assistance, call us directly or use our live chat.</p>
              <button 
                class="w-full px-6 py-3 bg-accent text-background font-bold rounded-lg hover:bg-accent/90 transition-all border-2 border-accent cursor-pointer flex items-center justify-center gap-2"
              >
                <MessageSquare :size="20" :stroke-width="2" />
                Start Live Chat
              </button>
            </div>
          </div>
          
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Mail, MapPin, Phone, Clock, MessageSquare, Check, X } from 'lucide-vue-next'

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
