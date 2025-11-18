import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { Product, CartItem } from '@/types'

export const useCartStore = defineStore('cart', () => {
  const items = ref<CartItem[]>([])

  // Load cart from localStorage on init
  const loadCart = () => {
    const saved = localStorage.getItem('cart')
    if (saved) {
      try {
        items.value = JSON.parse(saved)
      } catch (error) {
        console.error('Failed to load cart from localStorage:', error)
      }
    }
  }

  // Save cart to localStorage
  const saveCart = () => {
    localStorage.setItem('cart', JSON.stringify(items.value))
  }

  // Computed properties
  const itemCount = computed(() => {
    return items.value.reduce((total, item) => total + item.quantity, 0)
  })

  const subtotal = computed(() => {
    return items.value.reduce((total, item) => total + (item.product.price * item.quantity), 0)
  })

  const tax = computed(() => {
    // 10% tax rate - should come from settings
    return subtotal.value * 0.10
  })

  const shipping = computed(() => {
    // Free shipping over $100, otherwise $10
    return subtotal.value > 100 ? 0 : 10
  })

  const total = computed(() => {
    return subtotal.value + tax.value + shipping.value
  })

  // Actions
  const addItem = (product: Product, quantity: number = 1) => {
    const existingItem = items.value.find(item => item.product.id === product.id)
    
    if (existingItem) {
      existingItem.quantity += quantity
    } else {
      items.value.push({ product, quantity })
    }
    
    saveCart()
  }

  const removeItem = (productId: number) => {
    items.value = items.value.filter(item => item.product.id !== productId)
    saveCart()
  }

  const updateQuantity = (productId: number, quantity: number) => {
    const item = items.value.find(item => item.product.id === productId)
    
    if (item) {
      if (quantity <= 0) {
        removeItem(productId)
      } else {
        item.quantity = quantity
        saveCart()
      }
    }
  }

  const clearCart = () => {
    items.value = []
    saveCart()
  }

  const getItem = (productId: number): CartItem | undefined => {
    return items.value.find(item => item.product.id === productId)
  }

  // Initialize cart from localStorage
  loadCart()

  return {
    items,
    itemCount,
    subtotal,
    tax,
    shipping,
    total,
    addItem,
    removeItem,
    updateQuantity,
    clearCart,
    getItem
  }
})
