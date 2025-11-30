import React from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { Car, MapPin, Users, DollarSign } from 'lucide-react'

const Home: React.FC = () => {
  const { isAuthenticated } = useAuth()

  return (
    <div className="space-y-12">
      {/* Hero Section */}
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900 sm:text-5xl">
          Share Rides, Split Costs
        </h1>
        <p className="mt-4 text-xl text-gray-600 max-w-2xl mx-auto">
          Connect with fellow travelers and share rides mid-journey.
          Save money and reduce your carbon footprint.
        </p>

        <div className="mt-8 flex justify-center space-x-4">
          {isAuthenticated ? (
            <Link
              to="/rides"
              className="btn btn-primary px-8 py-3 text-lg"
            >
              Find Rides
            </Link>
          ) : (
            <>
              <Link
                to="/register"
                className="btn btn-primary px-8 py-3 text-lg"
              >
                Get Started
              </Link>
              <Link
                to="/login"
                className="btn btn-secondary px-8 py-3 text-lg"
              >
                Sign In
              </Link>
            </>
          )}
        </div>
      </div>

      {/* Features */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <div className="text-center">
          <Car className="h-12 w-12 text-primary-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Real-time Matching
          </h3>
          <p className="text-gray-600">
            Find rides that match your route and schedule instantly.
          </p>
        </div>

        <div className="text-center">
          <MapPin className="h-12 w-12 text-primary-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Flexible Routes
          </h3>
          <p className="text-gray-600">
            Join rides going your direction, even if they're not direct.
          </p>
        </div>

        <div className="text-center">
          <Users className="h-12 w-12 text-primary-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Safe Community
          </h3>
          <p className="text-gray-600">
            Verified users and safety features for peace of mind.
          </p>
        </div>

        <div className="text-center">
          <DollarSign className="h-12 w-12 text-primary-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Cost Sharing
          </h3>
          <p className="text-gray-600">
            Split fuel costs fairly among all passengers.
          </p>
        </div>
      </div>

      {/* CTA Section */}
      <div className="bg-primary-50 rounded-lg p-8 text-center">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">
          Ready to start sharing rides?
        </h2>
        <p className="text-gray-600 mb-6">
          Join thousands of travelers saving money and the environment.
        </p>
        {!isAuthenticated && (
          <Link
            to="/register"
            className="btn btn-primary px-6 py-3 text-lg"
          >
            Create Account
          </Link>
        )}
      </div>
    </div>
  )
}

export default Home
