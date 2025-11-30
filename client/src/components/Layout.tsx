import React from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { Car, User, LogOut, Home } from 'lucide-react'

const Layout: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user, logout, isAuthenticated } = useAuth()
  const navigate = useNavigate()

  const handleLogout = () => {
    logout()
    navigate('/')
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <Link to="/" className="flex items-center space-x-2">
              <Car className="h-8 w-8 text-primary-500" />
              <span className="text-xl font-bold text-gray-900">Rider App</span>
            </Link>

            <nav className="flex items-center space-x-4">
              <Link
                to="/"
                className="text-gray-700 hover:text-primary-500 px-3 py-2 rounded-md text-sm font-medium"
              >
                <Home className="h-4 w-4 inline mr-1" />
                Home
              </Link>

              {isAuthenticated ? (
                <>
                  <Link
                    to="/rides"
                    className="text-gray-700 hover:text-primary-500 px-3 py-2 rounded-md text-sm font-medium"
                  >
                    <Car className="h-4 w-4 inline mr-1" />
                    Rides
                  </Link>
                  <Link
                    to="/profile"
                    className="text-gray-700 hover:text-primary-500 px-3 py-2 rounded-md text-sm font-medium"
                  >
                    <User className="h-4 w-4 inline mr-1" />
                    Profile
                  </Link>
                  <button
                    onClick={handleLogout}
                    className="text-gray-700 hover:text-red-500 px-3 py-2 rounded-md text-sm font-medium"
                  >
                    <LogOut className="h-4 w-4 inline mr-1" />
                    Logout
                  </button>
                </>
              ) : (
                <>
                  <Link
                    to="/login"
                    className="text-gray-700 hover:text-primary-500 px-3 py-2 rounded-md text-sm font-medium"
                  >
                    Login
                  </Link>
                  <Link
                    to="/register"
                    className="bg-primary-500 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-primary-600"
                  >
                    Sign Up
                  </Link>
                </>
              )}
            </nav>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        {children}
      </main>

      {/* Footer */}
      <footer className="bg-white border-t mt-12">
        <div className="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8">
          <p className="text-center text-sm text-gray-500">
            © 2025 Rider App. Built for mid-journey ride sharing.
          </p>
        </div>
      </footer>
    </div>
  )
}

export default Layout
