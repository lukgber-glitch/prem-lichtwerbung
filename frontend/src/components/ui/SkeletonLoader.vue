<template>
  <div
    :class="[
      'animate-pulse bg-gradient-to-r from-gray-200 via-gray-300 to-gray-200 bg-[length:200%_100%]',
      roundedClass,
      $attrs.class
    ]"
    :style="{ width: width, height: height }"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  variant?: 'text' | 'card' | 'image' | 'circle' | 'button' | 'custom'
  width?: string
  height?: string
  rounded?: 'none' | 'sm' | 'md' | 'lg' | 'full'
}>()

// Determine width based on variant
const width = computed(() => {
  if (props.width) return props.width
  
  switch (props.variant) {
    case 'text':
      return '100%'
    case 'card':
      return '100%'
    case 'image':
      return '100%'
    case 'circle':
      return '3rem'
    case 'button':
      return '8rem'
    default:
      return '100%'
  }
})

// Determine height based on variant
const height = computed(() => {
  if (props.height) return props.height
  
  switch (props.variant) {
    case 'text':
      return '1rem'
    case 'card':
      return '20rem'
    case 'image':
      return '12rem'
    case 'circle':
      return '3rem'
    case 'button':
      return '2.5rem'
    default:
      return '1rem'
  }
})

// Determine border radius based on rounded prop or variant
const roundedClass = computed(() => {
  if (props.rounded) {
    const roundedClasses = {
      'none': 'rounded-none',
      'sm': 'rounded-sm',
      'md': 'rounded-md',
      'lg': 'rounded-lg',
      'full': 'rounded-full'
    }
    return roundedClasses[props.rounded]
  }
  
  // Default rounding based on variant
  switch (props.variant) {
    case 'circle':
      return 'rounded-full'
    case 'card':
    case 'image':
    case 'button':
      return 'rounded-lg'
    case 'text':
      return 'rounded'
    default:
      return 'rounded'
  }
})
</script>

<style scoped>
@keyframes shimmer {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}

.animate-pulse {
  animation: shimmer 2s ease-in-out infinite;
}
</style>
