// MongoDB initialization script
db = db.getSiblingDB('ride_sharing');

// Create collections with indexes
db.createCollection('users');
db.createCollection('orders');

// Create indexes for better performance
db.users.createIndex({ "email": 1 }, { "unique": true });
db.users.createIndex({ "phone": 1 }, { "unique": true });
db.users.createIndex({ "driverDetails.currentLocation": "2dsphere" });
db.users.createIndex({ "userType": 1, "isActive": 1 });

db.orders.createIndex({ "orderId": 1 }, { "unique": true });
db.orders.createIndex({ "pickupLocation.coordinates": "2dsphere" });
db.orders.createIndex({ "dropoffLocation.coordinates": "2dsphere" });
db.orders.createIndex({ "customer": 1, "createdAt": -1 });
db.orders.createIndex({ "driver": 1, "createdAt": -1 });
db.orders.createIndex({ "status": 1, "createdAt": -1 });

print("Database initialized successfully!");
