<template>
  <footer class="bg-surface text-text-main py-12 mt-auto">
    <div class="container mx-auto px-6">
      <div class="grid md:grid-cols-4 gap-8">
        
        <!-- Company Info -->
        <div>
          <h3 class="text-2xl font-heading font-bold text-primary mb-4">
            Prem-Lichtwerbung
          </h3>
          <p class="text-sm mb-4">
            Premium illuminated signage for professional visibility.
          </p>
          <p class="text-sm text-text-muted">
            15+ years of excellence
          </p>
        </div>
        
        <!-- Quick Links -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">Quick Links</h4>
          <ul class="space-y-2 text-sm">
            <li>
              <router-link to="/" class="hover:text-primary transition-colors cursor-pointer">Home</router-link>
            </li>
            <li>
              <router-link to="/products" class="hover:text-primary transition-colors cursor-pointer">Products</router-link>
            </li>
            <li>
              <router-link to="/portfolio" class="hover:text-primary transition-colors cursor-pointer">Portfolio</router-link>
            </li>
            <li>
              <router-link to="/about" class="hover:text-primary transition-colors cursor-pointer">About Us</router-link>
            </li>
            <li>
              <router-link to="/contact" class="hover:text-primary transition-colors cursor-pointer">Contact</router-link>
            </li>
          </ul>
        </div>
        
        <!-- Categories -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">Categories</h4>
          <ul class="space-y-2 text-sm">
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">Lightboxes</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">Channel Letters</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">LED Neon Signs</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">Pylons & Totems</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">Window Signs</a></li>
          </ul>
        </div>
        
        <!-- Contact -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">Contact</h4>
          <ul class="space-y-2 text-sm">
            <li>📧 info@prem-lichtwerbung.de</li>
            <li>📞 +49 123 456 789</li>
            <li>📍 Berlin, Germany</li>
            <li class="pt-4">
              <div class="flex gap-4">
                <a href="#" class="text-2xl hover:text-primary transition-colors cursor-pointer">📘</a>
                <a href="#" class="text-2xl hover:text-primary transition-colors cursor-pointer">📷</a>
                <a href="#" class="text-2xl hover:text-primary transition-colors cursor-pointer">🐦</a>
              </div>
            </li>
          </ul>
        </div>
        
      </div>
      
      <!-- Copyright -->
      <div class="border-t border-primary/20 mt-8 pt-8 text-center text-sm text-text-muted">
        <p>&copy; {{ new Date().getFullYear() }} Prem-Lichtwerbung. All rights reserved.</p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
// No logic needed for now
</script>
