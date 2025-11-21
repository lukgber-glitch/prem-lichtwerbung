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
            {{ t('footer.companyTagline') }}
          </p>
          <p class="text-sm text-text-muted">
            {{ t('footer.yearsExperience') }}
          </p>
        </div>
        
        <!-- Quick Links -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">{{ t('footer.quickLinks') }}</h4>
          <ul class="space-y-2 text-sm">
            <li>
              <router-link to="/" class="hover:text-primary transition-colors cursor-pointer">{{ t('nav.home') }}</router-link>
            </li>
            <li>
              <router-link to="/products" class="hover:text-primary transition-colors cursor-pointer">{{ t('nav.products') }}</router-link>
            </li>
            <li>
              <router-link to="/portfolio" class="hover:text-primary transition-colors cursor-pointer">{{ t('nav.portfolio') }}</router-link>
            </li>
            <li>
              <router-link to="/about" class="hover:text-primary transition-colors cursor-pointer">{{ t('nav.about') }}</router-link>
            </li>
            <li>
              <router-link to="/contact" class="hover:text-primary transition-colors cursor-pointer">{{ t('nav.contact') }}</router-link>
            </li>
          </ul>
        </div>
        
        <!-- Categories -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">{{ t('footer.categoriesTitle') }}</h4>
          <ul class="space-y-2 text-sm">
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">{{ t('categories.lightboxes') }}</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">{{ t('categories.channelLetters') }}</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">{{ t('categories.ledNeonSigns') }}</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">{{ t('categories.pylonsTotems') }}</a></li>
            <li><a href="#" class="hover:text-primary transition-colors cursor-pointer">{{ t('categories.windowSigns') }}</a></li>
          </ul>
        </div>
        
        <!-- Contact -->
        <div>
          <h4 class="text-lg font-bold text-primary mb-4">{{ t('footer.contact') }}</h4>
          <ul class="space-y-2 text-sm">
            <li class="flex items-center gap-2">
              <Mail :size="20" :stroke-width="1.5" class="text-primary" />
              <span>info@prem-lichtwerbung.de</span>
            </li>
            <li class="flex items-center gap-2">
              <Phone :size="20" :stroke-width="1.5" class="text-primary" />
              <span>+49 123 456 789</span>
            </li>
            <li class="flex items-center gap-2">
              <MapPin :size="20" :stroke-width="1.5" class="text-primary" />
              <span>{{ t('footer.location') }}</span>
            </li>
            <li class="pt-4">
              <div class="flex gap-4">
                <a href="#" class="hover:text-primary transition-colors cursor-pointer" aria-label="Facebook">
                  <Facebook :size="24" :stroke-width="1.5" />
                </a>
                <a href="#" class="hover:text-primary transition-colors cursor-pointer" aria-label="Instagram">
                  <Instagram :size="24" :stroke-width="1.5" />
                </a>
                <a href="#" class="hover:text-primary transition-colors cursor-pointer" aria-label="Twitter">
                  <Twitter :size="24" :stroke-width="1.5" />
                </a>
              </div>
            </li>
          </ul>
        </div>
        
      </div>
      
      <!-- Copyright -->
      <div class="border-t border-primary/20 mt-8 pt-8 text-center text-sm text-text-muted">
        <p>&copy; {{ new Date().getFullYear() }} Prem-Lichtwerbung. {{ t('footer.copyright') }}</p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { Mail, Phone, MapPin, Facebook, Instagram, Twitter } from 'lucide-vue-next'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
</script>
