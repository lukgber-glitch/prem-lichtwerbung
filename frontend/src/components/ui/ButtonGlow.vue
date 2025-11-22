<template>
  <button 
    :class="[
      'px-12 py-5 text-lg font-semibold transition-all duration-500 focus:outline-none focus:ring-2 focus:ring-offset-2',
      disabled && 'opacity-50 cursor-not-allowed',
      classes
    ]"
    :style="computedStyle"
    :disabled="disabled"
  >
    <slot />
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  variant?: 'primary' | 'secondary' | 'ghost'
  usePageAccent?: boolean
  disabled?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  usePageAccent: false,
  disabled: false
})

const classes = computed(() => {
  if (props.usePageAccent) {
    // Accent-aware variants
    switch (props.variant) {
      case 'secondary':
        return 'bg-transparent border-2 text-[color:var(--page-accent)] hover:bg-[color:var(--page-accent)] hover:text-omnicom-white'
      case 'ghost':
        return 'bg-transparent text-[color:var(--page-accent)] hover:bg-omnicom-gray-100'
      default:
        // primary
        return 'text-omnicom-white border-2 hover:opacity-90'
    }
  }
  // Monochrome defaults (fallback)
  if (props.variant === 'secondary') {
    return 'bg-transparent border-2 border-omnicom-white text-omnicom-white hover:bg-omnicom-white hover:text-omnicom-black'
  }
  if (props.variant === 'ghost') {
    return 'bg-transparent border-2 border-omnicom-black text-omnicom-black hover:bg-omnicom-black hover:text-omnicom-white'
  }
  // primary default (black)
  return 'bg-transparent border-2 border-omnicom-black text-omnicom-black hover:bg-omnicom-black hover:text-omnicom-white'
})

const computedStyle = computed(() => {
  if (!props.usePageAccent) {
    return { }
  }
  // Provide inline colors so arbitrary value support is not required
  if (props.variant === 'secondary') {
    return {
      borderColor: 'var(--page-accent)',
      color: 'var(--page-accent)',
      // ring color via CSS variable
      '--tw-ring-color': 'var(--page-accent)'
    } as any
  }
  if (props.variant === 'ghost') {
    return {
      color: 'var(--page-accent)',
      '--tw-ring-color': 'var(--page-accent)'
    } as any
  }
  // primary
  return {
    backgroundColor: 'var(--page-accent)',
    borderColor: 'var(--page-accent)',
    '--tw-ring-color': 'var(--page-accent)'
  } as any
})
</script>
