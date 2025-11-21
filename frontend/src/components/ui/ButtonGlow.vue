<template>
  <button
    :class="[
      'px-8 py-4 font-semibold transition-all duration-500 ease-omnicom cursor-pointer',
      'disabled:cursor-not-allowed disabled:opacity-40',
      'focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-black',
      variantClasses,
      $attrs.class
    ]"
    :disabled="disabled"
  >
    <slot></slot>
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  variant?: 'primary' | 'secondary' | 'ghost'
  disabled?: boolean
}>()

const variantClasses = computed(() => {
  switch (props.variant) {
    case 'primary':
      // Solid black button with white text, inverts on hover
      return 'bg-black text-white border-2 border-black hover:bg-white hover:text-black'
    case 'secondary':
      // White/transparent button with black border, inverts on hover
      return 'bg-white text-black border-2 border-black hover:bg-black hover:text-white'
    case 'ghost':
      // Fully transparent with border only, inverts on hover
      return 'bg-transparent text-black border-2 border-black hover:bg-black hover:text-white'
    default:
      // Default to ghost style
      return 'bg-transparent text-black border-2 border-black hover:bg-black hover:text-white'
  }
})
</script>
