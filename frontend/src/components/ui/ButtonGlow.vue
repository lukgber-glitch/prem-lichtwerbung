<template>
  <button
    :class="[
      'px-6 py-3 rounded-lg font-semibold transition-all duration-300',
      'hover:shadow-glow-blue active:scale-95',
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
  variant?: 'primary' | 'secondary' | 'accent'
  disabled?: boolean
}>()

const variantClasses = computed(() => {
  switch (props.variant) {
    case 'primary':
      return 'bg-brand-blue text-brand-navy hover:shadow-glow-blue'
    case 'secondary':
      return 'bg-brand-navy text-brand-warm hover:bg-opacity-90'
    case 'accent':
      return 'bg-brand-pink text-white hover:shadow-glow-pink'
    default:
      return 'bg-brand-blue text-brand-navy hover:shadow-glow-blue'
  }
})
</script>
