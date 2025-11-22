<template>
  <div class="min-h-screen bg-omnicom-bg page-category">
    <!-- Category Hero Section -->
    <section 
      v-if="category"
      class="relative bg-omnicom-bg-alt text-omnicom-text py-20 overflow-hidden border-b border-omnicom-gray-300/25"
      :style="category.image ? `background-image: url(${category.image}); background-size: cover; background-position: center;` : ''"
    >
      <!-- Dark overlay for better text readability -->
      <div class="absolute inset-0 bg-omnicom-bg bg-opacity-90"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <!-- Breadcrumbs -->
        <nav class="mb-6">
          <ol class="flex items-center space-x-2 text-sm">
            <li>
              <router-link to="/" class="text-omnicom-muted hover:accent-text transition-colors cursor-pointer">
                Home
              </router-link>
            </li>
            <li class="text-omnicom-muted">/</li>
            <li class="accent-text font-semibold">{{ category.name }}</li>
          </ol>
        </nav>

        <OmnicomAccentLine size="md" class="mb-6" />
        <h1 class="text-5xl md:text-6xl font-bold mb-4 font-heading text-omnicom-text">
          {{ category.name }}
        </h1>
        <p v-if="category.description" class="text-xl text-omnicom-muted max-w-3xl">
          {{ category.description }}
        </p>
      </div>
    </section>

    <!-- Subcategories Filter Chips -->
    <section v-if="subcategories.length > 0" class="bg-omnicom-bg-alt py-6 border-b border-omnicom-gray-300/25">
      <div class="container mx-auto px-4">
        <div class="flex items-center gap-3 flex-wrap">
          <span class="text-sm font-semibold text-omnicom-text">Filter by subcategory:</span>
          <button
            @click="selectedSubcategory = null"
            :class="[
              'px-4 py-2 rounded-full transition-all text-sm font-semibold cursor-pointer',
              selectedSubcategory === null
                ? 'bg-omnicom-black text-omnicom-text-light border-2 border-omnicom-black'
                : 'bg-omnicom-bg text-omnicom-text border-2 border-omnicom-gray-300 hover:border-omnicom-black hover:text-omnicom-black'
            ]"
          >
            All {{ category?.name }}
          </button>
          <button
            v-for="subcategory in subcategories"
            :key="subcategory.id"
            @click="selectedSubcategory = subcategory.id"
            :class="[
              'px-4 py-2 rounded-full transition-all text-sm font-semibold cursor-pointer',
              selectedSubcategory === subcategory.id
                ? 'bg-omnicom-black text-omnicom-text-light border-2 border-omnicom-black'
                : 'bg-omnicom-bg text-omnicom-text border-2 border-omnicom-gray-300 hover:border-omnicom-black hover:text-omnicom-black'
            ]"
          >
            {{ subcategory.name }}
          </button>
        </div>
      </div>
    </section>

    <div class="container mx-auto px-4 py-8">
      <div class="flex flex-col lg:flex-row gap-8">
        <!-- Left Sidebar - Filters (Desktop) -->
        <aside class="hidden lg:block w-64 flex-shrink-0">
          <ProductFilters 
            :filters="filters"
            @update:filters="updateFilters"
            @clear="clearFilters"
          />
        </aside>

        <!-- Mobile Filter Toggle Button -->
        <div class="lg:hidden mb-4">
          <button 
            @click="showMobileFilters = true"
            class="w-full flex items-center justify-center gap-2 px-4 py-3 bg-transparent text-omnicom-text rounded-lg transition-all cursor-pointer border-2 border-omnicom-black hover:bg-omnicom-black hover:text-omnicom-white"
          >
            <SlidersHorizontal :size="20" :stroke-width="2" />
            Filters
            <span v-if="activeFilterCount > 0" class="accent-bg text-omnicom-white px-2 py-1 rounded-full text-xs font-bold">
              {{ activeFilterCount }}
            </span>
          </button>
        </div>

        <!-- Mobile Filter Drawer -->
        <Transition name="slide-left">
          <div 
            v-if="showMobileFilters"
            class="fixed inset-0 z-50 lg:hidden"
          >
            <!-- Backdrop -->
            <div 
              class="absolute inset-0 bg-omnicom-black/50"
              @click="showMobileFilters = false"
            ></div>
            
            <!-- Drawer -->
            <div class="absolute left-0 top-0 bottom-0 w-80 max-w-full bg-omnicom-bg-alt shadow-xl overflow-y-auto">
              <div class="p-4 border-b border-omnicom-gray-300/25 flex items-center justify-between">
                <h2 class="text-xl font-semibold font-heading text-omnicom-text">Filters</h2>
                <button 
                  @click="showMobileFilters = false"
                  class="p-2 hover:bg-omnicom-black/10 rounded-full transition-colors cursor-pointer"
                >
                  <X :size="24" class="text-omnicom-text" :stroke-width="2" />
                </button>
              </div>
              <div class="p-4">
                <ProductFilters 
                  :filters="filters"
                  @update:filters="updateFilters"
                  @clear="clearFilters"
                />
              </div>
            </div>
          </div>
        </Transition>

        <!-- Right Content Area -->
        <div class="flex-1 min-w-0">
          <!-- Top Toolbar -->
          <div class="bg-omnicom-bg rounded-lg border border-omnicom-gray-300/25 p-4 mb-6">
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
              <!-- Product Count -->
              <div class="text-omnicom-muted">
                Showing <span class="font-semibold text-omnicom-text">{{ totalProducts }}</span> products
                <span v-if="selectedSubcategory" class="text-sm">
                  in {{ subcategories.find(s => s.id === selectedSubcategory)?.name }}
                </span>
              </div>

              <!-- Sort and View Controls -->
              <div class="flex items-center gap-4">
                <!-- Sort Dropdown -->
                <div class="flex items-center gap-2">
                  <label class="text-sm text-omnicom-muted whitespace-nowrap">Sort by:</label>
                  <select 
                    v-model="sortOption"
                    class="px-3 py-2 border border-omnicom-gray-300 rounded-lg focus:ring-2 focus:ring-omnicom-red focus:border-omnicom-red text-sm bg-omnicom-bg-alt text-omnicom-text cursor-pointer"
                  >
                    <option value="newest">Newest</option>
                    <option value="price-low-high">Price: Low to High</option>
                    <option value="price-high-low">Price: High to Low</option>
                    <option value="lead-time">Lead Time</option>
                  </select>
                </div>

                <!-- View Toggle -->
                <div class="flex items-center gap-1 bg-omnicom-bg-alt rounded-lg p-1">
                  <button 
                    @click="viewMode = 'grid'"
                    :class="[
                      'p-2 rounded transition-all cursor-pointer',
                      viewMode === 'grid' ? 'bg-omnicom-black text-omnicom-text-light border border-omnicom-black' : 'text-omnicom-muted hover:text-omnicom-text'
                    ]"
                    aria-label="Grid view"
                  >
                    <LayoutGrid :size="20" :stroke-width="2" />
                  </button>
                  <button 
                    @click="viewMode = 'list'"
                    :class="[
                      'p-2 rounded transition-all cursor-pointer',
                      viewMode === 'list' ? 'bg-omnicom-black text-omnicom-text-light border border-omnicom-black' : 'text-omnicom-muted hover:text-omnicom-text'
                    ]"
                    aria-label="List view"
                  >
                    <List :size="20" :stroke-width="2" />
                  </button>
                </div>
              </div>
            </div>

            <!-- Active Filter Chips -->
            <div v-if="activeFilterChips.length > 0" class="mt-4 flex flex-wrap gap-2">
              <div 
                v-for="chip in activeFilterChips"
                :key="chip.key"
                class="flex items-center gap-2 px-3 py-1 bg-omnicom-red/10 text-omnicom-text border border-omnicom-red/30 rounded-full text-sm"
              >
                <span>{{ chip.label }}</span>
                <button 
                  @click="removeFilter(chip.key)"
                  class="hover:text-omnicom-red transition-colors cursor-pointer"
                  :aria-label="`Remove ${chip.label} filter`"
                >
                  <X :size="16" :stroke-width="2" />
                </button>
              </div>
              <button 
                @click="clearFilters"
                class="px-3 py-1 text-sm text-omnicom-red hover:text-omnicom-red hover:underline cursor-pointer"
              >
                Clear all
              </button>
            </div>
          </div>

          <!-- Loading State -->
          <div v-if="loading" class="text-center py-20">
            <div class="inline-block animate-spin rounded-full h-16 w-16 border-4 border-omnicom-red border-t-transparent"></div>
            <p class="text-omnicom-muted mt-4 text-lg">Loading products...</p>
          </div>

          <!-- Error State -->
          <div v-else-if="error" class="text-center py-20">
            <p class="text-omnicom-red mb-4 text-lg">{{ error }}</p>
            <ButtonGlow variant="primary" @click="loadProducts">
              Try Again
            </ButtonGlow>
          </div>

          <!-- Empty State -->
          <div v-else-if="products.length === 0" class="text-center py-20">
            <Package :size="96" class="mx-auto mb-6 text-omnicom-muted opacity-30" :stroke-width="2" />
            <p class="text-omnicom-text text-lg mb-2">No products found in this category</p>
            <p class="text-omnicom-muted mb-6">Try adjusting your filters or selecting a different subcategory</p>
            <div class="flex gap-4 justify-center">
              <ButtonGlow v-if="activeFilterCount > 0" variant="secondary" @click="clearFilters">
                Clear Filters
              </ButtonGlow>
              <ButtonGlow variant="primary" @click="$router.push('/products')">
                Browse All Products
              </ButtonGlow>
            </div>
          </div>

          <!-- Products Grid -->
          <div 
            v-else
            :class="[
              'grid gap-6 mb-8',
              viewMode === 'grid' ? 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4' : 'grid-cols-1'
            ]"
          >
            <ProductCard 
              v-for="product in products"
              :key="product.id"
              :product="product"
              :view-mode="viewMode"
            />
          </div>

          <!-- Pagination -->
          <div v-if="totalPages > 1" class="flex justify-center items-center gap-2">
            <button 
              @click="goToPage(currentPage - 1)"
              :disabled="currentPage === 1"
              :class="[
                'px-4 py-2 rounded-lg transition-all border-2',
                currentPage === 1 
                  ? 'bg-omnicom-bg-alt text-omnicom-muted border-omnicom-gray-300 cursor-not-allowed' 
                  : 'bg-omnicom-bg text-omnicom-text border-omnicom-muted hover:border-omnicom-red hover:text-omnicom-red cursor-pointer'
              ]"
            >
              Previous
            </button>

            <button 
              v-for="page in displayedPages"
              :key="page"
              @click="goToPage(page)"
              :class="[
                'px-4 py-2 rounded-lg transition-all border-2 cursor-pointer',
                page === currentPage 
                  ? 'bg-omnicom-red text-omnicom-white border-omnicom-red' 
                  : 'bg-omnicom-bg text-omnicom-text border-omnicom-muted hover:border-omnicom-red hover:text-omnicom-red'
              ]"
            >
              {{ page }}
            </button>

            <button 
              @click="goToPage(currentPage + 1)"
              :disabled="currentPage === totalPages"
              :class="[
                'px-4 py-2 rounded-lg transition-all border-2',
                currentPage === totalPages 
                  ? 'bg-omnicom-bg-alt text-omnicom-muted border-omnicom-gray-300 cursor-not-allowed' 
                  : 'bg-omnicom-bg text-omnicom-text border-omnicom-muted hover:border-omnicom-red hover:text-omnicom-red cursor-pointer'
              ]"
            >
              Next
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import ButtonGlow from '@/components/ui/ButtonGlow.vue'
import OmnicomAccentLine from '@/components/ui/OmnicomAccentLine.vue'
import { SlidersHorizontal, X, LayoutGrid, List, Package } from 'lucide-vue-next'
import ProductCard from '@/components/products/ProductCard.vue'
import ProductFilters from '@/components/products/ProductFilters.vue'
import { getProducts } from '@/api/products'
import { getCategories } from '@/api/categories'

