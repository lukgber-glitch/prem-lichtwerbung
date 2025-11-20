import { loadStripe, Stripe } from '@stripe/stripe-js'

let stripePromise: Promise<Stripe | null> | null = null

export const getStripe = () => {
  if (!stripePromise) {
    const publishableKey = import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY
    if (!publishableKey) {
      console.error('Stripe publishable key is not set in environment variables')
      return null
    }
    stripePromise = loadStripe(publishableKey)
  }
  return stripePromise
}

export interface CheckoutSessionData {
  items: Array<{
    product_id: string
    product_name: string
    quantity: number
    price: number
    options?: Record<string, any>
  }>
  customer_email?: string
  customer_name?: string
  customer_phone?: string
  shipping_address?: {
    line1: string
    line2?: string
    city: string
    postal_code: string
    country: string
  }
  billing_address?: {
    line1: string
    line2?: string
    city: string
    postal_code: string
    country: string
  }
}

export const createCheckoutSession = async (data: CheckoutSessionData): Promise<string> => {
  try {
    // TODO: Replace with your actual backend API endpoint
    const response = await fetch('/api/stripe/create-checkout-session', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    })

    if (!response.ok) {
      throw new Error('Failed to create checkout session')
    }

    const { sessionId } = await response.json()
    return sessionId
  } catch (error) {
    console.error('Error creating checkout session:', error)
    throw error
  }
}

export const redirectToCheckout = async (sessionId: string) => {
  const stripe = await getStripe()
  if (!stripe) {
    throw new Error('Stripe is not initialized')
  }

  const { error } = await stripe.redirectToCheckout({ sessionId })

  if (error) {
    console.error('Error redirecting to checkout:', error)
    throw error
  }
}

export const handleCheckoutFlow = async (data: CheckoutSessionData) => {
  try {
    const sessionId = await createCheckoutSession(data)
    await redirectToCheckout(sessionId)
  } catch (error) {
    console.error('Checkout flow error:', error)
    throw error
  }
}
