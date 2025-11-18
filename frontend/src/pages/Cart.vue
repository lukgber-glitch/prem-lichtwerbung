<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8">Shopping Cart</h1>
    <p class="text-gray-600">Cart items: {{ cartStore.itemCount }}</p>
  </div>
</template>

<script setup lang="ts">
import { useCartStore } from '@/store/cart'
const cartStore = useCartStore()
</script>
