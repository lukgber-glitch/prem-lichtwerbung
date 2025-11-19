import { loadStripe, Stripe } from '@stripe/stripe-js'

// Stripe publishable key from environment variable
const stripePublishableKey = import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY || ''

let stripePromise: Promise<Stripe | null> | null = null

/**
 * Get Stripe instance (lazy loaded)
 */
export const getStripe = (): Promise<Stripe | null> => {
  if (!stripePromise) {
    stripePromise = loadStripe(stripePublishableKey)
  }
  return stripePromise
}

/**
 * Create Stripe checkout session
 * @param orderData - Order information including items, customer, and shipping
 * @returns Session ID from Stripe
 */
export const createCheckoutSession = async (orderData: {
  items: Array<{
    id: number
    name: string
    price: number
    quantity: number
    image?: string
  }>
  customerEmail?: string
  shippingAddress?: {
    line1: string
    line2?: string
    city: string
    postalCode: string
    country: string
  }
  metadata?: Record<string, string>
}): Promise<{ sessionId: string }> => {
  try {
    // TODO: Replace with actual backend API endpoint
    const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000'
    
    const response = await fetch(`${apiUrl}/api/stripe/create-checkout-session`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        items: orderData.items.map(item => ({
          name: item.name,
          amount: Math.round(item.price * 100), // Convert to cents
          quantity: item.quantity,
          images: item.image ? [item.image] : [],
        })),
        customerEmail: orderData.customerEmail,
        shippingAddress: orderData.shippingAddress,
        metadata: orderData.metadata,
        successUrl: `${window.location.origin}/order/confirmation?session_id={CHECKOUT_SESSION_ID}`,
        cancelUrl: `${window.location.origin}/cart`,
      }),
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.message || 'Failed to create checkout session')
    }

    const data = await response.json()
    return { sessionId: data.sessionId }
  } catch (error) {
    console.error('Error creating checkout session:', error)
    throw error
  }
}

/**
 * Redirect to Stripe Checkout
 * @param sessionId - Stripe session ID
 */
export const redirectToCheckout = async (sessionId: string): Promise<void> => {
  try {
    const stripe = await getStripe()
    
    if (!stripe) {
      throw new Error('Stripe failed to load')
    }

    const { error } = await stripe.redirectToCheckout({ sessionId })

    if (error) {
      console.error('Error redirecting to checkout:', error)
      throw error
    }
  } catch (error) {
    console.error('Error in redirectToCheckout:', error)
    throw error
  }
}

/**
 * Retrieve checkout session details
 * @param sessionId - Stripe session ID
 */
export const getCheckoutSession = async (sessionId: string): Promise<any> => {
  try {
    const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000'
    
    const response = await fetch(`${apiUrl}/api/stripe/checkout-session/${sessionId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    })

    if (!response.ok) {
      throw new Error('Failed to retrieve checkout session')
    }

    const data = await response.json()
    return data
  } catch (error) {
    console.error('Error retrieving checkout session:', error)
    throw error
  }
}

/**
 * Format price for display (cents to euros)
 */
export const formatPrice = (amountInCents: number): string => {
  return `€${(amountInCents / 100).toFixed(2)}`
}

/**
 * Demo mode: Simulate successful checkout
 * This is used when Stripe is not configured (for development/demo)
 */
export const simulateCheckout = async (orderData: any): Promise<{ orderId: string }> => {
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 2000))
  
  // Generate mock order ID
  const orderId = `ORD-${Date.now()}-${Math.random().toString(36).substring(7).toUpperCase()}`
  
  // Store order data in localStorage for demo purposes
  localStorage.setItem('demo_order_' + orderId, JSON.stringify({
    orderId,
    ...orderData,
    status: 'paid',
    createdAt: new Date().toISOString(),
  }))
  
  return { orderId }
}