const route = useRoute()
const router = useRouter()

// State
const category = ref<any>(null)
const subcategories = ref<any[]>([])
const selectedSubcategory = ref<number | null>(null)
const products = ref<any[]>([])
const loading = ref(false)
const error = ref<string | null>(null)
const showMobileFilters = ref(false)
const viewMode = ref<'grid' | 'list'>('grid')
const sortOption = ref('newest')

// Pagination
const currentPage = ref(1)
const itemsPerPage = ref(12)
const totalProducts = ref(0)

// Filters
const filters = ref({
  priceRange: [0, 5000] as [number, number],
  illuminationType: [] as string[],
  suitableFor: [] as string[],
  mountingType: [] as string[],
  customizable: null as boolean | null,
  inStockOnly: false
})

// Computed
const activeFilterCount = computed(() => {
  let count = 0
  if (filters.value.priceRange[0] > 0 || filters.value.priceRange[1] < 5000) count++
  if (filters.value.illuminationType.length > 0) count += filters.value.illuminationType.length
  if (filters.value.suitableFor.length > 0) count += filters.value.suitableFor.length
  if (filters.value.mountingType.length > 0) count += filters.value.mountingType.length
  if (filters.value.customizable !== null) count++
  if (filters.value.inStockOnly) count++
  return count
})

