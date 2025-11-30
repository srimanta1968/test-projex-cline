import { Routes, Route } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import Layout from './components/Layout'
import Home from './pages/Home'
import Login from './pages/Auth/Login'
import Register from './pages/Auth/Register'
import Rides from './pages/Rides/Rides'
import CreateRide from './pages/Rides/CreateRide'
import RideDetail from './pages/Rides/RideDetail'
import Profile from './pages/Profile'

function App() {
  return (
    <AuthProvider>
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/rides" element={<Rides />} />
          <Route path="/rides/create" element={<CreateRide />} />
          <Route path="/rides/:id" element={<RideDetail />} />
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </Layout>
    </AuthProvider>
  )
}

export default App
