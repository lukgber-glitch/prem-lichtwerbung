import { login, logout, refresh } from '@directus/sdk'
import directus from './directus'

export interface LoginCredentials {
  email: string
  password: string
}

export interface RegisterData {
  email: string
  password: string
  first_name: string
  last_name: string
  phone?: string
}

export const authApi = {
  async login(credentials: LoginCredentials) {
    try {
      const result = await directus.request(
        login(credentials.email, credentials.password)
      )
      return result
    } catch (error) {
      console.error('Login failed:', error)
      throw error
    }
  },

  async logout() {
    try {
      await directus.request(logout())
    } catch (error) {
      console.error('Logout failed:', error)
      throw error
    }
  },

  async refresh() {
    try {
      const result = await directus.request(refresh())
      return result
    } catch (error) {
      console.error('Token refresh failed:', error)
      throw error
    }
  },

  async register(data: RegisterData) {
    // In a real application, you would create a custom endpoint for registration
    // For now, we'll use a direct create on customers collection
    // Note: This would need proper backend handling for password hashing
    try {
      const response = await fetch(`${import.meta.env.VITE_DIRECTUS_URL}/items/customers`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: data.email,
          password_hash: data.password, // In production, this should be hashed on the backend
          first_name: data.first_name,
          last_name: data.last_name,
          phone: data.phone
        })
      })

      if (!response.ok) {
        throw new Error('Registration failed')
      }

      return await response.json()
    } catch (error) {
      console.error('Registration failed:', error)
      throw error
    }
  },

  async getCurrentUser() {
    try {
      const response = await fetch(`${import.meta.env.VITE_DIRECTUS_URL}/users/me`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('auth_token')}`
        }
      })

      if (!response.ok) {
        throw new Error('Failed to get current user')
      }

      return await response.json()
    } catch (error) {
      console.error('Get current user failed:', error)
      return null
    }
  }
}
