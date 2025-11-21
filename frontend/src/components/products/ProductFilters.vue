<template>
  <div class="bg-white rounded-lg shadow-md p-6">
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <h3 class="text-xl font-bold text-brand-navy flex items-center gap-2">
        <Filter :size="24" :stroke-width="2" />
        Filters
        <span v-if="activeFilterCount > 0" class="bg-brand-blue text-brand-navy text-xs font-bold px-2 py-1 rounded-full">
          {{ activeFilterCount }}
        </span>
      </h3>
      <button
        v-if="activeFilterCount > 0"
        @click="resetFilters"
        class="text-sm text-brand-pink hover:underline font-semibold"
      >
        Reset All
      </button>
    </div>

    <!-- Price Range -->
    <div class="mb-6">
      <h4 class="font-semibold text-brand-navy mb-3">Price Range</h4>
      <div class="space-y-3">
        <div class="flex items-center gap-3">
          <input
            v-model.number="priceMin"
            type="number"
            min="0"
            max="5000"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
            placeholder="Min"
          />
          <span class="text-gray-500">-</span>
          <input
            v-model.number="priceMax"
            type="number"
            min="0"
            max="5000"
            class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
            placeholder="Max"
          />
        </div>
        <input
          v-model="priceMax"
          type="range"
          min="0"
          max="5000"
          step="50"
          class="w-full accent-brand-blue"
        />
        <div class="flex justify-between text-xs text-gray-500">
          <span>€0</span>
          <span>€5000</span>
        </div>
      </div>
    </div>

    <!-- Illumination Type -->
    <div class="mb-6">
      <button
        @click="toggleSection('illumination')"
        class="w-full flex items-center justify-between font-semibold text-brand-navy mb-3 hover:text-brand-blue transition-colors"
      >
        <span>Illumination Type</span>
        <ChevronDown 
          :size="20" 
          :stroke-width="2"
          class="transition-transform"
          :class="{ 'rotate-180': !expandedSections.illumination }"
        />
      </button>
      <div v-show="expandedSections.illumination" class="space-y-2">
        <label v-for="type in illuminationTypes" :key="type" class="flex items-center gap-2 cursor-pointer hover:text-brand-blue transition-colors">
          <input
            type="checkbox"
            :value="type"
            v-model="selectedIllumination"
            class="w-4 h-4 accent-brand-blue rounded"
          />
          <span class="text-sm">{{ type }}</span>
        </label>
      </div>
    </div>

    <!-- Suitable For -->
    <div class="mb-6">
      <button
        @click="toggleSection('suitable')"
        class="w-full flex items-center justify-between font-semibold text-brand-navy mb-3 hover:text-brand-blue transition-colors"
      >
        <span>Suitable For</span>
        <ChevronDown 
          :size="20" 
          :stroke-width="2"
          class="transition-transform"
          :class="{ 'rotate-180': !expandedSections.suitable }"
        />
      </button>
      <div v-show="expandedSections.suitable" class="space-y-2">
        <label v-for="location in suitableFor" :key="location" class="flex items-center gap-2 cursor-pointer hover:text-brand-blue transition-colors">
          <input
            type="checkbox"
            :value="location"
            v-model="selectedSuitableFor"
            class="w-4 h-4 accent-brand-blue rounded"
          />
          <span class="text-sm">{{ location }}</span>
        </label>
      </div>
    </div>

    <!-- Mounting Type -->
    <div class="mb-6">
      <button
        @click="toggleSection('mounting')"
        class="w-full flex items-center justify-between font-semibold text-brand-navy mb-3 hover:text-brand-blue transition-colors"
      >
        <span>Mounting Type</span>
        <ChevronDown 
          :size="20" 
          :stroke-width="2"
          class="transition-transform"
          :class="{ 'rotate-180': !expandedSections.mounting }"
        />
      </button>
      <div v-show="expandedSections.mounting" class="space-y-2">
        <label v-for="type in mountingTypes" :key="type" class="flex items-center gap-2 cursor-pointer hover:text-brand-blue transition-colors">
          <input
            type="checkbox"
            :value="type"
            v-model="selectedMountingTypes"
            class="w-4 h-4 accent-brand-blue rounded"
          />
          <span class="text-sm">{{ type }}</span>
        </label>
      </div>
    </div>

    <!-- Customizable Toggle -->
    <div class="mb-6">
      <label class="flex items-center justify-between cursor-pointer">
        <span class="font-semibold text-brand-navy">Customizable Only</span>
        <div class="relative">
          <input
            type="checkbox"
            v-model="customizableOnly"
            class="sr-only peer"
          />
          <div class="w-11 h-6 bg-gray-300 rounded-full peer-checked:bg-brand-blue transition-colors"></div>
          <div class="absolute left-1 top-1 w-4 h-4 bg-white rounded-full transition-transform peer-checked:translate-x-5"></div>
        </div>
      </label>
    </div>

    <!-- In Stock Only Toggle -->
    <div class="mb-6">
      <label class="flex items-center justify-between cursor-pointer">
        <span class="font-semibold text-brand-navy">In Stock Only</span>
        <div class="relative">
          <input
            type="checkbox"
            v-model="inStockOnly"
            class="sr-only peer"
          />
          <div class="w-11 h-6 bg-gray-300 rounded-full peer-checked:bg-brand-blue transition-colors"></div>
          <div class="absolute left-1 top-1 w-4 h-4 bg-white rounded-full transition-transform peer-checked:translate-x-5"></div>
        </div>
      </label>
    </div>

    <!-- Apply Filters Button (Mobile) -->
    <div class="md:hidden">
      <button
        @click="applyFilters"
        class="w-full bg-brand-blue text-brand-navy font-semibold py-3 rounded-lg hover:shadow-glow-blue transition-all duration-300"
      >
        Apply Filters
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { ChevronDown, Filter } from 'lucide-vue-next'