const activeFilterChips = computed(() => {
  const chips: Array<{ key: string; label: string }> = []
  
  if (filters.value.priceRange[0] > 0 || filters.value.priceRange[1] < 5000) {
    chips.push({
      key: 'price',
      label: `€${filters.value.priceRange[0]} - €${filters.value.priceRange[1]}`
    })
  }
  
  filters.value.illuminationType.forEach(type => {
    chips.push({ key: `illumination-${type}`, label: type })
  })
  
  filters.value.suitableFor.forEach(location => {
    chips.push({ key: `suitable-${location}`, label: location })
  })
  
  filters.value.mountingType.forEach(type => {
    chips.push({ key: `mounting-${type}`, label: type })
  })
  
  if (filters.value.customizable !== null) {
    chips.push({
      key: 'customizable',
      label: filters.value.customizable ? 'Customizable' : 'Not Customizable'
    })
  }
  
  if (filters.value.inStockOnly) {
    chips.push({ key: 'inStock', label: 'In Stock Only' })
  }
  
  return chips
})

const totalPages = computed(() => Math.ceil(totalProducts.value / itemsPerPage.value))

const displayedPages = computed(() => {
  const pages: number[] = []
  const maxVisible = 5
  let start = Math.max(1, currentPage.value - Math.floor(maxVisible / 2))
  let end = Math.min(totalPages.value, start + maxVisible - 1)
  
  if (end - start < maxVisible - 1) {
    start = Math.max(1, end - maxVisible + 1)
  }
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})

