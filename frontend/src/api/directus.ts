import { createDirectus, rest, authentication } from '@directus/sdk'
import type { 
  Product, 
  Category, 
  Tag, 
  Customer, 
  Order, 
  Review, 
  Page, 
  Banner, 
  Settings 
} from '@/types'

interface Schema {
  products: Product[]
  categories: Category[]
  tags: Tag[]
  customers: Customer[]
  orders: Order[]
  reviews: Review[]
  pages: Page[]
  banners: Banner[]
  settings: Settings
}

const directusUrl = import.meta.env.VITE_DIRECTUS_URL || 'http://localhost:8055'

export const directus = createDirectus<Schema>(directusUrl)
  .with(rest())
  .with(authentication('json'))

export default directus
