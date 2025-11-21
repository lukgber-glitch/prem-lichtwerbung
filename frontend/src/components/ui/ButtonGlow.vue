<template>
  <button 
    :class="[
      'px-12 py-5 text-lg font-semibold transition-all duration-500',
      variant === 'primary' 
        ? 'bg-transparent border-2 border-black text-black hover:bg-black hover:text-white' 
        : 'bg-transparent border-2 border-white text-white hover:bg-white hover:text-black'
    ]"
  >
    <slot />
  </button>
</template>

<script setup lang="ts">
defineProps<{
  variant?: 'primary' | 'secondary'
}>()
</script>
