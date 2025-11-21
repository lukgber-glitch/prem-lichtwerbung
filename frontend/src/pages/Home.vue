<template>
  <div class="min-h-screen">
    
    <!-- HERO SECTION -->
    <section class="relative h-screen flex items-center justify-center bg-background overflow-hidden">
      
      <!-- Before/After Slider Background (if enabled) -->
      <div 
        v-if="settings?.hero_slider_enabled && settings?.hero_before_image && settings?.hero_after_image" 
        class="absolute inset-0 z-0"
      >
        <BeforeAfterSlider 
          :before-image="settings.hero_before_image" 
          :after-image="settings.hero_after_image" 
        />
        <!-- Dark overlay for text readability -->
        <div class="absolute inset-0 bg-background/60"></div>
      </div>
      
      <!-- Hero content -->
      <div class="relative z-10 text-center px-6 max-w-5xl">
        
        <!-- Main headline -->
        <h1 class="text-6xl md:text-9xl font-heading font-bold text-primary mb-6">
          {{ t('home.hero.title1') }}<br>
          <span class="text-accent">{{ t('home.hero.title2') }}</span><br>
          {{ t('home.hero.title3') }}
        </h1>
        
        <!-- Subheadline -->
        <p class="text-xl md:text-3xl text-text-main mb-8 font-medium">
          {{ t('home.hero.subtitle') }}<br>
          <span class="text-primary">{{ t('home.hero.subtitleHighlight') }}</span>
        </p>
        
        <!-- CTA Buttons -->
        <div class="flex flex-col md:flex-row gap-6 justify-center items-center">
          <button 
            @click="$router.push('/products')"
            class="px-12 py-5 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all duration-300 border-2 border-primary cursor-pointer"
          >
            {{ t('home.hero.exploreProducts') }}
          </button>
          
          <button 
            @click="$router.push('/contact')"
            class="px-12 py-5 bg-transparent text-text-main text-xl font-bold rounded-lg border-2 border-text-muted hover:border-primary hover:text-primary transition-all duration-300 cursor-pointer"
          >
            {{ t('home.hero.getCustomQuote') }}
          </button>
        </div>
        
        <!-- Trust badges -->
        <div class="flex gap-12 justify-center mt-16 flex-wrap">
          <div class="flex items-center gap-3">
            <Zap :size="24" :stroke-width="2" class="text-primary" />
            <span class="text-text-main text-sm font-medium">{{ t('home.badges.fastDelivery') }}</span>
          </div>
          
          <div class="flex items-center gap-3">
            <Palette :size="24" :stroke-width="2" class="text-primary" />
            <span class="text-text-main text-sm font-medium">{{ t('home.badges.customDesign') }}</span>
          </div>
          
          <div class="flex items-center gap-3">
            <Gem :size="24" :stroke-width="2" class="text-primary" />
            <span class="text-text-main text-sm font-medium">{{ t('home.badges.premiumQuality') }}</span>
          </div>
        </div>
        
      </div>
      
      <!-- Scroll indicator -->
      <div class="absolute bottom-8 left-1/2 -translate-x-1/2 animate-bounce">
        <div class="w-8 h-12 border-2 border-primary rounded-full flex justify-center pt-2">
          <div class="w-1 h-3 bg-primary rounded-full animate-pulse"></div>
        </div>
      </div>
      
    </section>
    
    <!-- Products Section -->
    <section class="py-20 bg-surface">
      <div class="container mx-auto px-6">
        <h2 class="text-5xl font-heading font-bold text-center text-text-main mb-4">
          {{ t('home.featured.title') }}
        </h2>
        <p class="text-xl text-center text-text-muted mb-12">
          {{ t('home.featured.subtitle') }}
        </p>
        
        <!-- Loading State -->
        <div v-if="loading" class="text-center py-12">
          <div class="inline-block animate-spin rounded-full h-16 w-16 border-b-4 border-primary"></div>
          <div class="text-xl text-text-muted mt-4">{{ t('home.loadingProducts') }}</div>
        </div>
        
        <!-- Error State -->
        <div v-else-if="error" class="text-center py-12 bg-red-50 border border-red-200 rounded-xl p-8 max-w-2xl mx-auto">
          <AlertTriangle :size="64" :stroke-width="2" class="mx-auto mb-4 text-error" />
          <div class="text-2xl font-bold text-error mb-4">{{ error }}</div>
          <div class="text-gray-600 mb-6">
            <p class="mb-2">Configure Directus public permissions:</p>
            <ol class="text-left list-decimal list-inside space-y-2 text-sm">
              <li>Go to <a href="http://localhost:8055" target="_blank" class="text-primary underline cursor-pointer">Directus Admin</a></li>
              <li>Login: admin@example.com / admin123</li>
              <li>Settings > Access Control > Public</li>
              <li>Add read permission for "products" and "directus_files"</li>
            </ol>
          </div>
        </div>
        
        <!-- Empty State -->
        <div v-else-if="!featuredProducts || featuredProducts.length === 0" class="text-center py-12">
          <Package :size="64" :stroke-width="2" class="mx-auto mb-4 text-text-muted" />
          <div class="text-2xl font-bold text-text-main mb-2">No products found</div>
          <p class="text-text-muted">Add products in Directus admin panel.</p>
        </div>
        
        <!-- Products Grid -->
        <div v-else class="grid md:grid-cols-3 gap-8">
          <div 
            v-for="product in featuredProducts" 
            :key="product.id"
            class="group bg-surface-alt rounded-xl border border-surface overflow-hidden hover:border-primary transition-all duration-300 cursor-pointer"
            @click="$router.push(`/products/${product.slug}`)"
          >
            <!-- Product Image -->
            <div class="aspect-[4/3] bg-surface flex items-center justify-center relative overflow-hidden">
              <Lightbulb :size="80" :stroke-width="1.5" class="text-primary relative z-10" />
              
              <!-- Customizable badge -->
              <div v-if="product.customizable" class="absolute top-4 left-4 bg-accent text-background px-3 py-1 rounded-full text-xs font-bold z-10">
                Customizable
              </div>
            </div>
            
            <!-- Product Info -->
            <div class="p-6">
              <div class="flex gap-2 mb-3">
                <span class="inline-block bg-primary/10 text-primary px-3 py-1 rounded-full text-xs font-semibold border border-primary/20">
                  {{ product.illumination_type || 'LED' }}
                </span>
                <span v-if="product.lead_time_days" class="inline-block bg-surface text-text-muted px-3 py-1 rounded-full text-xs">
                  {{ product.lead_time_days }} days
                </span>
              </div>
              
              <h3 class="font-heading text-xl font-bold text-text-main mb-2 group-hover:text-primary transition-colors line-clamp-2">
                {{ getProductName(product) }}
              </h3>
              
              <p v-if="product.description" class="text-text-muted text-sm mb-4 line-clamp-2">
                {{ getProductDescription(product) }}
              </p>
              
              <div class="flex items-baseline gap-3 mb-4">
                <span class="text-3xl font-bold text-primary">
                  €{{ Number(product.price).toFixed(2) }}
                </span>
                <span v-if="product.compare_at_price" class="text-lg text-text-muted line-through">
                  €{{ Number(product.compare_at_price).toFixed(2) }}
                </span>
              </div>
              
              <button 
                class="w-full px-6 py-3 bg-primary text-background font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary cursor-pointer"
                @click.stop="$router.push(`/products/${product.slug}`)"
              >
                {{ t('home.viewDetails') }}
              </button>
            </div>
          </div>
        </div>
        
        <!-- View All Products Button -->
        <div v-if="featuredProducts && featuredProducts.length > 0" class="text-center mt-12">
          <button 
            @click="$router.push('/products')"
            class="px-12 py-4 bg-surface-alt text-text-main text-xl font-bold rounded-lg border-2 border-text-muted hover:border-primary hover:text-primary transition-all cursor-pointer flex items-center justify-center gap-2 mx-auto"
          >
            {{ t('home.viewAllProducts') }}
            <ArrowRight :size="20" :stroke-width="2" />
          </button>
        </div>
      </div>
    </section>
    
    <!-- Trust Badges -->
    <section class="py-24 bg-surface">
      <div class="container mx-auto px-6">
        <div class="grid md:grid-cols-3 gap-12">
          <div class="text-center">
            <AnimatedCounter :target-value="15" suffix="+" :label="t('home.stats.yearsInBusiness')" />
          </div>
          <div class="text-center">
            <AnimatedCounter :target-value="500" suffix="+" :label="t('home.stats.projectsCompleted')" />
          </div>
          <div class="text-center">
            <AnimatedCounter :target-value="98" suffix="%" :label="t('home.stats.customerSatisfaction')" />
          </div>
        </div>
      </div>
    </section>
    
    <!-- Categories Preview -->
    <section class="py-20 bg-background">
      <div class="container mx-auto px-6">
        <h2 class="text-5xl font-heading font-bold text-center text-text-main mb-4">
          {{ t('home.categoriesPreview.title') }}
        </h2>
        <p class="text-xl text-center text-text-muted mb-12">
          {{ t('home.categoriesPreview.subtitle') }}
        </p>
        
        <div class="grid md:grid-cols-3 gap-8">
          <div 
            v-for="category in sampleCategories" 
            :key="category.key"
            class="group block rounded-lg overflow-hidden border-2 border-surface-alt hover:border-primary transition-all duration-300 cursor-pointer bg-surface p-8"
            @click="$router.push('/products')"
          >
            <h3 class="font-heading text-2xl font-bold text-text-main mb-3 group-hover:text-primary transition-colors">
              {{ t(`categories.${category.key}`) }}
            </h3>
            <p class="text-text-muted text-sm mb-4">{{ t(`categories.${category.descKey}`) }}</p>
            
            <div class="flex items-center gap-2 text-primary group-hover:gap-3 transition-all">
              <span class="text-sm font-medium">{{ t('home.categoriesPreview.viewProducts') }}</span>
              <ChevronRight :size="16" :stroke-width="2" />
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- CTA Section -->
    <section class="py-20 bg-surface">
      <div class="container mx-auto px-6 text-center">
        <h2 class="text-4xl md:text-5xl font-heading font-bold text-text-main mb-6">
          {{ t('home.ctaAlt.title') }}
        </h2>
        <p class="text-xl md:text-2xl text-text-muted mb-8">
          {{ t('home.ctaAlt.subtitle') }}
        </p>
        <div class="flex flex-col md:flex-row gap-6 justify-center">
          <button 
            @click="$router.push('/contact')"
            class="px-12 py-5 bg-primary text-background text-xl font-bold rounded-lg hover:bg-primary/90 transition-all border-2 border-primary cursor-pointer"
          >
            {{ t('home.ctaAlt.requestQuote') }}
          </button>
          <button 
            @click="$router.push('/contact')"
            class="px-12 py-5 bg-transparent text-text-main text-xl font-bold rounded-lg border-2 border-text-muted hover:border-primary hover:text-primary transition-all cursor-pointer"
          >
            {{ t('home.ctaAlt.callUs') }}
          </button>
        </div>
      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { ChevronRight, Zap, Palette, Gem, AlertTriangle, Package, Lightbulb, ArrowRight } from 'lucide-vue-next'
