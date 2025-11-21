<template>
  <div class="bg-brand-gray-light rounded-lg p-6 shadow-md">
    <h3 class="text-2xl font-accent font-bold text-brand-navy mb-6">
      Calculate Your Price
    </h3>

    <!-- Product Options -->
    <div v-if="configuratorOptions.length > 0" class="space-y-4 mb-6">
      <div v-for="option in configuratorOptions" :key="option.id" class="space-y-2">
        <label class="block font-semibold text-brand-navy">
          {{ option.option_name }}
        </label>

        <!-- Dropdown -->
        <select
          v-if="option.option_type === 'dropdown'"
          v-model="selectedOptions[option.id]"
          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
        >
          <option value="">Select {{ option.option_name }}</option>
          <option
            v-for="(value, index) in option.option_values"
            :key="index"
            :value="index"
          >
            {{ value }}
          </option>
        </select>

        <!-- Color Picker -->
        <div v-else-if="option.option_type === 'color_picker'" class="flex gap-3 flex-wrap">
          <button
            v-for="(color, index) in option.option_values"
            :key="index"
            @click="selectedOptions[option.id] = index"
            :class="[
              'w-12 h-12 rounded-full border-4 transition-all',
              selectedOptions[option.id] === index ? 'border-brand-blue shadow-glow-blue' : 'border-gray-300'
            ]"
            :style="{ backgroundColor: color }"
            :title="color"
          ></button>
        </div>

        <!-- Text Input -->
        <input
          v-else-if="option.option_type === 'text_input'"
          v-model="selectedOptions[option.id]"
          type="text"
          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-brand-blue"
          :placeholder="`Enter ${option.option_name.toLowerCase()}`"
        />

        <!-- Slider -->
        <div v-else-if="option.option_type === 'slider'" class="space-y-2">
          <input
            v-model.number="selectedOptions[option.id]"
            type="range"
            :min="option.option_values.min || 0"
            :max="option.option_values.max || 100"
            :step="option.option_values.step || 1"
            class="w-full accent-brand-blue"
          />
          <div class="text-sm text-gray-600 text-center">
            {{ selectedOptions[option.id] || option.option_values.min || 0 }}
          </div>
        </div>
      </div>
    </div>

    <!-- Installation Option -->
    <div class="mb-6">
      <label class="flex items-center justify-between cursor-pointer p-4 border border-gray-300 rounded-lg hover:border-brand-blue transition-colors">
        <div>
          <span class="font-semibold text-brand-navy block">Add Professional Installation</span>
          <span class="text-sm text-gray-600">+€{{ installationPrice.toFixed(2) }}</span>
        </div>
        <input
          type="checkbox"
          v-model="includeInstallation"
          class="w-5 h-5 accent-brand-blue rounded"
        />
      </label>
    </div>

    <!-- Shipping Info -->
    <div class="mb-6 p-4 bg-white rounded-lg border border-gray-200">
      <div class="flex items-center justify-between text-sm">
        <div class="flex items-center gap-2">
          <Truck :size="20" :stroke-width="2" class="text-brand-blue" />
          <span class="font-semibold text-brand-navy">Shipping</span>
        </div>
        <span class="font-semibold text-brand-navy">
          {{ shippingPrice === 0 ? 'FREE' : `€${shippingPrice.toFixed(2)}` }}
        </span>
      </div>
    </div>

    <!-- Price Breakdown -->
    <div class="space-y-3 mb-6">
      <div class="flex items-center justify-between text-gray-700">
        <span>Base Price</span>
        <span>€{{ basePrice.toFixed(2) }}</span>
      </div>
      
      <div v-if="optionsTotal > 0" class="flex items-center justify-between text-gray-700">
        <span>Options</span>
        <span class="text-brand-blue">+€{{ optionsTotal.toFixed(2) }}</span>
      </div>
      
      <div v-if="includeInstallation" class="flex items-center justify-between text-gray-700">
        <span>Installation</span>
        <span class="text-brand-blue">+€{{ installationPrice.toFixed(2) }}</span>
      </div>
      
      <div v-if="shippingPrice > 0" class="flex items-center justify-between text-gray-700">
        <span>Shipping</span>
        <span>€{{ shippingPrice.toFixed(2) }}</span>
      </div>

      <div class="border-t border-gray-300 pt-3"></div>

      <!-- Total Price -->
      <div class="flex items-center justify-between">
        <span class="text-lg font-semibold text-brand-navy">Total Price</span>
        <span class="text-4xl font-accent font-bold text-brand-blue">
          €{{ totalPrice.toFixed(2) }}
        </span>
      </div>

      <!-- Lead Time -->
      <div class="flex items-center justify-between text-sm text-gray-600">
        <div class="flex items-center gap-2">
          <Clock :size="16" :stroke-width="2" />
          <span>Estimated Lead Time</span>
        </div>
        <span class="font-semibold">{{ totalLeadTime }} days</span>
      </div>
    </div>

    <!-- Add to Cart Button -->
    <ButtonGlow
      variant="primary"
      class="w-full text-lg py-4"
      @click="addToCart"
    >
      Add to Cart - €{{ totalPrice.toFixed(2) }}
    </ButtonGlow>

    <!-- Need Help -->
    <div class="mt-4 text-center">
      <button
        @click="$emit('request-quote')"
        class="text-sm text-brand-pink hover:underline font-semibold"
      >
        Need a custom quote?
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { Truck, Clock } from 'lucide-vue-next'
import ButtonGlow from '../ui/ButtonGlow.vue'

interface ConfiguratorOption {
  id: number
  option_name: string
  option_type: 'dropdown' | 'color_picker' | 'text_input' | 'file_upload' | 'slider'
  option_values: any
  price_modifier: number
  affects_lead_time: boolean
  lead_time_modifier_days: number
}

const props = defineProps<{
  basePrice: number
  baseLeadTime: number
  installationPrice: number
  shippingPrice: number
  configuratorOptions?: ConfiguratorOption[]
}>()

const emit = defineEmits(['add-to-cart', 'request-quote'])

// Selected options (key: option.id, value: selected index or value)
const selectedOptions = ref<Record<number, any>>({})
const includeInstallation = ref(false)

// Calculate options total price
const optionsTotal = computed(() => {
  let total = 0
  if (props.configuratorOptions) {
    for (const option of props.configuratorOptions) {
      if (selectedOptions.value[option.id] !== undefined && selectedOptions.value[option.id] !== '') {
        total += option.price_modifier
      }
    }
  }
  return total
})

// Calculate total lead time
const totalLeadTime = computed(() => {
  let leadTime = props.baseLeadTime
  if (props.configuratorOptions) {
    for (const option of props.configuratorOptions) {
      if (
        selectedOptions.value[option.id] !== undefined &&
        selectedOptions.value[option.id] !== '' &&
        option.affects_lead_time
      ) {
        leadTime += option.lead_time_modifier_days
      }
    }
  }
  return leadTime
})

// Calculate total price
const totalPrice = computed(() => {
  let total = props.basePrice + optionsTotal.value
  if (includeInstallation.value) {
    total += props.installationPrice
  }
  total += props.shippingPrice
  return total
})

// Add to cart
const addToCart = () => {
  emit('add-to-cart', {
    basePrice: props.basePrice,
    selectedOptions: selectedOptions.value,
    includeInstallation: includeInstallation.value,
    totalPrice: totalPrice.value,
    totalLeadTime: totalLeadTime.value
  })
}
</script>
