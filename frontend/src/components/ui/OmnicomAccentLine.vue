<template>
  <div 
    class="bg-omnicom-red accent-line"
    :class="sizeClass"
    :style="customColor ? { backgroundColor: customColor } : {}"
  ></div>
  
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  size?: 'sm' | 'md' | 'lg'
  customColor?: string
}

const props = withDefaults(defineProps<Props>(), {
  size: 'md'
})

const sizeClass = computed(() => {
  switch (props.size) {
    case 'sm': return 'w-8 h-[2px]'
    case 'md': return 'w-16 h-[3px]'
    case 'lg': return 'w-24 h-[4px]'
    default: return 'w-16 h-[3px]'
  }
})
</script>
