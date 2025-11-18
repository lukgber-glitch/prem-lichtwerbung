import { readItems, createItem } from '@directus/sdk'
import directus from './directus'
import type { Order, OrderItem, Address } from '@/types'
import { loadStripe } from '@stripe/stripe-js'

const stripePromise = loadStripe(import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY || '')

export interface CreateOrderData {
  customer_id: number
  items: {
    product_id: number
    quantity: number
    price: number
  }[]
  shipping_address: Partial<Address>
  billing_address?: Partial<Address>
  subtotal: number
  tax: number
  shipping: number
  total: number
  notes?: string
}

export const ordersApi = {
  async getCustomerOrders(customerId: number): Promise<Order[]> {
    return await directus.request(
      readItems('orders', {
        filter: {
          customer_id: { _eq: customerId }
        },
        fields: ['*', 'items.*', 'items.product.*'],
        sort: ['-date_created']
      })
    )
  },

  async getOrderById(orderId: number): Promise<Order> {
    const orders = await directus.request(
      readItems('orders', {
        filter: {
          id: { _eq: orderId }
        },
        fields: ['*', 'items.*', 'items.product.*', 'shipping_address.*', 'billing_address.*'],
        limit: 1
      })
    )

    if (!orders || orders.length === 0) {
      throw new Error('Order not found')
    }

    return orders[0]
  },

  async createOrder(orderData: CreateOrderData): Promise<Order> {
    // First, create addresses if needed
    let shippingAddressId: number | undefined
    let billingAddressId: number | undefined

    if (orderData.shipping_address) {
      const shippingAddress = await directus.request(
        createItem('addresses', {
          ...orderData.shipping_address,
          customer_id: orderData.customer_id,
          type: 'shipping'
        })
      )
      shippingAddressId = shippingAddress.id
    }

    if (orderData.billing_address) {
      const billingAddress = await directus.request(
        createItem('addresses', {
          ...orderData.billing_address,
          customer_id: orderData.customer_id,
          type: 'billing'
        })
      )
      billingAddressId = billingAddress.id
    }

    // Create the order
    const order = await directus.request(
      createItem('orders', {
        customer_id: orderData.customer_id,
        status: 'pending',
        payment_status: 'unpaid',
        subtotal: orderData.subtotal,
        tax: orderData.tax,
        shipping: orderData.shipping,
        total: orderData.total,
        shipping_address_id: shippingAddressId,
        billing_address_id: billingAddressId,
        notes: orderData.notes
      })
    )

    // Create order items
    for (const item of orderData.items) {
      await directus.request(
        createItem('order_items', {
          order_id: order.id,
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.price,
          total: item.price * item.quantity
        })
      )
    }

    return order
  },

  async createStripeCheckoutSession(order: Order) {
    // This should be implemented on the backend as a custom endpoint
    // For now, we'll create a basic implementation
    try {
      const response = await fetch(`${import.meta.env.VITE_DIRECTUS_URL}/custom/stripe/checkout`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          order_id: order.id,
          amount: Math.round(order.total * 100), // Convert to cents
          currency: 'usd'
        })
      })

      if (!response.ok) {
        throw new Error('Failed to create checkout session')
      }

      const { sessionId } = await response.json()
      
      const stripe = await stripePromise
      if (!stripe) {
        throw new Error('Stripe failed to load')
      }

      const { error } = await stripe.redirectToCheckout({ sessionId })
      
      if (error) {
        throw error
      }
    } catch (error) {
      console.error('Stripe checkout failed:', error)
      throw error
    }
  }
}
