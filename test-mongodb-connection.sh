#!/bin/bash

# MongoDB Connection Test Script for Railway Deployment
echo "🔍 Testing MongoDB Atlas Connection..."
echo ""

# Test the connection string locally before setting in Railway
# Replace YOUR_CONNECTION_STRING with your actual MongoDB URI

CONNECTION_STRING="mongodb+srv://ride-admin:YOUR_PASSWORD@rider.dvycreo.mongodb.net/ride-sharing?retryWrites=true&w=majority&appName=rider"

echo "📝 Instructions:"
echo "1. Replace YOUR_PASSWORD with your actual MongoDB password (URL-encoded)"
echo "2. Run this test to verify connection before setting in Railway"
echo ""

node -e "
const mongoose = require('mongoose');

async function testConnection() {
  try {
    console.log('🔌 Testing MongoDB connection...');
    
    // Replace with your actual connection string
    const uri = process.env.TEST_MONGODB_URI || 'REPLACE_WITH_YOUR_CONNECTION_STRING';
    
    if (uri.includes('YOUR_PASSWORD')) {
      console.error('❌ Please replace YOUR_PASSWORD with your actual password');
      console.log('Usage: TEST_MONGODB_URI=\"your-connection-string\" node test-connection.js');
      process.exit(1);
    }
    
    await mongoose.connect(uri);
    console.log('✅ MongoDB connection successful!');
    console.log('📊 Connected to:', mongoose.connection.host);
    console.log('📁 Database:', mongoose.connection.db.databaseName);
    
    await mongoose.disconnect();
    console.log('✅ Test completed - connection string is valid!');
    console.log('💡 You can now use this connection string in Railway environment variables');
    
  } catch (error) {
    console.error('❌ Connection failed:', error.message);
    console.log('');
    console.log('🔧 Common fixes:');
    console.log('• Check password is correct and URL-encoded');
    console.log('• Verify IP whitelist in MongoDB Atlas (allow 0.0.0.0/0)');
    console.log('• Ensure user has proper permissions');
    process.exit(1);
  }
}

testConnection();
"

echo ""
echo "🚀 To test your connection string:"
echo "TEST_MONGODB_URI=\"your-full-connection-string\" npm run test-connection"
