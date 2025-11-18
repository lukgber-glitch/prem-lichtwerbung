import { defineStore } from 'pinia'
import { ref } from 'vue'
import { productsApi, type ProductFilter } from '@/api/products'
import { categoriesApi, tagsApi } from '@/api/categories'
import type { Product, Category, Tag } from '@/types'

export const useProductsStore = defineStore('products', () => {
  const products = ref<Product[]>([])
  const categories = ref<Category[]>([])
  const tags = ref<Tag[]>([])
  const currentProduct = ref<Product | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Fetch products with optional filters
  const fetchProducts = async (filter?: ProductFilter) => {
    loading.value = true
    error.value = null
    
    try {
      products.value = await productsApi.getAll(filter)
    } catch (e: any) {
      error.value = e.message || 'Failed to fetch products'
      products.value = []
    } finally {
      loading.value = false
    }
  }

  // Fetch single product by slug
  const fetchProductBySlug = async (slug: string) => {
    loading.value = true
    error.value = null
    
    try {
      currentProduct.value = await productsApi.getBySlug(slug)
    } catch (e: any) {
      error.value = e.message || 'Failed to fetch product'
      currentProduct.value = null
    } finally {
      loading.value = false
    }
  }

  // Fetch featured products
  const fetchFeaturedProducts = async (limit: number = 8) => {
    loading.value = true
    error.value = null
    
    try {
      products.value = await productsApi.getFeatured(limit)
    } catch (e: any) {
      error.value = e.message || 'Failed to fetch featured products'
      products.value = []
    } finally {
      loading.value = false
    }
  }

  // Fetch categories
  const fetchCategories = async () => {
    try {
      categories.value = await categoriesApi.getAll()
    } catch (e: any) {
      error.value = e.message || 'Failed to fetch categories'
      categories.value = []
    }
  }

  // Fetch tags
  const fetchTags = async () => {
    try {
      tags.value = await tagsApi.getAll()
    } catch (e: any) {
      error.value = e.message || 'Failed to fetch tags'
      tags.value = []
    }
  }

  return {
    products,
    categories,
    tags,
    currentProduct,
    loading,
    error,
    fetchProducts,
    fetchProductBySlug,
    fetchFeaturedProducts,
    fetchCategories,
    fetchTags
  }
})