// Filter options
const illuminationTypes = ['LED', 'Neon', 'Backlit', 'Edge-lit', 'Front-lit', 'Non-illuminated']
const suitableFor = ['Indoor', 'Outdoor', 'All-weather', 'Showroom', 'Mall', 'Storefront']
const mountingTypes = ['Wall-mounted', 'Ceiling-suspended', 'Freestanding', 'Pylon-mounted', 'Window-mounted']

// Filter values
const priceMin = ref(0)
const priceMax = ref(5000)
const selectedIllumination = ref<string[]>([])
const selectedSuitableFor = ref<string[]>([])
const selectedMountingTypes = ref<string[]>([])
const customizableOnly = ref(false)
const inStockOnly = ref(false)

// Expanded sections (for collapsible behavior)
const expandedSections = ref({
  illumination: true,
  suitable: true,
  mounting: true
})

// Active filter count
const activeFilterCount = computed(() => {
  let count = 0
  if (priceMin.value > 0 || priceMax.value < 5000) count++
  count += selectedIllumination.value.length
  count += selectedSuitableFor.value.length
  count += selectedMountingTypes.value.length
  if (customizableOnly.value) count++
  if (inStockOnly.value) count++
  return count
})

// Emit events
const emit = defineEmits(['filter-change'])

// Toggle section collapse
const toggleSection = (section: 'illumination' | 'suitable' | 'mounting') => {
  expandedSections.value[section] = !expandedSections.value[section]
}

// Reset all filters
const resetFilters = () => {
  priceMin.value = 0
  priceMax.value = 5000
  selectedIllumination.value = []
  selectedSuitableFor.value = []
  selectedMountingTypes.value = []
  customizableOnly.value = false
  inStockOnly.value = false
  emitFilters()
}

// Apply filters (mobile)
const applyFilters = () => {
  emitFilters()
}

// Emit filter changes
const emitFilters = () => {
  emit('filter-change', {
    priceMin: priceMin.value,
    priceMax: priceMax.value,
    illumination: selectedIllumination.value,
    suitableFor: selectedSuitableFor.value,
    mountingTypes: selectedMountingTypes.value,
    customizableOnly: customizableOnly.value,
    inStockOnly: inStockOnly.value
  })
}

// Watch for filter changes (auto-apply on desktop)
watch(
  [priceMin, priceMax, selectedIllumination, selectedSuitableFor, selectedMountingTypes, customizableOnly, inStockOnly],
  () => {
    // Auto-apply on desktop (debounced in parent component)
    emitFilters()
  },
  { deep: true }
)
</script>
