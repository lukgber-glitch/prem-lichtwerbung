export interface Category {
  id: number
  status: string
  name: string
  slug: string
  description?: string
  parent_id?: number
  sort?: number
  children?: Category[]
  products?: Product[]
}

export interface Tag {
  id: number
  name: string
  slug: string
  color?: string
}

export interface Product {
  id: number
  status: string
  name: string
  slug: string
  description?: string
  price: number
  compare_at_price?: number
  stock: number
  sku?: string
  weight?: number
  image?: string
  gallery?: string[]
  featured: boolean
  stripe_product_id?: string
  stripe_price_id?: string
  date_created?: string
  date_updated?: string
  categories?: Category[]
  tags?: Tag[]
  reviews?: Review[]
}

export interface Customer {
  id: number
  email: string
  password_hash?: string
  first_name: string
  last_name: string
  phone?: string
  stripe_customer_id?: string
  date_created?: string
  date_updated?: string
  addresses?: Address[]
  orders?: Order[]
  reviews?: Review[]
}

export interface Address {
  id: number
  customer_id: number
  type: 'shipping' | 'billing'
  first_name: string
  last_name: string
  street: string
  city: string
  state?: string
  postal_code: string
  country: string
  is_default: boolean
}

export interface Order {
  id: number
  customer_id: number
  status: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled'
  payment_status: 'unpaid' | 'paid' | 'refunded'
  total: number
  subtotal?: number
  tax?: number
  shipping?: number
  shipping_address_id?: number
  billing_address_id?: number
  stripe_payment_intent_id?: string
  stripe_checkout_session_id?: string
  notes?: string
  date_created?: string
  date_updated?: string
  items?: OrderItem[]
  customer?: Customer
  shipping_address?: Address
  billing_address?: Address
}

export interface OrderItem {
  id: number
  order_id: number
  product_id: number
  quantity: number
  price: number
  total: number
  product?: Product
}

export interface Review {
  id: number
  product_id: number
  customer_id: number
  rating: number
  title: string
  comment?: string
  status: string
  date_created?: string
  product?: Product
  customer?: Customer
}

export interface Page {
  id: number
  status: string
  title: string
  slug: string
  content?: string
  date_created?: string
  date_updated?: string
}

export interface Banner {
  id: number
  status: string
  title: string
  subtitle?: string
  image?: string
  link?: string
  sort?: number
}

export interface Settings {
  id: number
  site_name?: string
  site_description?: string
  logo?: string
  contact_email?: string
  contact_phone?: string
  shipping_fee?: number
  tax_rate?: number
}

export interface CartItem {
  product: Product
  quantity: number
}

export interface CheckoutData {
  customer?: Partial<Customer>
  shipping_address: Partial<Address>
  billing_address?: Partial<Address>
  use_shipping_for_billing: boolean
}
