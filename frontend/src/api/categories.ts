import { readItems, readItem } from '@directus/sdk'
import directus from './directus'
import type { Category, Tag } from '@/types'

export const categoriesApi = {
  async getAll(): Promise<Category[]> {
    return await directus.request(
      readItems('categories', {
        filter: {
          status: { _eq: 'published' }
        },
        sort: ['sort', 'name']
      })
    )
  },

  async getBySlug(slug: string): Promise<Category> {
    const categories = await directus.request(
      readItems('categories', {
        filter: {
          slug: { _eq: slug },
          status: { _eq: 'published' }
        },
        limit: 1
      })
    )
    
    if (!categories || categories.length === 0) {
      throw new Error('Category not found')
    }
    
    return categories[0]
  },

  async getTopLevel(): Promise<Category[]> {
    return await directus.request(
      readItems('categories', {
        filter: {
          status: { _eq: 'published' },
          parent_id: { _null: true }
        },
        sort: ['sort', 'name']
      })
    )
  },

  async getChildren(parentId: number): Promise<Category[]> {
    return await directus.request(
      readItems('categories', {
        filter: {
          status: { _eq: 'published' },
          parent_id: { _eq: parentId }
        },
        sort: ['sort', 'name']
      })
    )
  }
}

export const tagsApi = {
  async getAll(): Promise<Tag[]> {
    return await directus.request(
      readItems('tags', {
        sort: ['name']
      })
    )
  }
}

// Standalone function exports for backwards compatibility
export const getCategories = () => categoriesApi.getAll()
export const getCategoryBySlug = (slug: string) => categoriesApi.getBySlug(slug)
export const getTopLevelCategories = () => categoriesApi.getTopLevel()
export const getCategoryChildren = (parentId: number) => categoriesApi.getChildren(parentId)
export const getTags = () => tagsApi.getAll()
