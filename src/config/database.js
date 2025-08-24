const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

let mongod = null;

const connectDB = async () => {
  try {
    // Check if MongoDB connection string is available
    const mongoUri = process.env.MONGODB_URI;
    
    if (mongoUri && mongoUri !== 'mock') {
      // Use actual MongoDB
      const conn = await mongoose.connect(mongoUri);
      console.log(`📦 MongoDB Connected: ${conn.connection.host}`);
      return;
    }
    
    // If no MongoDB available or in development mode, use in-memory MongoDB
    console.log('📦 Starting in-memory MongoDB for development...');
    mongod = await MongoMemoryServer.create();
    const uri = mongod.getUri();
    
    const conn = await mongoose.connect(uri);
    console.log(`🔧 In-memory MongoDB connected: ${conn.connection.host}`);
    
  } catch (error) {
    console.error('❌ MongoDB connection error:', error.message);
    
    // Try to use in-memory MongoDB as fallback
    try {
      if (!mongod) {
        console.log('� Falling back to in-memory MongoDB...');
        mongod = await MongoMemoryServer.create();
        const uri = mongod.getUri();
        const conn = await mongoose.connect(uri);
        console.log(`� Fallback in-memory MongoDB connected: ${conn.connection.host}`);
      }
    } catch (fallbackError) {
      console.error('❌ Fallback MongoDB also failed:', fallbackError.message);
      process.exit(1);
    }
  }
};

const disconnectDB = async () => {
  try {
    await mongoose.connection.close();
    if (mongod) {
      await mongod.stop();
      mongod = null;
    }
  } catch (error) {
    console.error('Error disconnecting from database:', error);
  }
};

module.exports = { connectDB, disconnectDB };
