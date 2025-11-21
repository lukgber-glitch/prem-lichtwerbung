<template>
  <button
    :class="[
      'px-6 py-3 rounded-md font-medium transition-all duration-300 ease-out cursor-pointer',
      'disabled:cursor-not-allowed disabled:opacity-50',
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
      return 'bg-primary text-background hover:opacity-90 border-2 border-primary shadow-sm focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2'
    case 'secondary':
      return 'bg-transparent text-primary border-2 border-primary hover:bg-primary hover:text-background focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2'
    case 'ghost':
      return 'bg-transparent text-primary border-2 border-transparent hover:bg-surface focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2'
    default:
      return 'bg-primary text-background hover:opacity-90 border-2 border-primary shadow-sm focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2'
  }
})
</script>