// Methods
const loadCategory = async (slug: string) => {
  try {
    const response = await getCategories({
      filter: { slug: { _eq: slug }, status: { _eq: 'published' } },
      limit: 1
    })
    
    if (response.data && response.data.length > 0) {
      category.value = response.data[0]
      await loadSubcategories(category.value.id)
    } else {
      error.value = 'Category not found'
    }
  } catch (err: any) {
    error.value = err.message || 'Failed to load category'
  }
}

const loadSubcategories = async (parentId: number) => {
  try {
    const response = await getCategories({
      filter: { parent_id: { _eq: parentId }, status: { _eq: 'published' } },
      sort: ['sort']
    })
    subcategories.value = response.data
  } catch (err) {
    console.error('Failed to load subcategories:', err)
  }
}

const loadProducts = async () => {
  if (!category.value) return
  
  loading.value = true
  error.value = null
  
  try {
    // Build category filter - include current category and selected subcategory
    const categoryIds = [category.value.id]
    
    if (selectedSubcategory.value) {
      categoryIds.push(selectedSubcategory.value)
    } else {
      // Include all subcategories if none selected
      subcategories.value.forEach(sub => categoryIds.push(sub.id))
    }
    
    // Build filter object for API
    const apiFilters: any = {
      status: { _eq: 'published' },
      categories: {
        categories_id: {
          id: { _in: categoryIds }
        }
      }
    }
    
    // Price range
    if (filters.value.priceRange[0] > 0) {
      apiFilters.price = { _gte: filters.value.priceRange[0] }
    }
    if (filters.value.priceRange[1] < 5000) {
      apiFilters.price = { ...apiFilters.price, _lte: filters.value.priceRange[1] }
    }
    
    // Illumination type
    if (filters.value.illuminationType.length > 0) {
      apiFilters.illumination_type = { _in: filters.value.illuminationType }
    }
    
    // Suitable for
    if (filters.value.suitableFor.length > 0) {
      apiFilters.suitable_for = { _contains: filters.value.suitableFor }
    }
    
    // Mounting type
    if (filters.value.mountingType.length > 0) {
      apiFilters.mounting_type = { _in: filters.value.mountingType }
    }
    
    // Customizable
    if (filters.value.customizable !== null) {
      apiFilters.customizable = { _eq: filters.value.customizable }
    }
    
    // In stock
    if (filters.value.inStockOnly) {
      apiFilters.stock = { _gt: 0 }
    }
    
    // Sort
    let sort: string[] = []
    switch (sortOption.value) {
      case 'price-low-high':
        sort = ['price']
        break
      case 'price-high-low':
        sort = ['-price']
        break
      case 'lead-time':
        sort = ['lead_time_days']
        break
      case 'newest':
      default:
        sort = ['-date_created']
        break
    }
    
    const response = await getProducts({
      filter: apiFilters,
      sort,
      limit: itemsPerPage.value,
      page: currentPage.value,
      meta: ['filter_count']
    })
    
    products.value = response.data
    totalProducts.value = response.meta?.filter_count || response.data.length
  } catch (err: any) {
    error.value = err.message || 'Failed to load products'
  } finally {
    loading.value = false
  }
}

