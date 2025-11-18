import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authApi, type LoginCredentials, type RegisterData } from '@/api/auth'
import type { Customer } from '@/types'

export const useAuthStore = defineStore('auth', () => {
  const user = ref<Customer | null>(null)
  const token = ref<string | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Load auth state from localStorage
  const loadAuthState = () => {
    const savedToken = localStorage.getItem('auth_token')
    const savedUser = localStorage.getItem('auth_user')
    
    if (savedToken) {
      token.value = savedToken
    }
    
    if (savedUser) {
      try {
        user.value = JSON.parse(savedUser)
      } catch (e) {
        console.error('Failed to parse saved user:', e)
      }
    }
  }

  // Save auth state to localStorage
  const saveAuthState = () => {
    if (token.value) {
      localStorage.setItem('auth_token', token.value)
    } else {
      localStorage.removeItem('auth_token')
    }
    
    if (user.value) {
      localStorage.setItem('auth_user', JSON.stringify(user.value))
    } else {
      localStorage.removeItem('auth_user')
    }
  }

  // Computed
  const isAuthenticated = computed(() => !!user.value && !!token.value)

  // Actions
  const login = async (credentials: LoginCredentials) => {
    loading.value = true
    error.value = null
    
    try {
      const response = await authApi.login(credentials)
      token.value = response.access_token
      
      // Get user data
      const userData = await authApi.getCurrentUser()
      user.value = userData
      
      saveAuthState()
      return true
    } catch (e: any) {
      error.value = e.message || 'Login failed'
      return false
    } finally {
      loading.value = false
    }
  }

  const register = async (data: RegisterData) => {
    loading.value = true
    error.value = null
    
    try {
      await authApi.register(data)
      
      // Auto-login after registration
      return await login({
        email: data.email,
        password: data.password
      })
    } catch (e: any) {
      error.value = e.message || 'Registration failed'
      return false
    } finally {
      loading.value = false
    }
  }

  const logout = async () => {
    try {
      await authApi.logout()
    } catch (e) {
      console.error('Logout error:', e)
    } finally {
      user.value = null
      token.value = null
      saveAuthState()
    }
  }

  const refreshToken = async () => {
    try {
      const response = await authApi.refresh()
      token.value = response.access_token
      saveAuthState()
      return true
    } catch (e) {
      console.error('Token refresh failed:', e)
      // Clear auth state if refresh fails
      user.value = null
      token.value = null
      saveAuthState()
      return false
    }
  }

  const checkAuth = async () => {
    if (!token.value) {
      return false
    }
    
    try {
      const userData = await authApi.getCurrentUser()
      if (userData) {
        user.value = userData
        saveAuthState()
        return true
      }
    } catch (e) {
      console.error('Check auth failed:', e)
    }
    
    return false
  }

  // Initialize auth state
  loadAuthState()

  return {
    user,
    token,
    loading,
    error,
    isAuthenticated,
    login,
    register,
    logout,
    refreshToken,
    checkAuth
  }
})