import BeforeAfterSlider from '@/components/ui/BeforeAfterSlider.vue'
import AnimatedCounter from '@/components/ui/AnimatedCounter.vue'
import { getSettings } from '@/api/settings'
import type { Settings } from '@/api/settings'

const router = useRouter()
const { t, locale } = useI18n()

// Helper functions for locale-aware product fields
const getProductName = (product: any) => {
  return locale.value === 'de' && product.name_de ? product.name_de : product.name
}

const getProductDescription = (product: any) => {
  return locale.value === 'de' && product.description_de ? product.description_de : product.description
}

const featuredProducts = ref<any[]>([])
const loading = ref(true)
const error = ref('')
const settings = ref<Settings | null>(null)

const sampleCategories = [
  { key: 'lightboxes', descKey: 'lightboxesDesc' },
  { key: 'channelLetters', descKey: 'channelLettersDesc' },
  { key: 'ledNeonSigns', descKey: 'ledNeonSignsDesc' },
]

const fetchFeaturedProducts = async () => {
  try {
    loading.value = true
    error.value = ''
    
    const response = await fetch('http://localhost:8055/items/products?limit=6&filter[featured][_eq]=true')
    
    if (!response.ok) {
      throw new Error(`Failed to fetch products. Check Directus permissions.`)
    }
    
    const data = await response.json()
    
    if (data && data.data && Array.isArray(data.data)) {
      featuredProducts.value = data.data
    } else {
      featuredProducts.value = []
    }
    
  } catch (e: any) {
    console.error('Error fetching products:', e)
    error.value = e.message || 'Failed to load products'
    featuredProducts.value = []
  } finally {
    loading.value = false
  }
}

const fetchSettings = async () => {
  try {
    settings.value = await getSettings()
  } catch (e: any) {
    console.error('Error fetching settings:', e)
    // Settings are optional, don't show error to user
  }
}

onMounted(() => {
  fetchFeaturedProducts()
  fetchSettings()
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
