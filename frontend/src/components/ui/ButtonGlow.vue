<template>
  <button
    :class="[
      'px-6 py-3 rounded-lg font-semibold transition-all duration-300',
      'active:scale-95',
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
      return 'bg-primary text-background hover:bg-primary/90 border-2 border-primary'
    case 'secondary':
      return 'bg-transparent text-text-main border-2 border-text-muted hover:border-primary hover:text-primary'
    case 'accent':
      return 'bg-accent text-background hover:bg-accent/90 border-2 border-accent'
    default:
      return 'bg-primary text-background hover:bg-primary/90 border-2 border-primary'
  }
})
</script>
