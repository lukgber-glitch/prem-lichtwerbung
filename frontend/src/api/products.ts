import { readItems, readItem } from '@directus/sdk'
import directus from './directus'
import type { Product } from '@/types'

export interface ProductFilter {
  category_id?: number
  tag_id?: number
  search?: string
  featured?: boolean
  min_price?: number
  max_price?: number
}

export const productsApi = {
  async getAll(filter?: ProductFilter): Promise<Product[]> {
    const query: any = {
      filter: {
        status: { _eq: 'published' }
      },
      fields: ['*', 'categories.categories_id.*', 'tags.tags_id.*']
    }

    if (filter?.category_id) {
      query.filter.categories = {
        categories_id: { _eq: filter.category_id }
      }
    }

    if (filter?.tag_id) {
      query.filter.tags = {
        tags_id: { _eq: filter.tag_id }
      }
    }

    if (filter?.search) {
      query.filter._or = [
        { name: { _icontains: filter.search } },
        { description: { _icontains: filter.search } }
      ]
    }

    if (filter?.featured !== undefined) {
      query.filter.featured = { _eq: filter.featured }
    }

    if (filter?.min_price !== undefined) {
      query.filter.price = { _gte: filter.min_price }
    }

    if (filter?.max_price !== undefined) {
      query.filter.price = { ...query.filter.price, _lte: filter.max_price }
    }

    return await directus.request(readItems('products', query))
  },

  async getBySlug(slug: string): Promise<Product> {
    const products = await directus.request(
      readItems('products', {
        filter: {
          slug: { _eq: slug },
          status: { _eq: 'published' }
        },
        fields: ['*', 'categories.categories_id.*', 'tags.tags_id.*', 'reviews.*'],
        limit: 1
      })
    )
    
    if (!products || products.length === 0) {
      throw new Error('Product not found')
    }
    
    return products[0]
  },

  async getById(id: number): Promise<Product> {
    return await directus.request(
      readItem('products', id, {
        fields: ['*', 'categories.categories_id.*', 'tags.tags_id.*', 'reviews.*']
      })
    )
  },

  async getFeatured(limit: number = 8): Promise<Product[]> {
    return await directus.request(
      readItems('products', {
        filter: {
          status: { _eq: 'published' },
          featured: { _eq: true }
        },
        fields: ['*', 'categories.categories_id.*', 'tags.tags_id.*'],
        limit
      })
    )
  }
}
