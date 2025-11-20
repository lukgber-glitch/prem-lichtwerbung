<template>
  <div class="min-h-screen">
    
    <!-- Hero Section -->
    <section class="relative py-32 bg-background overflow-hidden">
      <div class="container mx-auto px-6 text-center">
        <h1 class="text-6xl md:text-8xl font-heading font-bold text-primary mb-6">
          About Prem-Lichtwerbung
        </h1>
        <p class="text-2xl md:text-3xl text-text-main max-w-3xl mx-auto">
          15+ years of making brands <span class="text-primary">stand out</span>
        </p>
      </div>
    </section>
    
    <!-- Our Story -->
    <section class="py-20 bg-surface">
      <div class="container mx-auto px-6">
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <h2 class="text-4xl font-heading font-bold text-text-main mb-6">
              Your Brand Deserves Visibility
            </h2>
            <p class="text-lg text-text-muted mb-4">
              Since 2009, Prem-Lichtwerbung has been crafting premium illuminated signage that transforms businesses into landmarks. What started as a small workshop in Germany has grown into a leading provider of custom lighting solutions across Europe.
            </p>
            <p class="text-lg text-text-muted mb-4">
              We believe every business deserves signage that not only looks incredible but performs flawlessly for years. That's why we use only the highest-quality materials, LED technology, and weatherproof construction in every project.
            </p>
            <p class="text-lg text-text-muted">
              From elegant channel letters to eye-catching LED neon, from towering pylons to sleek lightboxes – we bring your vision to life with precision and passion.
            </p>
          </div>
          <div class="relative">
            <div class="aspect-square rounded-2xl overflow-hidden border-2 border-primary/20 bg-surface-alt">
              <div class="w-full h-full flex items-center justify-center">
                <span class="text-9xl">🏭</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Stats Section -->
    <section class="py-20 bg-background">
      <div class="container mx-auto px-6">
        <div class="grid md:grid-cols-4 gap-8">
          <div class="text-center">
            <AnimatedCounter :target-value="15" suffix="+" label="Years of Excellence" />
          </div>
          <div class="text-center">
            <AnimatedCounter :target-value="500" suffix="+" label="Happy Clients" />
          </div>
          <div class="text-center">
            <AnimatedCounter :target-value="25" label="Team Members" />
          </div>
          <div class="text-center">
            <AnimatedCounter :target-value="98" suffix="%" label="Satisfaction Rate" />
          </div>
        </div>
      </div>
    </section>
    
    <!-- Why Choose Us -->
    <section class="py-20 bg-surface-alt">
      <div class="container mx-auto px-6">
        <h2 class="text-5xl font-heading font-bold text-text-main text-center mb-16">
          Why Choose Prem-Lichtwerbung?
        </h2>
        
        <div class="grid md:grid-cols-3 gap-8">
          
          <div class="bg-surface p-8 rounded-xl border border-primary/20 hover:border-primary transition-all duration-300 group">
            <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mb-6 border border-primary/30">
              <span class="text-5xl group-hover:scale-110 transition-transform">💎</span>
            </div>
            <h3 class="text-2xl font-bold text-text-main mb-4">Premium Quality</h3>
            <p class="text-text-muted">
              We use only the highest-grade materials and LED technology. Every sign is built to last 10+ years with minimal maintenance.
            </p>
          </div>
          
          <div class="bg-surface p-8 rounded-xl border border-accent/20 hover:border-accent transition-all duration-300 group">
            <div class="w-20 h-20 bg-accent/10 rounded-full flex items-center justify-center mb-6 border border-accent/30">
              <span class="text-5xl group-hover:scale-110 transition-transform">🎨</span>
            </div>
            <h3 class="text-2xl font-bold text-text-main mb-4">Custom Design</h3>
            <p class="text-text-muted">
              Every project is unique. Our design team works with you to create signage that perfectly matches your brand identity.
            </p>
          </div>
          
          <div class="bg-surface p-8 rounded-xl border border-primary/20 hover:border-primary transition-all duration-300 group">
            <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mb-6 border border-primary/30">
              <span class="text-5xl group-hover:scale-110 transition-transform">⚡</span>
            </div>
            <h3 class="text-2xl font-bold text-text-main mb-4">Fast Turnaround</h3>
            <p class="text-text-muted">
              Most orders ready in 7-14 days. Need it faster? We offer rush production for urgent projects.
            </p>
          </div>
          
        </div>
      </div>
    </section>
    
    <!-- CTA Section -->
    <section class="py-20 bg-surface">
      <div class="container mx-auto px-6 text-center">
        <h2 class="text-5xl font-heading font-bold text-text-main mb-6">
          Ready to Make Your Brand Visible?
        </h2>
        <p class="text-2xl text-text-muted mb-8">
          Get a free quote and mockup for your project today
        </p>
        <div class="flex flex-col md:flex-row gap-6 justify-center">
          <ButtonGlow variant="primary" class="text-xl px-12 py-5" @click="$router.push('/contact')">
            Request Quote
          </ButtonGlow>
          <ButtonGlow variant="secondary" class="text-xl px-12 py-5" @click="$router.push('/contact')">
            Call Us: +49 123 456 789
          </ButtonGlow>
        </div>
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import AnimatedCounter from '@/components/ui/AnimatedCounter.vue'
</script>
