const mongoose = require('mongoose');
const User = require('../models/User');
const { connectDB } = require('../config/database');

const seedUsers = async () => {
  try {
    console.log('🌱 Starting user seeding...');
    
    // Connect to database
    await connectDB();
    
    // Clear existing users
    await User.deleteMany({});
    console.log('🗑️  Cleared existing users');
    
    // Create test users
    const testUsers = [
      {
        name: 'Test Customer',
        email: 'customer@test.com',
        password: '123456',
        phone: '+1234567890',
        userType: 'customer'
      },
      {
        name: 'Test Driver',
        email: 'driver@test.com',
        password: '123456',
        phone: '+1234567891',
        userType: 'driver',
        driverDetails: {
          licenseNumber: 'DL123456789',
          vehicleNumber: 'KA01AB1234',
          vehicleType: 'car',
          rating: 4.8,
          totalDeliveries: 150,
          isAvailable: true,
          currentLocation: {
            type: 'Point',
            coordinates: [77.5946, 12.9716] // Bangalore coordinates
          }
        }
      },
      {
        name: 'John Driver',
        email: 'john.driver@test.com',
        password: '123456',
        phone: '+1234567892',
        userType: 'driver',
        driverDetails: {
          licenseNumber: 'DL987654321',
          vehicleNumber: 'KA02CD5678',
          vehicleType: 'bike',
          rating: 4.6,
          totalDeliveries: 89,
          isAvailable: true,
          currentLocation: {
            type: 'Point',
            coordinates: [77.6100, 12.9800]
          }
        }
      },
      {
        name: 'Sarah Customer',
        email: 'sarah@test.com',
        password: '123456',
        phone: '+1234567893',
        userType: 'customer'
      }
    ];
    
    // Create users
    const createdUsers = await User.insertMany(testUsers);
    console.log(`✅ Created ${createdUsers.length} test users:`);
    
    createdUsers.forEach(user => {
      console.log(`   - ${user.userType}: ${user.email} (${user.name})`);
    });
    
    console.log('🌱 User seeding completed successfully!');
    process.exit(0);
    
  } catch (error) {
    console.error('❌ Error seeding users:', error.message);
    process.exit(1);
  }
};

// Run seeding if this file is executed directly
if (require.main === module) {
  seedUsers();
}

module.exports = { seedUsers };
