import { readItems } from '@directus/sdk'
import directus from './directus'

export interface Settings {
  id: number
  site_name: string
  site_description?: string
  logo?: string
  contact_email?: string
  contact_phone?: string
  shipping_fee?: number
  tax_rate?: number
  hero_slider_enabled?: boolean
  hero_before_image?: string
  hero_after_image?: string
}

export const settingsApi = {
  async get(): Promise<Settings | null> {
    try {
      const settings = await directus.request(
        readItems('settings', {
          fields: ['*'],
          limit: 1
        })
      )
      
      if (!settings || settings.length === 0) {
        return null
      }
      
      return settings[0] as Settings
    } catch (error: any) {
      console.error('❌ Failed to fetch settings:', {
        message: error?.message,
        status: error?.response?.status,
        statusText: error?.response?.statusText,
        data: error?.response?.data,
        errors: error?.errors,
        fullError: error
      })
      throw error
    }
  }
}

// Standalone function export for convenience
export const getSettings = () => settingsApi.get()