const updateFilters = (newFilters: any) => {
  filters.value = { ...newFilters }
  currentPage.value = 1
  loadProducts()
}

const clearFilters = () => {
  filters.value = {
    priceRange: [0, 5000],
    illuminationType: [],
    suitableFor: [],
    mountingType: [],
    customizable: null,
    inStockOnly: false
  }
  currentPage.value = 1
  loadProducts()
}

const removeFilter = (key: string) => {
  if (key === 'price') {
    filters.value.priceRange = [0, 5000]
  } else if (key.startsWith('illumination-')) {
    const type = key.replace('illumination-', '')
    filters.value.illuminationType = filters.value.illuminationType.filter(t => t !== type)
  } else if (key.startsWith('suitable-')) {
    const location = key.replace('suitable-', '')
    filters.value.suitableFor = filters.value.suitableFor.filter(l => l !== location)
  } else if (key.startsWith('mounting-')) {
    const type = key.replace('mounting-', '')
    filters.value.mountingType = filters.value.mountingType.filter(t => t !== type)
  } else if (key === 'customizable') {
    filters.value.customizable = null
  } else if (key === 'inStock') {
    filters.value.inStockOnly = false
  }
  
  currentPage.value = 1
  loadProducts()
}

const goToPage = (page: number) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page
    loadProducts()
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

// Watch for changes
watch(sortOption, () => {
  loadProducts()
})

watch(selectedSubcategory, () => {
  currentPage.value = 1
  loadProducts()
})

// On mount
onMounted(async () => {
  const slug = route.params.slug as string
  await loadCategory(slug)
  if (category.value) {
    loadProducts()
  }
})
</script>

<style scoped>
.slide-left-enter-active,
.slide-left-leave-active {
  transition: all 0.3s ease;
}

.slide-left-enter-from {
  transform: translateX(-100%);
  opacity: 0;
}

.slide-left-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}
</style>
