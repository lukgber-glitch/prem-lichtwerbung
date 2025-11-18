<template>
  <div>
    <!-- Hero Section -->
    <section class="bg-gradient-to-r from-primary-600 to-primary-800 text-white py-20">
      <div class="container mx-auto px-4 text-center">
        <h1 class="text-4xl md:text-6xl font-bold mb-4">Welcome to Webshop</h1>
        <p class="text-xl md:text-2xl mb-8">Discover amazing products at great prices</p>
        <router-link to="/products" class="btn-primary bg-white text-primary-600 hover:bg-gray-100 inline-block px-8 py-3 rounded-lg font-semibold">
          Shop Now
        </router-link>
      </div>
    </section>

    <!-- Featured Products -->
    <section class="container mx-auto px-4 py-16">
      <h2 class="text-3xl font-bold mb-8 text-center">Featured Products</h2>
      
      <div v-if="productsStore.loading" class="text-center py-12">
        <p class="text-gray-600">Loading products...</p>
      </div>

      <div v-else-if="productsStore.error" class="text-center py-12">
        <p class="text-red-600">{{ productsStore.error }}</p>
      </div>

      <div v-else-if="productsStore.products.length === 0" class="text-center py-12">
        <p class="text-gray-600">No featured products available.</p>
      </div>

      <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <div 
          v-for="product in productsStore.products" 
          :key="product.id"
          class="card hover:shadow-lg transition-shadow duration-200"
        >
          <div class="aspect-square bg-gray-200 flex items-center justify-center">
            <span class="text-gray-400">No Image</span>
          </div>
          <div class="p-4">
            <h3 class="font-semibold text-lg mb-2 line-clamp-2">{{ product.name }}</h3>
            <p class="text-gray-600 text-sm mb-3 line-clamp-2">{{ product.description }}</p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-2xl font-bold text-primary-600">${{ product.price }}</span>
                <span v-if="product.compare_at_price" class="text-sm text-gray-500 line-through ml-2">
                  ${{ product.compare_at_price }}
                </span>
              </div>
            </div>
            <div class="mt-4 flex gap-2">
              <router-link 
                :to="`/products/${product.slug}`" 
                class="flex-1 text-center btn-secondary text-sm"
              >
                View
              </router-link>
              <button 
                @click="addToCart(product)" 
                class="flex-1 btn-primary text-sm"
              >
                Add to Cart
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="bg-gray-100 py-16">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
          <div>
            <div class="text-primary-600 text-4xl mb-4">🚚</div>
            <h3 class="text-xl font-semibold mb-2">Free Shipping</h3>
            <p class="text-gray-600">On orders over $100</p>
          </div>
          <div>
            <div class="text-primary-600 text-4xl mb-4">🔒</div>
            <h3 class="text-xl font-semibold mb-2">Secure Payment</h3>
            <p class="text-gray-600">100% secure transactions</p>
          </div>
          <div>
            <div class="text-primary-600 text-4xl mb-4">⭐</div>
            <h3 class="text-xl font-semibold mb-2">Quality Products</h3>
            <p class="text-gray-600">Carefully selected items</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { useProductsStore } from '@/store/products'
import { useCartStore } from '@/store/cart'

const productsStore = useProductsStore()
const cartStore = useCartStore()

onMounted(async () => {
  await productsStore.fetchFeaturedProducts(8)
})

const addToCart = (product: any) => {
  cartStore.addItem(product, 1)
}
</script>
