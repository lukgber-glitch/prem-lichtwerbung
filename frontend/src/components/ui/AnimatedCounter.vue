<template>
  <div ref="counterRef" class="text-center">
    <div class="text-5xl md:text-7xl font-accent font-bold text-brand-blue text-glow mb-2 transition-all duration-300">
      {{ Math.floor(displayValue) }}{{ suffix }}
    </div>
    <div class="text-lg md:text-xl text-brand-warm">{{ label }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const props = defineProps<{
  targetValue: number
  suffix?: string
  label: string
  duration?: number
}>()

const displayValue = ref(0)
const counterRef = ref<HTMLElement | null>(null)

const animateValue = () => {
  const duration = props.duration || 2000
  const increment = props.targetValue / (duration / 16)
  
  const animate = () => {
    displayValue.value += increment
    
    if (displayValue.value < props.targetValue) {
      requestAnimationFrame(animate)
    } else {
      displayValue.value = props.targetValue
    }
  }
  
  animate()
}

onMounted(() => {
  if (!counterRef.value) return
  
  const observer = new IntersectionObserver((entries) => {
    if (entries[0].isIntersecting) {
      animateValue()
      observer.disconnect()
    }
  })
  
  observer.observe(counterRef.value)
})
</script>
