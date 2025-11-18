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

// Helper function to get product IDs from junction table
async function getProductIdsByCategory(categoryId: number): Promise<number[]> {
  try {
    const junctionData = await directus.request(
      readItems('products_categories', {
        filter: {
          categories_id: { _eq: categoryId }
        },
        fields: ['products_id']
      })
    )
    return junctionData.map((item: any) => item.products_id)
  } catch (error) {
    console.error('Failed to fetch product IDs by category:', error)
    return []
  }
}

// Helper function to get product IDs from tags junction table
async function getProductIdsByTag(tagId: number): Promise<number[]> {
  try {
    const junctionData = await directus.request(
      readItems('products_tags', {
        filter: {
          tags_id: { _eq: tagId }
        },
        fields: ['products_id']
      })
    )
    return junctionData.map((item: any) => item.products_id)
  } catch (error) {
    console.error('Failed to fetch product IDs by tag:', error)
    return []
  }
}

export const productsApi = {
  async getAll(filter?: ProductFilter): Promise<Product[]> {
    try {
      const query: any = {
        filter: {
          status: { _eq: 'published' }
        },
        fields: ['id', 'name', 'slug', 'description', 'price', 'compare_at_price', 'image', 'featured', 'status']
      }

      // Handle category filtering via junction table
      if (filter?.category_id) {
        const productIds = await getProductIdsByCategory(filter.category_id)
        if (productIds.length === 0) {
          return [] // No products in this category
        }
        query.filter.id = { _in: productIds }
      }

      // Handle tag filtering via junction table
      if (filter?.tag_id) {
        const productIds = await getProductIdsByTag(filter.tag_id)
        if (productIds.length === 0) {
          return [] // No products with this tag
        }
        // If category filter already set, intersect the arrays
        if (query.filter.id?._in) {
          const categoryIds = query.filter.id._in
          const intersection = productIds.filter(id => categoryIds.includes(id))
          if (intersection.length === 0) {
            return [] // No products match both category and tag
          }
          query.filter.id = { _in: intersection }
        } else {
          query.filter.id = { _in: productIds }
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
    } catch (error: any) {
      console.error('❌ Failed to fetch products:', {
        message: error?.message,
        status: error?.response?.status,
        statusText: error?.response?.statusText,
        data: error?.response?.data,
        errors: error?.errors,
        fullError: error
      })
      // Log first error details for nested relation debugging
      if (error?.errors && error.errors.length > 0) {
        console.error('🔍 First error details:', {
          message: error.errors[0].message,
          extensions: error.errors[0].extensions,
          fullFirstError: error.errors[0]
        })
      }
      throw error
    }
  },

  async getBySlug(slug: string): Promise<Product> {
    try {
      const products = await directus.request(
        readItems('products', {
          filter: {
            slug: { _eq: slug },
            status: { _eq: 'published' }
          },
          fields: ['*'],
          limit: 1
        })
      )
      
      if (!products || products.length === 0) {
        throw new Error('Product not found')
      }
      
      return products[0]
    } catch (error: any) {
      console.error(`❌ Failed to fetch product by slug "${slug}":`, {
        message: error?.message,
        status: error?.response?.status,
        statusText: error?.response?.statusText,
        data: error?.response?.data,
        errors: error?.errors,
        fullError: error
      })
      // Log first error details for nested relation debugging
      if (error?.errors && error.errors.length > 0) {
        console.error('🔍 First error details:', {
          message: error.errors[0].message,
          extensions: error.errors[0].extensions,
          fullFirstError: error.errors[0]
        })
      }
      throw error
    }
  },

  async getById(id: number): Promise<Product> {
    try {
      return await directus.request(
        readItem('products', id, {
          fields: ['*', 'categories.categories_id.*', 'tags.tags_id.*', 'reviews.*']
        })
      )
    } catch (error: any) {
      console.error(`❌ Failed to fetch product by ID ${id}:`, {
        message: error?.message,
        status: error?.response?.status,
        statusText: error?.response?.statusText,
        data: error?.response?.data,
        errors: error?.errors,
        fullError: error
      })
      // Log first error details for nested relation debugging
      if (error?.errors && error.errors.length > 0) {
        console.error('🔍 First error details:', {
          message: error.errors[0].message,
          extensions: error.errors[0].extensions,
          fullFirstError: error.errors[0]
        })
      }
      throw error
    }
  },

  async getFeatured(limit: number = 8): Promise<Product[]> {
    try {
      return await directus.request(
        readItems('products', {
          filter: {
            status: { _eq: 'published' },
            featured: { _eq: true }
          },
          fields: ['id', 'name', 'slug', 'description', 'price', 'compare_at_price', 'image', 'featured', 'status'],
          limit
        })
      )
    } catch (error: any) {
      console.error('❌ Failed to fetch featured products:', {
        message: error?.message,
        status: error?.response?.status,
        statusText: error?.response?.statusText,
        data: error?.response?.data,
        errors: error?.errors,
        fullError: error
      })
      // Log first error details for nested relation debugging
      if (error?.errors && error.errors.length > 0) {
        console.error('🔍 First error details:', {
          message: error.errors[0].message,
          extensions: error.errors[0].extensions,
          fullFirstError: error.errors[0]
        })
      }
      throw error
    }
  }
}
