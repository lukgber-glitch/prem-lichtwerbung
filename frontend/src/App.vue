<template>
  <div id="app" class="min-h-screen flex flex-col">
    <!-- Header -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
      <div class="container mx-auto px-4 py-4">
        <div class="flex items-center justify-between">
          <!-- Logo -->
          <router-link to="/" class="text-2xl font-bold text-primary-600">
            Webshop
          </router-link>

          <!-- Navigation -->
          <nav class="hidden md:flex items-center space-x-6">
            <router-link to="/" class="text-gray-700 hover:text-primary-600 transition">
              Home
            </router-link>
            <router-link to="/products" class="text-gray-700 hover:text-primary-600 transition">
              Products
            </router-link>
          </nav>

          <!-- Actions -->
          <div class="flex items-center space-x-4">
            <router-link 
              v-if="!authStore.isAuthenticated" 
              to="/login" 
              class="text-gray-700 hover:text-primary-600 transition"
            >
              Login
            </router-link>
            <button 
              v-else 
              @click="handleLogout" 
              class="text-gray-700 hover:text-primary-600 transition"
            >
              Logout
            </button>
            
            <router-link to="/cart" class="relative text-gray-700 hover:text-primary-600 transition">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
              <span 
                v-if="cartStore.itemCount > 0" 
                class="absolute -top-2 -right-2 bg-primary-600 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
              >
                {{ cartStore.itemCount }}
              </span>
            </router-link>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="flex-1">
      <router-view />
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div>
            <h3 class="text-lg font-semibold mb-4">About Webshop</h3>
            <p class="text-gray-400">
              Your one-stop shop for quality products at great prices.
            </p>
          </div>
          <div>
            <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
            <ul class="space-y-2">
              <li><router-link to="/products" class="text-gray-400 hover:text-white transition">Products</router-link></li>
              <li><router-link to="/cart" class="text-gray-400 hover:text-white transition">Cart</router-link></li>
            </ul>
          </div>
          <div>
            <h3 class="text-lg font-semibold mb-4">Contact</h3>
            <p class="text-gray-400">Email: contact@webshop.com</p>
            <p class="text-gray-400">Phone: +1-555-0123</p>
          </div>
        </div>
        <div class="mt-8 pt-8 border-t border-gray-700 text-center text-gray-400">
          <p>&copy; 2025 Webshop. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useCartStore } from '@/store/cart'
import { useAuthStore } from '@/store/auth'
import { useRouter } from 'vue-router'

const cartStore = useCartStore()
const authStore = useAuthStore()
const router = useRouter()

const handleLogout = async () => {
  await authStore.logout()
  router.push('/')
}
</script>
