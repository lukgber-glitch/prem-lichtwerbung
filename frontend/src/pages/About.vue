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
          <li class="text-brand-gray-dark font-semibold">About Us</li>
        </ol>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative bg-gradient-to-br from-brand-navy via-brand-navy to-brand-blue text-brand-warm py-24 overflow-hidden">
      <!-- Animated background glow -->
      <div class="absolute inset-0 opacity-20">
        <div class="absolute top-1/3 left-1/4 w-96 h-96 bg-brand-blue rounded-full blur-3xl animate-pulse"></div>
        <div class="absolute bottom-1/3 right-1/4 w-96 h-96 bg-brand-pink rounded-full blur-3xl animate-pulse" style="animation-delay: 1.5s;"></div>
      </div>
      
      <div class="container mx-auto px-4 text-center relative z-10">
        <h1 class="text-5xl md:text-6xl font-bold mb-6 font-accent">
          Illuminating Brands Since 2009
        </h1>
        <p class="text-xl md:text-2xl max-w-3xl mx-auto">
          We transform businesses into landmarks with premium illuminated signage that captures attention and drives success
        </p>
      </div>
    </section>

    <!-- Company Story -->
    <section class="container mx-auto px-4 py-20">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
        <!-- Story Text -->
        <div class="space-y-6">
          <h2 class="text-4xl font-bold font-accent text-brand-navy mb-6">
            Our Story
          </h2>
          
          <div class="prose prose-lg max-w-none">
            <p class="text-gray-700 leading-relaxed">
              Founded in 2009, Prem-Lichtwerbung was born from a simple vision: to help businesses shine brighter. 
              What started as a small workshop crafting traditional lightboxes has evolved into a leading innovator 
              in illuminated signage technology, serving clients across Europe.
            </p>
            
            <p class="text-gray-700 leading-relaxed">
              Over the past 15 years, we've embraced cutting-edge LED technology, pioneered eco-friendly lighting solutions, 
              and mastered the art of transforming logos and brands into stunning visual landmarks. From sleek LED neon signs 
              to towering illuminated pylons, every project receives our unwavering attention to detail and craftsmanship.
            </p>
            
            <p class="text-gray-700 leading-relaxed">
              Today, with a dedicated team of 25+ designers, fabricators, and installation specialists, we continue to push 
              the boundaries of what's possible in illuminated signage. Our commitment remains unchanged: to deliver quality 
              that not only meets but exceeds expectations, helping your brand stand out day and night.
            </p>
          </div>
        </div>

        <!-- Story Image -->
        <div class="relative">
          <div class="aspect-square rounded-lg overflow-hidden shadow-2xl">
            <img 
              src="https://via.placeholder.com/600x600/0A1628/00D9FF?text=Prem-Lichtwerbung+Workshop"
              alt="Prem-Lichtwerbung Workshop"
              class="w-full h-full object-cover"
            />
          </div>
          <!-- Decorative glow -->
          <div class="absolute -bottom-8 -right-8 w-64 h-64 bg-brand-blue rounded-full blur-3xl opacity-20 -z-10"></div>
        </div>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="bg-gradient-to-r from-brand-blue via-brand-pink to-brand-yellow py-20">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12 text-center text-white">
          <!-- Stat 1 -->
          <div class="relative">
            <div class="text-7xl md:text-8xl font-bold mb-4 font-accent drop-shadow-lg">15+</div>
            <div class="text-2xl font-semibold mb-3">Years of Excellence</div>
            <p class="text-brand-warm text-lg max-w-xs mx-auto">
              Over a decade and a half of illuminating businesses across Europe
            </p>
          </div>

          <!-- Stat 2 -->
          <div class="relative">
            <div class="text-7xl md:text-8xl font-bold mb-4 font-accent drop-shadow-lg">25+</div>
            <div class="text-2xl font-semibold mb-3">Expert Team Members</div>
            <p class="text-brand-warm text-lg max-w-xs mx-auto">
              Designers, fabricators, and installation specialists dedicated to your success
            </p>
          </div>

          <!-- Stat 3 -->
          <div class="relative">
            <div class="text-7xl md:text-8xl font-bold mb-4 font-accent drop-shadow-lg">500+</div>
            <div class="text-2xl font-semibold mb-3">Projects Completed</div>
            <p class="text-brand-warm text-lg max-w-xs mx-auto">
              From small boutiques to major shopping centers, we've lit them all
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Team Section -->
    <section class="container mx-auto px-4 py-20">
      <h2 class="text-4xl font-bold text-center mb-4 font-accent text-brand-navy">
        Meet Our Team
      </h2>
      <p class="text-center text-gray-600 text-lg mb-12 max-w-2xl mx-auto">
        The passionate experts behind every illuminated masterpiece
      </p>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        <!-- Team Member 1 -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-glow-blue transition-all duration-300 group">
          <div class="aspect-square bg-gradient-to-br from-brand-blue to-brand-navy relative overflow-hidden">
            <div class="absolute inset-0 flex items-center justify-center">
              <svg class="w-24 h-24 text-white opacity-50" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          <div class="p-6 text-center">
            <h3 class="text-xl font-bold font-accent text-brand-navy mb-1">Marcus Prem</h3>
            <p class="text-brand-blue font-semibold mb-2">Founder & CEO</p>
            <p class="text-sm text-gray-600">Visionary leader with 15+ years in signage industry</p>
          </div>
        </div>

        <!-- Team Member 2 -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-glow-blue transition-all duration-300 group">
          <div class="aspect-square bg-gradient-to-br from-brand-pink to-brand-navy relative overflow-hidden">
            <div class="absolute inset-0 flex items-center justify-center">
              <svg class="w-24 h-24 text-white opacity-50" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          <div class="p-6 text-center">
            <h3 class="text-xl font-bold font-accent text-brand-navy mb-1">Sarah Mueller</h3>
            <p class="text-brand-blue font-semibold mb-2">Lead Designer</p>
            <p class="text-sm text-gray-600">Creative mastermind behind award-winning signage designs</p>
          </div>
        </div>

        <!-- Team Member 3 -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-glow-blue transition-all duration-300 group">
          <div class="aspect-square bg-gradient-to-br from-brand-yellow to-brand-navy relative overflow-hidden">
            <div class="absolute inset-0 flex items-center justify-center">
              <svg class="w-24 h-24 text-white opacity-50" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          <div class="p-6 text-center">
            <h3 class="text-xl font-bold font-accent text-brand-navy mb-1">Thomas Becker</h3>
            <p class="text-brand-blue font-semibold mb-2">Production Manager</p>
            <p class="text-sm text-gray-600">Quality assurance expert ensuring flawless execution</p>
          </div>
        </div>

        <!-- Team Member 4 -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-glow-blue transition-all duration-300 group">
          <div class="aspect-square bg-gradient-to-br from-brand-blue to-brand-pink relative overflow-hidden">
            <div class="absolute inset-0 flex items-center justify-center">
              <svg class="w-24 h-24 text-white opacity-50" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          <div class="p-6 text-center">
            <h3 class="text-xl font-bold font-accent text-brand-navy mb-1">Lisa Wagner</h3>
            <p class="text-brand-blue font-semibold mb-2">Installation Chief</p>
            <p class="text-sm text-gray-600">Leading our team of professional installation specialists</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Certifications & Awards -->
    <section class="bg-brand-gray-light py-20">
      <div class="container mx-auto px-4">
        <h2 class="text-4xl font-bold text-center mb-4 font-accent text-brand-navy">
          Certifications & Recognition
        </h2>
        <p class="text-center text-gray-600 text-lg mb-12">
          Trusted and certified for excellence in quality and safety
        </p>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <!-- Certification 1 -->
          <div class="bg-white rounded-lg shadow-md p-8 text-center hover:shadow-glow-blue transition-all duration-300">
            <div class="w-20 h-20 mx-auto mb-4 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center">
              <svg class="w-10 h-10 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
            </div>
            <h3 class="text-lg font-bold mb-2 text-brand-navy">ISO 9001 Certified</h3>
            <p class="text-sm text-gray-600">Quality management systems certification</p>
          </div>

          <!-- Certification 2 -->
          <div class="bg-white rounded-lg shadow-md p-8 text-center hover:shadow-glow-blue transition-all duration-300">
            <div class="w-20 h-20 mx-auto mb-4 bg-brand-pink bg-opacity-10 rounded-full flex items-center justify-center">
              <svg class="w-10 h-10 text-brand-pink" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
            </div>
            <h3 class="text-lg font-bold mb-2 text-brand-navy">CE Certified</h3>
            <p class="text-sm text-gray-600">European safety and compliance standards</p>
          </div>

          <!-- Certification 3 -->
          <div class="bg-white rounded-lg shadow-md p-8 text-center hover:shadow-glow-blue transition-all duration-300">
            <div class="w-20 h-20 mx-auto mb-4 bg-brand-yellow bg-opacity-20 rounded-full flex items-center justify-center">
              <svg class="w-10 h-10 text-brand-yellow" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="text-lg font-bold mb-2 text-brand-navy">Eco-Friendly</h3>
            <p class="text-sm text-gray-600">Sustainable practices and LED technology</p>
          </div>

          <!-- Award -->
          <div class="bg-white rounded-lg shadow-md p-8 text-center hover:shadow-glow-blue transition-all duration-300">
            <div class="w-20 h-20 mx-auto mb-4 bg-brand-blue bg-opacity-10 rounded-full flex items-center justify-center">
              <svg class="w-10 h-10 text-brand-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
              </svg>
            </div>
            <h3 class="text-lg font-bold mb-2 text-brand-navy">Industry Award</h3>
            <p class="text-sm text-gray-600">Best Signage Company 2023</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Manufacturing Process -->
    <section class="container mx-auto px-4 py-20">
      <h2 class="text-4xl font-bold text-center mb-4 font-accent text-brand-navy">
        Our Manufacturing Process
      </h2>
      <p class="text-center text-gray-600 text-lg mb-12 max-w-2xl mx-auto">
        From concept to installation, every step is executed with precision and care
      </p>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <!-- Step 1 -->
        <div class="relative">
          <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-glow-blue transition-all duration-300">
            <div class="absolute -top-4 -left-4 w-12 h-12 bg-brand-blue text-white rounded-full flex items-center justify-center text-2xl font-bold font-accent shadow-lg">
              1
            </div>
            <div class="mt-4">
              <h3 class="text-xl font-bold mb-3 text-brand-navy font-accent">Design</h3>
              <p class="text-gray-600 mb-4">
                Our designers work closely with you to create the perfect signage that captures your brand identity
              </p>
              <div class="aspect-video bg-gradient-to-br from-brand-blue to-brand-navy rounded-lg flex items-center justify-center">
                <svg class="w-16 h-16 text-white opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        <!-- Step 2 -->
        <div class="relative">
          <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-glow-blue transition-all duration-300">
            <div class="absolute -top-4 -left-4 w-12 h-12 bg-brand-pink text-white rounded-full flex items-center justify-center text-2xl font-bold font-accent shadow-lg">
              2
            </div>
            <div class="mt-4">
              <h3 class="text-xl font-bold mb-3 text-brand-navy font-accent">Fabrication</h3>
              <p class="text-gray-600 mb-4">
                State-of-the-art machinery and skilled craftsmen bring your design to life with precision
              </p>
              <div class="aspect-video bg-gradient-to-br from-brand-pink to-brand-navy rounded-lg flex items-center justify-center">
                <svg class="w-16 h-16 text-white opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        <!-- Step 3 -->
        <div class="relative">
          <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-glow-blue transition-all duration-300">
            <div class="absolute -top-4 -left-4 w-12 h-12 bg-brand-yellow text-brand-navy rounded-full flex items-center justify-center text-2xl font-bold font-accent shadow-lg">
              3
            </div>
            <div class="mt-4">
              <h3 class="text-xl font-bold mb-3 text-brand-navy font-accent">Quality Check</h3>
              <p class="text-gray-600 mb-4">
                Rigorous testing ensures every product meets our high standards before leaving our facility
              </p>
              <div class="aspect-video bg-gradient-to-br from-brand-yellow to-brand-navy rounded-lg flex items-center justify-center">
                <svg class="w-16 h-16 text-white opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        <!-- Step 4 -->
        <div class="relative">
          <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-glow-blue transition-all duration-300">
            <div class="absolute -top-4 -left-4 w-12 h-12 bg-brand-blue text-white rounded-full flex items-center justify-center text-2xl font-bold font-accent shadow-lg">
              4
            </div>
            <div class="mt-4">
              <h3 class="text-xl font-bold mb-3 text-brand-navy font-accent">Installation</h3>
              <p class="text-gray-600 mb-4">
                Professional installation team ensures your signage is mounted securely and shines perfectly
              </p>
              <div class="aspect-video bg-gradient-to-br from-brand-blue to-brand-pink rounded-lg flex items-center justify-center">
                <svg class="w-16 h-16 text-white opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="bg-gradient-to-r from-brand-navy via-brand-blue to-brand-pink py-20">
      <div class="container mx-auto px-4 text-center">
        <h2 class="text-4xl md:text-5xl font-bold text-white mb-6 font-accent">
          Ready to Make Your Brand Shine?
        </h2>
        <p class="text-xl text-brand-warm mb-10 max-w-2xl mx-auto">
          Let's discuss your project and create signage that turns heads and drives results
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <ButtonGlow variant="accent" @click="$router.push('/contact')" class="text-lg px-8 py-4">
            Get in Touch
          </ButtonGlow>
          <ButtonGlow variant="secondary" @click="$router.push('/products')" class="text-lg px-8 py-4">
            Explore Products
          </ButtonGlow>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'

const router = useRouter()
</script>
