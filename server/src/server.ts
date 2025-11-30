import app from './app';
import dotenv from 'dotenv';
import { testConnection } from './config/database';

// Load environment variables
dotenv.config();

const PORT = process.env.PORT || 5000;
const HOST = process.env.HOST || '0.0.0.0'; // Listen on all interfaces for Docker connectivity

// Test database connection before starting server
const initializeServer = async () => {
  console.log('🔄 Testing database connection...');

  try {
    const dbConnected = await testConnection();
    if (!dbConnected) {
      console.error('❌ Database connection failed. Please check your database configuration.');
      console.error('💡 Make sure PostgreSQL is running and your .env file is configured correctly.');
      process.exit(1);
    }

    // Start server on all interfaces (required for Docker MCP server connectivity)
    const server = app.listen(Number(PORT), HOST, () => {
      console.log(`🚀 Rider App server running on ${HOST}:${PORT}`);
      console.log(`📊 Health check available at http://localhost:${PORT}/health`);
      console.log(`🗄️  Database health check available at http://localhost:${PORT}/health/db`);
      console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
    });

    return server;
  } catch (error) {
    console.error('💥 Failed to initialize server:', error);
    process.exit(1);
  }
};

// Start the server and set up graceful shutdown
initializeServer().then((server) => {
  // Graceful shutdown handling
  const gracefulShutdown = (signal: string) => {
    console.log(`\n🛑 Received ${signal}. Starting graceful shutdown...`);

    server.close((err) => {
      if (err) {
        console.error('❌ Error during server shutdown:', err);
        process.exit(1);
      }

      console.log('✅ Server closed successfully');
      process.exit(0);
    });

    // Force close server after 10 seconds
    setTimeout(() => {
      console.error('⚠️  Could not close connections in time, forcefully shutting down');
      process.exit(1);
    }, 10000);
  };

  // Handle shutdown signals
  process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
  process.on('SIGINT', () => gracefulShutdown('SIGINT'));

  // Handle uncaught exceptions
  process.on('uncaughtException', (err) => {
    console.error('💥 Uncaught Exception:', err);
    gracefulShutdown('uncaughtException');
  });

  // Handle unhandled promise rejections
  process.on('unhandledRejection', (reason, promise) => {
    console.error('💥 Unhandled Rejection at:', promise, 'reason:', reason);
    gracefulShutdown('unhandledRejection');
  });
}).catch((error) => {
  console.error('💥 Failed to start server:', error);
  process.exit(1);
});
