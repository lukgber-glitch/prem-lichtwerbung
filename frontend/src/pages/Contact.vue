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
          <li class="text-brand-gray-dark font-semibold">Contact</li>
        </ol>
      </div>
    </nav>

    <div class="container mx-auto px-4 py-12">
      <!-- Page Title -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-bold mb-4 font-accent text-brand-navy">
          Get in Touch
        </h1>
        <p class="text-xl text-gray-600 max-w-2xl mx-auto">
          Have a project in mind? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
        </p>
      </div>

      <!-- Contact Layout -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 max-w-6xl mx-auto">
        <!-- LEFT COLUMN - CONTACT FORM -->
        <div class="bg-white rounded-lg shadow-lg p-8">
          <h2 class="text-2xl font-bold mb-6 font-accent text-brand-navy">Send Us a Message</h2>

          <!-- Success Message -->
          <div 
            v-if="formStatus === 'success'"
            class="mb-6 p-4 bg-green-100 border border-green-400 text-green-700 rounded-lg flex items-start gap-3"
          >
            <svg class="w-6 h-6 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
            </svg>
            <div>
              <p class="font-semibold">Message sent successfully!</p>
              <p class="text-sm">We'll get back to you within 24 hours.</p>
            </div>
          </div>

          <!-- Error Message -->
          <div 
            v-if="formStatus === 'error'"
            class="mb-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-start gap-3"
          >
            <svg class="w-6 h-6 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
            </svg>
            <div>
              <p class="font-semibold">Failed to send message</p>
              <p class="text-sm">{{ errorMessage || 'Please try again later or contact us directly.' }}</p>
            </div>
          </div>

          <!-- Contact Form -->
          <form @submit.prevent="submitForm" class="space-y-5">
            <!-- Name -->
            <div>
              <label for="name" class="block text-sm font-semibold text-gray-700 mb-2">
                Your Name *
              </label>
              <input 
                v-model="form.name"
                type="text" 
                id="name"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="John Doe"
              />
            </div>

            <!-- Email -->
            <div>
              <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                Email Address *
              </label>
              <input 
                v-model="form.email"
                type="email" 
                id="email"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="john@example.com"
              />
            </div>

            <!-- Phone -->
            <div>
              <label for="phone" class="block text-sm font-semibold text-gray-700 mb-2">
                Phone Number
              </label>
              <input 
                v-model="form.phone"
                type="tel" 
                id="phone"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                placeholder="+49 123 456789"
              />
            </div>

            <!-- Subject -->
            <div>
              <label for="subject" class="block text-sm font-semibold text-gray-700 mb-2">
                Subject *
              </label>
              <select 
                v-model="form.subject"
                id="subject"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
              >
                <option value="">Select a subject</option>
                <option value="general">General Inquiry</option>
                <option value="quote">Request a Quote</option>
                <option value="custom">Custom Design Project</option>
                <option value="installation">Installation Service</option>
                <option value="support">Technical Support</option>
                <option value="partnership">Partnership Opportunity</option>
                <option value="other">Other</option>
              </select>
            </div>

            <!-- Message -->
            <div>
              <label for="message" class="block text-sm font-semibold text-gray-700 mb-2">
                Your Message *
              </label>
              <textarea 
                v-model="form.message"
                id="message"
                required
                rows="6"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all resize-none"
                placeholder="Tell us about your project or inquiry..."
              ></textarea>
            </div>

            <!-- Submit Button -->
            <ButtonGlow 
              type="submit"
              variant="primary" 
              :disabled="isSubmitting"
              class="w-full text-lg py-4"
            >
              <span v-if="!isSubmitting" class="flex items-center justify-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
                Send Message
              </span>
              <span v-else class="flex items-center justify-center gap-3">
                <svg class="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Sending...
              </span>
            </ButtonGlow>

            <p class="text-sm text-gray-500 text-center">
              * Required fields
            </p>
          </form>
        </div>

        <!-- RIGHT COLUMN - CONTACT INFO -->
        <div class="space-y-8">
          <!-- Contact Information Card -->
          <div class="bg-gradient-to-br from-brand-navy to-brand-blue text-white rounded-lg shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-6 font-accent">Contact Information</h2>

            <div class="space-y-6">
              <!-- Address -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-brand-blue bg-opacity-30 rounded-lg flex items-center justify-center flex-shrink-0">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold mb-1">Our Location</h3>
                  <p class="text-brand-warm">
                    Lichtwerbung Strasse 42<br>
                    10115 Berlin, Germany
                  </p>
                </div>
              </div>

              <!-- Phone -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-brand-blue bg-opacity-30 rounded-lg flex items-center justify-center flex-shrink-0">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold mb-1">Call Us</h3>
                  <a href="tel:+4930123456789" class="text-brand-warm hover:text-white transition-colors">
                    +49 30 123 456 789
                  </a>
                  <p class="text-sm text-brand-warm mt-1">Mon-Fri, 8:00 AM - 6:00 PM</p>
                </div>
              </div>

              <!-- Email -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-brand-blue bg-opacity-30 rounded-lg flex items-center justify-center flex-shrink-0">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold mb-1">Email Us</h3>
                  <a href="mailto:info@prem-lichtwerbung.de" class="text-brand-warm hover:text-white transition-colors">
                    info@prem-lichtwerbung.de
                  </a>
                  <p class="text-sm text-brand-warm mt-1">We reply within 24 hours</p>
                </div>
              </div>

              <!-- Business Hours -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-brand-blue bg-opacity-30 rounded-lg flex items-center justify-center flex-shrink-0">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold mb-1">Business Hours</h3>
                  <div class="text-brand-warm text-sm space-y-1">
                    <p>Monday - Friday: 8:00 AM - 6:00 PM</p>
                    <p>Saturday: 10:00 AM - 2:00 PM</p>
                    <p>Sunday: Closed</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Map Placeholder -->
          <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="aspect-video bg-gradient-to-br from-brand-gray-light to-gray-300 flex items-center justify-center relative">
              <!-- Google Maps Placeholder -->
              <div class="text-center p-8">
                <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                <p class="text-gray-600 font-semibold mb-2">Map Location</p>
                <p class="text-sm text-gray-500">Google Maps integration placeholder</p>
                <a 
                  href="https://maps.google.com/?q=Lichtwerbung+Strasse+42+10115+Berlin+Germany" 
                  target="_blank"
                  class="inline-block mt-4 px-4 py-2 bg-brand-blue text-white rounded-lg hover:bg-opacity-90 transition-all text-sm font-semibold"
                >
                  Open in Google Maps
                </a>
              </div>
            </div>
          </div>

          <!-- Social Media Links -->
          <div class="bg-white rounded-lg shadow-lg p-8">
            <h2 class="text-xl font-bold mb-4 font-accent text-brand-navy">Follow Us</h2>
            <p class="text-gray-600 mb-6">Stay connected and see our latest projects</p>
            
            <div class="flex gap-4">
              <!-- Facebook -->
              <a 
                href="#" 
                class="w-12 h-12 bg-brand-blue bg-opacity-10 hover:bg-brand-blue hover:text-white text-brand-blue rounded-lg flex items-center justify-center transition-all duration-300 hover:shadow-glow-blue"
                aria-label="Facebook"
              >
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                </svg>
              </a>

              <!-- Instagram -->
              <a 
                href="#" 
                class="w-12 h-12 bg-brand-pink bg-opacity-10 hover:bg-brand-pink hover:text-white text-brand-pink rounded-lg flex items-center justify-center transition-all duration-300 hover:shadow-glow-pink"
                aria-label="Instagram"
              >
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                </svg>
              </a>

              <!-- LinkedIn -->
              <a 
                href="#" 
                class="w-12 h-12 bg-brand-navy bg-opacity-10 hover:bg-brand-navy hover:text-white text-brand-navy rounded-lg flex items-center justify-center transition-all duration-300"
                aria-label="LinkedIn"
              >
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                </svg>
              </a>

              <!-- YouTube -->
              <a 
                href="#" 
                class="w-12 h-12 bg-red-100 hover:bg-red-600 hover:text-white text-red-600 rounded-lg flex items-center justify-center transition-all duration-300"
                aria-label="YouTube"
              >
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Links / FAQ Section -->
      <div class="mt-16 bg-brand-gray-light rounded-lg p-8">
        <h2 class="text-2xl font-bold text-center mb-8 font-accent text-brand-navy">
          Need Quick Answers?
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
          <router-link 
            to="/products" 
            class="bg-white rounded-lg p-6 text-center hover:shadow-glow-blue transition-all duration-300 group"
          >
            <div class="w-16 h-16 mx-auto mb-4 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center group-hover:bg-brand-blue group-hover:bg-opacity-100 transition-all">
              <svg class="w-8 h-8 text-brand-blue group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
            </div>
            <h3 class="font-bold text-lg mb-2 text-brand-navy">Browse Products</h3>
            <p class="text-sm text-gray-600">Explore our full range of illuminated signage</p>
          </router-link>

          <router-link 
            to="/portfolio" 
            class="bg-white rounded-lg p-6 text-center hover:shadow-glow-blue transition-all duration-300 group"
          >
            <div class="w-16 h-16 mx-auto mb-4 bg-brand-pink bg-opacity-10 rounded-full flex items-center justify-center group-hover:bg-brand-pink group-hover:bg-opacity-100 transition-all">
              <svg class="w-8 h-8 text-brand-pink group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>
            </div>
            <h3 class="font-bold text-lg mb-2 text-brand-navy">View Portfolio</h3>
            <p class="text-sm text-gray-600">See our completed projects and case studies</p>
          </router-link>

          <router-link 
            to="/about" 
            class="bg-white rounded-lg p-6 text-center hover:shadow-glow-blue transition-all duration-300 group"
          >
            <div class="w-16 h-16 mx-auto mb-4 bg-brand-yellow bg-opacity-20 rounded-full flex items-center justify-center group-hover:bg-brand-yellow group-hover:bg-opacity-100 transition-all">
              <svg class="w-8 h-8 text-brand-yellow group-hover:text-brand-navy transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="font-bold text-lg mb-2 text-brand-navy">About Us</h3>
            <p class="text-sm text-gray-600">Learn more about our company and team</p>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const router = useRouter()

// Form state
const form = ref({
  name: '',
  email: '',
  phone: '',
  subject: '',
  message: ''
})

const isSubmitting = ref(false)
const formStatus = ref<'idle' | 'success' | 'error'>('idle')
const errorMessage = ref('')

// Submit form
const submitForm = async () => {
  isSubmitting.value = true
  formStatus.value = 'idle'
  errorMessage.value = ''

  try {
    // TODO: Implement actual form submission to backend/email service
    // For now, simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500))

    // Simulate success
    formStatus.value = 'success'
    
    // Reset form
    form.value = {
      name: '',
      email: '',
      phone: '',
      subject: '',
      message: ''
    }

    // Auto-hide success message after 5 seconds
    setTimeout(() => {
      if (formStatus.value === 'success') {
        formStatus.value = 'idle'
      }
    }, 5000)

  } catch (error) {
    console.error('Form submission error:', error)
    formStatus.value = 'error'
    errorMessage.value = 'An unexpected error occurred. Please try again.'
  } finally {
    isSubmitting.value = false
  }
}
</script>
