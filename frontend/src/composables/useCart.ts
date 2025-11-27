import { ref, computed, watch } from 'vue'

export interface CartItem {
  id: number
  name: string
  price: number
  quantity: number
  image?: string
  slug?: string
}

const CART_STORAGE_KEY = 'prem-lichtwerbung-cart'

// Global cart state (shared across all components)
const cartItems = ref<CartItem[]>([])

// Initialize cart from localStorage
const initializeCart = () => {
  if (typeof window !== 'undefined') {
    try {
      const stored = localStorage.getItem(CART_STORAGE_KEY)
      if (stored) {
        cartItems.value = JSON.parse(stored)
      }
    } catch (e) {
      console.error('Failed to load cart from localStorage:', e)
    }
  }
}

// Save cart to localStorage whenever it changes
const saveCart = () => {
  if (typeof window !== 'undefined') {
    try {
      localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(cartItems.value))
    } catch (e) {
      console.error('Failed to save cart to localStorage:', e)
    }
  }
}

// Initialize on first import
if (cartItems.value.length === 0) {
  initializeCart()
}

export const useCart = () => {
  // Watch for changes and save to localStorage
  watch(cartItems, saveCart, { deep: true })

  const addToCart = (product: { 
    id: number
    name: string
    price: number
    image?: string
    slug?: string
  }, quantity: number = 1) => {
    const existingItem = cartItems.value.find(item => item.id === product.id)
    
    if (existingItem) {
      // Update quantity if item already exists
      existingItem.quantity += quantity
    } else {
      // Add new item
      cartItems.value.push({
        id: product.id,
        name: product.name,
        price: product.price,
        quantity,
        image: product.image,
        slug: product.slug
      })
    }
    
    return true
  }

  const removeFromCart = (productId: number) => {
    cartItems.value = cartItems.value.filter(item => item.id !== productId)
  }

  const updateQuantity = (productId: number, quantity: number) => {
    const item = cartItems.value.find(item => item.id === productId)
    if (item) {
      if (quantity <= 0) {
        removeFromCart(productId)
      } else {
        item.quantity = quantity
      }
    }
  }

  const clearCart = () => {
    cartItems.value = []
  }

  const getItemCount = computed(() => {
    return cartItems.value.reduce((sum, item) => sum + item.quantity, 0)
  })

  const getSubtotal = computed(() => {
    return cartItems.value.reduce((sum, item) => sum + (item.price * item.quantity), 0)
  })

  const getTax = computed(() => {
    return getSubtotal.value * 0.19
  })

  const getShipping = computed(() => {
    return cartItems.value.length > 0 ? 50 : 0
  })

  const getTotal = computed(() => {
    return getSubtotal.value + getTax.value + getShipping.value
  })

  return {
    cartItems,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,
    itemCount: getItemCount,
    subtotal: getSubtotal,
    tax: getTax,
    shipping: getShipping,
    total: getTotal
  }
}
