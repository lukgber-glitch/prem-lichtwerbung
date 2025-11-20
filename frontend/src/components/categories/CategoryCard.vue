<template>
  <router-link
    :to="`/categories/${category.slug}`"
    class="group relative block rounded-lg overflow-hidden shadow-md transition-all duration-300 hover:shadow-glow-blue hover:border-glow h-64"
  >
    <!-- Category Image with Overlay -->
    <div class="relative w-full h-full">
      <img
        :src="category.image || '/placeholder-category.jpg'"
        :alt="category.name"
        loading="lazy"
        class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
      />
      
      <!-- Dark Overlay -->
      <div class="absolute inset-0 bg-gradient-to-t from-brand-navy via-brand-navy/70 to-transparent opacity-80 group-hover:opacity-70 transition-opacity duration-300"></div>
      
      <!-- Electric sparks in corners -->
      <div class="absolute top-2 left-2 w-3 h-3 bg-brand-blue rounded-full opacity-0 group-hover:opacity-100 animate-spark"></div>
      <div class="absolute top-2 right-2 w-3 h-3 bg-brand-pink rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.3s;"></div>
      <div class="absolute bottom-2 left-2 w-3 h-3 bg-brand-yellow rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.6s;"></div>
      <div class="absolute bottom-2 right-2 w-3 h-3 bg-brand-blue rounded-full opacity-0 group-hover:opacity-100 animate-spark" style="animation-delay: 0.9s;"></div>
    </div>

    <!-- Category Info -->
    <div class="absolute bottom-0 left-0 right-0 p-6 text-white">
      <h3 class="font-accent font-bold text-2xl mb-2 group-hover:text-brand-blue group-hover:text-glow-strong transition-all duration-300">
        {{ category.name }}
      </h3>
      
      <p v-if="category.description" class="text-brand-warm text-sm mb-3 line-clamp-2">
        {{ category.description }}
      </p>
      
      <div class="flex items-center gap-2 text-brand-blue">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
        </svg>
        <span class="font-semibold">
          {{ productCount }} {{ productCount === 1 ? 'product' : 'products' }}
        </span>
      </div>
    </div>

    <!-- Hover Arrow -->
    <div class="absolute top-4 right-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
      <div class="bg-brand-blue rounded-full p-2 shadow-glow-blue">
        <svg class="w-6 h-6 text-brand-navy" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
        </svg>
      </div>
    </div>
  </router-link>
</template>

<script setup lang="ts">
interface Category {
  id: number
  slug: string
  name: string
  description?: string
  image?: string
}

const props = defineProps<{
  category: Category
  productCount?: number
}>()

// Default product count to 0 if not provided
const productCount = props.productCount ?? 0
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
