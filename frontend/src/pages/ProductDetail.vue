<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Loading State -->
    <div v-if="productsStore.loading" class="text-center py-12">
      <div class="inline-block animate-spin rounded-full h-16 w-16 border-b-2 border-primary-600"></div>
      <p class="text-gray-600 mt-4">Loading product details...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="productsStore.error" class="text-center py-12">
      <p class="text-red-600 text-xl mb-4">{{ productsStore.error }}</p>
      <p class="text-gray-600 mb-6">The product you're looking for could not be found.</p>
      <router-link to="/products" class="btn-primary">
        Back to Products
      </router-link>
    </div>

    <!-- Product Details -->
    <div v-else-if="productsStore.currentProduct" class="max-w-6xl mx-auto">
      <!-- Breadcrumb -->
      <nav class="mb-8 text-sm text-gray-600">
        <router-link to="/" class="hover:text-primary-600">Home</router-link>
        <span class="mx-2">/</span>
        <router-link to="/products" class="hover:text-primary-600">Products</router-link>
        <span class="mx-2">/</span>
        <span class="text-gray-900">{{ productsStore.currentProduct.name }}</span>
      </nav>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Product Image -->
        <div class="aspect-square bg-gray-200 flex items-center justify-center rounded-lg">
          <span class="text-gray-400 text-xl">No Image</span>
        </div>

        <!-- Product Info -->
        <div>
          <h1 class="text-3xl md:text-4xl font-bold mb-4">{{ productsStore.currentProduct.name }}</h1>
          
          <!-- Price -->
          <div class="mb-6">
            <span class="text-4xl font-bold text-primary-600">${{ productsStore.currentProduct.price }}</span>
            <span v-if="productsStore.currentProduct.compare_at_price" class="text-xl text-gray-500 line-through ml-3">
              ${{ productsStore.currentProduct.compare_at_price }}
            </span>
            <span v-if="productsStore.currentProduct.compare_at_price" class="ml-3 text-green-600 font-semibold">
              Save ${{ (productsStore.currentProduct.compare_at_price - productsStore.currentProduct.price).toFixed(2) }}
            </span>
          </div>

          <!-- Description -->
          <div class="mb-6">
            <h2 class="text-xl font-semibold mb-2">Description</h2>
            <p class="text-gray-700 leading-relaxed">{{ productsStore.currentProduct.description }}</p>
          </div>

          <!-- Stock Status -->
          <div class="mb-6">
            <span v-if="productsStore.currentProduct.stock && productsStore.currentProduct.stock > 0" class="text-green-600 font-semibold">
              ✓ In Stock ({{ productsStore.currentProduct.stock }} available)
            </span>
            <span v-else class="text-red-600 font-semibold">
              ✗ Out of Stock
            </span>
          </div>

          <!-- Quantity Selector -->
          <div class="mb-6">
            <label class="block text-sm font-semibold mb-2">Quantity</label>
            <div class="flex items-center gap-3">
              <button 
                @click="decreaseQuantity" 
                class="w-10 h-10 border border-gray-300 rounded-lg hover:bg-gray-100 font-semibold"
                :disabled="quantity <= 1"
              >
                -
              </button>
              <input 
                v-model.number="quantity" 
                type="number" 
                min="1" 
                class="w-20 h-10 text-center border border-gray-300 rounded-lg"
              />
              <button 
                @click="increaseQuantity" 
                class="w-10 h-10 border border-gray-300 rounded-lg hover:bg-gray-100 font-semibold"
              >
                +
              </button>
            </div>
          </div>

          <!-- Add to Cart Button -->
          <button 
            @click="handleAddToCart" 
            class="btn-primary w-full md:w-auto px-12 py-4 text-lg"
            :disabled="!productsStore.currentProduct.stock || productsStore.currentProduct.stock <= 0"
          >
            Add to Cart
          </button>

          <!-- Product Meta -->
          <div class="mt-8 pt-8 border-t border-gray-200">
            <div class="grid grid-cols-2 gap-4 text-sm">
              <div>
                <span class="text-gray-600">SKU:</span>
                <span class="ml-2 font-semibold">{{ productsStore.currentProduct.sku || 'N/A' }}</span>
              </div>
              <div>
                <span class="text-gray-600">Status:</span>
                <span class="ml-2 font-semibold capitalize">{{ productsStore.currentProduct.status }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Not Found State -->
    <div v-else class="text-center py-12">
      <p class="text-gray-600 text-xl mb-6">Product not found.</p>
      <router-link to="/products" class="btn-primary">
        Back to Products
      </router-link>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useProductsStore } from '@/store/products'
import { useCartStore } from '@/store/cart'

const route = useRoute()
const productsStore = useProductsStore()
const cartStore = useCartStore()

const quantity = ref(1)

const increaseQuantity = () => {
  quantity.value++
}

const decreaseQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--
  }
}

const handleAddToCart = () => {
  if (productsStore.currentProduct) {
    cartStore.addItem(productsStore.currentProduct, quantity.value)
    quantity.value = 1
  }
}

onMounted(async () => {
  const slug = route.params.slug as string
  await productsStore.fetchProductBySlug(slug)
})
</script>
