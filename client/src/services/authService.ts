import axios from 'axios'

const API_BASE_URL = '/api'

interface LoginCredentials {
  identifier: string
  password: string
}

interface RegisterData {
  email: string
  username: string
  password: string
  first_name: string
  last_name: string
  phone?: string
}

interface AuthResponse {
  user: {
    id: string
    email: string
    username: string
    first_name: string
    last_name: string
    verified: boolean
    created_at: string
    updated_at: string
  }
  tokens: {
    accessToken: string
    tokenType: string
    expiresIn: number
  }
}

// Set up axios defaults
axios.defaults.baseURL = API_BASE_URL

// Add auth token to requests if available
axios.interceptors.request.use((config) => {
  const token = localStorage.getItem('authToken')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// Handle token expiration
axios.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('authToken')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export const authService = {
  async login(credentials: LoginCredentials): Promise<AuthResponse> {
    const response = await axios.post('/auth/login', credentials)
    return response.data.data
  },

  async register(userData: RegisterData): Promise<void> {
    const response = await axios.post('/auth/register', userData)
    return response.data
  },

  async getProfile(): Promise<AuthResponse['user']> {
    const response = await axios.get('/auth/me')
    return response.data.data
  },

  logout(): void {
    localStorage.removeItem('authToken')
  }
}

export default authService
