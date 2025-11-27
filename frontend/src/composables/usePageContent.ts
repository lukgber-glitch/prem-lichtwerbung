import { ref, computed, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { directus } from '@/api/directus'
import { readItems } from '@directus/sdk'

interface PageContent {
  id: number
  status: string
  title: string
  title_de: string | null
  slug: string
  content_en: Record<string, any>
  content_de: Record<string, any>
  hero_image: string | null
  images?: Array<{
    directus_files_id: {
      id: string
      filename_disk: string
      title: string
    }
  }>
}

export function usePageContent(slug: string) {
  const { locale } = useI18n()
  const pageData = ref<PageContent | null>(null)
  const loading = ref(true)
  const error = ref<string | null>(null)

  // Get content based on current locale
  const content = computed(() => {
    if (!pageData.value) return null
    return locale.value === 'de' ? pageData.value.content_de : pageData.value.content_en
  })

  // Get title based on current locale
  const title = computed(() => {
    if (!pageData.value) return ''
    return locale.value === 'de' && pageData.value.title_de 
      ? pageData.value.title_de 
      : pageData.value.title
  })

  // Get hero image URL
  const heroImageUrl = computed(() => {
    if (!pageData.value?.hero_image) return null
    const directusUrl = import.meta.env.VITE_DIRECTUS_URL || 'http://localhost:8055'
    return `${directusUrl}/assets/${pageData.value.hero_image}`
  })

  // Get gallery images URLs
  const galleryImages = computed(() => {
    if (!pageData.value?.images) return []
    const directusUrl = import.meta.env.VITE_DIRECTUS_URL || 'http://localhost:8055'
    return pageData.value.images.map(img => ({
      id: img.directus_files_id.id,
      url: `${directusUrl}/assets/${img.directus_files_id.id}`,
      title: img.directus_files_id.title || img.directus_files_id.filename_disk
    }))
  })

  // Fetch page data from Directus
  const fetchPageContent = async () => {
    try {
      loading.value = true
      error.value = null

      const pages = await directus.request(
        readItems('pages', {
          filter: { 
            slug: { _eq: slug },
            status: { _eq: 'published' }
          },
          fields: ['*', 'images.directus_files_id.*']
        })
      )

      if (pages && pages.length > 0) {
        pageData.value = pages[0] as PageContent
      } else {
        error.value = `Page with slug "${slug}" not found`
      }
    } catch (e) {
      console.error('Error fetching page content:', e)
      error.value = 'Failed to load page content'
    } finally {
      loading.value = false
    }
  }

  onMounted(() => {
    fetchPageContent()
  })

  return {
    pageData,
    content,
    title,
    heroImageUrl,
    galleryImages,
    loading,
    error,
    refetch: fetchPageContent
  }
}
