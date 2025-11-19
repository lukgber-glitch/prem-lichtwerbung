<template>
  <header class="sticky top-0 z-50 bg-white shadow-md">
    <!-- Desktop Navigation -->
    <nav class="hidden lg:block border-b border-gray-200">
      <div class="container mx-auto px-4">
        <div class="flex items-center justify-between h-20">
          <!-- Logo -->
          <router-link to="/" class="flex items-center gap-3 group">
            <div class="w-12 h-12 bg-gradient-to-br from-brand-blue to-brand-pink rounded-lg flex items-center justify-center transform group-hover:scale-110 transition-transform duration-300">
              <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
              </svg>
            </div>
            <div>
              <div class="font-accent font-bold text-xl text-brand-navy">Prem-Lichtwerbung</div>
              <div class="text-xs text-brand-blue">Your Brand Deserves to Shine</div>
            </div>
          </router-link>

          <!-- Main Navigation Links -->
          <div class="flex items-center gap-8">
            <router-link
              v-for="link in navLinks"
              :key="link.path"
              :to="link.path"
              :class="[
                'font-semibold transition-colors duration-300 hover:text-brand-blue',
                isActive(link.path) ? 'text-brand-blue' : 'text-brand-navy'
              ]"
            >
              {{ link.label }}
            </router-link>
          </div>

          <!-- Right Actions -->
          <div class="flex items-center gap-4">
            <!-- Search Bar -->
            <div class="relative">
              <input
                v-model="searchQuery"
                type="search"
                placeholder="Search products..."
                class="w-64 px-4 py-2 pl-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue transition-all"
                @keypress.enter="handleSearch"
              />
              <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>

            <!-- Cart Icon -->
            <router-link
              to="/cart"
              class="relative p-2 hover:bg-brand-gray-light rounded-lg transition-colors"
            >
              <svg class="w-6 h-6 text-brand-navy" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
              <span
                v-if="cartItemCount > 0"
                class="absolute -top-1 -right-1 w-5 h-5 bg-brand-pink text-white text-xs font-bold rounded-full flex items-center justify-center"
              >
                {{ cartItemCount }}
              </span>
            </router-link>

            <!-- User Account -->
            <router-link
              to="/account"
              class="p-2 hover:bg-brand-gray-light rounded-lg transition-colors"
            >
              <svg class="w-6 h-6 text-brand-navy" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
            </router-link>
          </div>
        </div>
      </div>
    </nav>

    <!-- Mobile Navigation -->
    <nav class="lg:hidden">
      <div class="flex items-center justify-between h-16 px-4">
        <!-- Mobile Menu Button -->
        <button
          @click="isMobileMenuOpen = true"
          class="p-2 hover:bg-brand-gray-light rounded-lg transition-colors"
          aria-label="Open menu"
        >
          <svg class="w-6 h-6 text-brand-navy" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>

        <!-- Mobile Logo -->
        <router-link to="/" class="flex items-center gap-2">
          <div class="w-10 h-10 bg-gradient-to-br from-brand-blue to-brand-pink rounded-lg flex items-center justify-center">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
            </svg>
          </div>
          <span class="font-accent font-bold text-lg text-brand-navy">Prem</span>
        </router-link>

        <!-- Mobile Cart Icon -->
        <router-link
          to="/cart"
          class="relative p-2 hover:bg-brand-gray-light rounded-lg transition-colors"
        >
          <svg class="w-6 h-6 text-brand-navy" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
          </svg>
          <span
            v-if="cartItemCount > 0"
            class="absolute -top-1 -right-1 w-5 h-5 bg-brand-pink text-white text-xs font-bold rounded-full flex items-center justify-center"
          >
            {{ cartItemCount }}
          </span>
        </router-link>
      </div>

      <!-- Mobile Search Bar -->
      <div class="px-4 pb-3">
        <div class="relative">
          <input
            v-model="searchQuery"
            type="search"
            placeholder="Search products..."
            class="w-full px-4 py-2 pl-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
            @keypress.enter="handleSearch"
          />
          <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </div>
      </div>
    </nav>

    <!-- Mobile Slide-Out Menu -->
    <Transition
      enter-active-class="transition-all duration-300 ease-out"
      leave-active-class="transition-all duration-300 ease-in"
      enter-from-class="-translate-x-full"
      enter-to-class="translate-x-0"
      leave-from-class="translate-x-0"
      leave-to-class="-translate-x-full"
    >
      <div
        v-if="isMobileMenuOpen"
        class="fixed inset-y-0 left-0 w-80 max-w-full bg-white shadow-2xl z-50 lg:hidden overflow-y-auto"
      >
        <!-- Menu Header -->
        <div class="bg-gradient-to-r from-brand-navy to-brand-blue p-6">
          <div class="flex items-center justify-between mb-4">
            <div class="flex items-center gap-3">
              <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
                </svg>
              </div>
              <div>
                <div class="font-accent font-bold text-lg text-white">Prem-Lichtwerbung</div>
                <div class="text-xs text-brand-warm">Menu</div>
              </div>
            </div>
            <button
              @click="isMobileMenuOpen = false"
              class="p-2 hover:bg-white hover:bg-opacity-20 rounded-lg transition-colors"
              aria-label="Close menu"
            >
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>

        <!-- Navigation Links -->
        <div class="py-4">
          <router-link
            v-for="link in navLinks"
            :key="link.path"
            :to="link.path"
            @click="isMobileMenuOpen = false"
            :class="[
              'flex items-center gap-3 px-6 py-4 font-semibold transition-colors duration-300',
              isActive(link.path)
                ? 'bg-brand-blue bg-opacity-10 text-brand-blue border-l-4 border-brand-blue'
                : 'text-brand-navy hover:bg-brand-gray-light'
            ]"
          >
            <component :is="link.icon" class="w-6 h-6" />
            {{ link.label }}
          </router-link>
        </div>

        <!-- User Section -->
        <div class="border-t border-gray-200 py-4">
          <router-link
            to="/account"
            @click="isMobileMenuOpen = false"
            class="flex items-center gap-3 px-6 py-4 text-brand-navy hover:bg-brand-gray-light transition-colors"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
            </svg>
            <span class="font-semibold">My Account</span>
          </router-link>
        </div>

        <!-- Social Media Links -->
        <div class="border-t border-gray-200 p-6">
          <p class="text-sm font-semibold text-gray-600 mb-4">Follow Us</p>
          <div class="flex gap-3">
            <a
              href="#"
              class="w-10 h-10 bg-brand-blue bg-opacity-10 hover:bg-brand-blue hover:text-white text-brand-blue rounded-lg flex items-center justify-center transition-all"
              aria-label="Facebook"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
              </svg>
            </a>
            <a
              href="#"
              class="w-10 h-10 bg-brand-pink bg-opacity-10 hover:bg-brand-pink hover:text-white text-brand-pink rounded-lg flex items-center justify-center transition-all"
              aria-label="Instagram"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
              </svg>
            </a>
            <a
              href="#"
              class="w-10 h-10 bg-brand-navy bg-opacity-10 hover:bg-brand-navy hover:text-white text-brand-navy rounded-lg flex items-center justify-center transition-all"
              aria-label="LinkedIn"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
              </svg>
            </a>
          </div>
        </div>

        <!-- Contact Info -->
        <div class="border-t border-gray-200 p-6 bg-brand-gray-light">
          <p class="text-sm font-semibold text-gray-600 mb-3">Need Help?</p>
          <div class="space-y-2 text-sm text-gray-700">
            <a href="tel:+4930123456789" class="flex items-center gap-2 hover:text-brand-blue transition-colors">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
              </svg>
              +49 30 123 456 789
            </a>
            <a href="mailto:info@prem-lichtwerbung.de" class="flex items-center gap-2 hover:text-brand-blue transition-colors">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
              </svg>
              info@prem-lichtwerbung.de
            </a>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Mobile Menu Backdrop -->
    <Transition
      enter-active-class="transition-opacity duration-300"
      leave-active-class="transition-opacity duration-300"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="isMobileMenuOpen"
        class="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden"
        @click="isMobileMenuOpen = false"
      ></div>
    </Transition>
  </header>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useCartStore } from '@/store/cart'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()

// State
const isMobileMenuOpen = ref(false)
const searchQuery = ref('')

// Navigation links
const navLinks = [
  {
    path: '/',
    label: 'Home',
    icon: 'HomeIcon'
  },
  {
    path: '/products',
    label: 'Products',
    icon: 'ShoppingBagIcon'
  },
  {
    path: '/categories',
    label: 'Categories',
    icon: 'ViewGridIcon'
  },
  {
    path: '/portfolio',
    label: 'Portfolio',
    icon: 'PhotographIcon'
  },
  {
    path: '/about',
    label: 'About',
    icon: 'InformationCircleIcon'
  },
  {
    path: '/contact',
    label: 'Contact',
    icon: 'MailIcon'
  }
]

// Cart item count
const cartItemCount = computed(() => cartStore.totalItems)

// Check if route is active
const isActive = (path: string) => {
  if (path === '/') {
    return route.path === '/'
  }
  return route.path.startsWith(path)
}

// Handle search
const handleSearch = () => {
  if (searchQuery.value.trim()) {
    router.push({ path: '/products', query: { search: searchQuery.value } })
    searchQuery.value = ''
    isMobileMenuOpen.value = false
  }
}
</script>
