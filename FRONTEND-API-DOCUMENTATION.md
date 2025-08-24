# Frontend API Documentation - Latest Updates

## Version: 1.3 | Updated: August 24, 2025

> ⚠️ **IMPORTANT**: This document is automatically updated with every backend API change. Always use the latest version for frontend implementation.

### Latest Changes (v1.3)
- **NEW: Admin Dashboard**: Complete admin management system with real-time monitoring
- **Admin Endpoints**: Added comprehensive admin API endpoints for monitoring orders, drivers, and customers
- **Admin Authentication**: Added admin user type with secure role-based access control
- **Real-time Dashboard**: Web-based admin dashboard with auto-refresh and filtering capabilities

### Latest Changes (v1.2)
- **NEW: Manual Order Assignment Endpoint**: Added `/api/drivers/orders/:orderId/request` for direct order acceptance
- **TESTED: Accept Order Workflow**: Verified accept order functionality works perfectly
- **Order Assignment Process**: Clarified the difference between automatic vs manual order assignment

### Latest Changes (v1.1)
- **Fixed Driver Orders Query**: The `/api/drivers/nearby-orders` endpoint now properly returns unassigned orders
- **Driver Query Issue Resolved**: Orders with `driver: null` are now correctly included in nearby orders search
- **Version Tracking Added**: This document now tracks API versions and changes

### Change Log
- **v1.3** (Aug 24, 2025): Added complete admin dashboard system with real-time monitoring
- **v1.2** (Aug 24, 2025): Added manual order assignment endpoint, tested accept workflow
- **v1.1** (Aug 24, 2025): Fixed driver nearby-orders query, enhanced documentation
- **v1.0** (Aug 24, 2025): Initial comprehensive API documentation

---

## Admin Dashboard System ✨ **NEW**

### Admin Authentication
```
POST /api/auth/login
POST /api/auth/register (userType: "admin")
```

**Admin Credentials**:
- Email: `admin2@test.com`
- Password: `password123`

### Admin Dashboard Access
- **Web Dashboard**: `http://localhost:3001/admin.html`
- **Features**: Real-time monitoring, filtering, auto-refresh, responsive design

### Admin API Endpoints

#### 1. Main Dashboard Data
```
GET /api/admin/dashboard
```

**Query Parameters**:
- `limit` (optional): Number of results (default: 50)
- `status` (optional): Filter orders by status

**Response**:
```json
{
  "stats": {
    "totalOrders": 2,
    "activeOrders": 2,
    "completedOrders": 0,
    "totalDrivers": 2,
    "availableDrivers": 1,
    "totalCustomers": 2
  },
  "orders": [/* Recent orders with customer/driver details */],
  "drivers": [/* All drivers with availability status */],
  "customers": [/* All customers with order counts */]
}
```

#### 2. Detailed Orders Management
```
GET /api/admin/orders
```

**Query Parameters**:
- `page`, `limit`: Pagination
- `status`: Filter by order status
- `customerId`: Filter by specific customer
- `driverId`: Filter by specific driver

#### 3. Drivers Status Monitor
```
GET /api/admin/drivers
```

**Query Parameters**:
- `available` (boolean): Filter by availability
- `limit`: Number of results

**Response**: Drivers with current orders, availability status, vehicle info

#### 4. System Statistics
```
GET /api/admin/stats
```

**Response**:
```json
{
  "orders": {
    "today": 5,
    "thisWeek": 23,
    "thisMonth": 89
  },
  "revenue": {
    "today": 245.50,
    "thisWeek": 1834.25,
    "thisMonth": 7892.10
  },
  "ordersByStatus": {
    "pending": 12,
    "accepted": 8,
    "completed": 45
  }
}
```

### Admin Dashboard Features

#### Real-time Monitoring
- **Auto-refresh**: Dashboard updates every 30 seconds
- **Live Stats**: Total orders, active orders, available drivers
- **Status Tracking**: Real-time order status changes

#### Order Management
- **View All Orders**: Complete order history with customer/driver details
- **Filter Orders**: By status, customer, driver, date range
- **Order Details**: Pickup/dropoff addresses, fare details, timestamps

#### Driver Monitoring
- **Driver Status**: Available/busy status in real-time
- **Current Orders**: See which orders each driver is handling
- **Driver Details**: Vehicle info, ratings, total deliveries
- **Location Updates**: Last known location and update time

#### Customer Analytics
- **Customer List**: All registered customers
- **Order History**: Total orders per customer
- **Activity Tracking**: Registration dates, last activity

#### System Statistics
- **Performance Metrics**: Orders per day/week/month
- **Revenue Tracking**: Daily, weekly, monthly revenue
- **Status Distribution**: Orders by status breakdown

---

## Authentication Required
All endpoints require `Authorization: Bearer <token>` header.

## Driver Endpoints

### 1. Get Nearby Available Orders (FIXED - Use This for Driver Dashboard)
```
GET /api/drivers/nearby-orders?latitude={lat}&longitude={lng}&radius={km}
```

**Purpose**: Get all unassigned orders near the driver's location
**Use Case**: Driver dashboard to show available orders to accept
**Authentication**: Driver token required

**Query Parameters**:
- `latitude` (required): Driver's current latitude
- `longitude` (required): Driver's current longitude  
- `radius` (optional): Search radius in kilometers (default: 10)
- `limit` (optional): Max results (default: 20)

**Response**:
```json
{
  "orders": [
    {
      "_id": "68ab05b4fe438b8c2dfac096",
      "orderId": "ORD-1756038580574-2F2213D7",
      "status": "pending",
      "pickupLocation": {
        "address": "Place de la Bastille, Paris, France",
        "coordinates": {
          "type": "Point",
          "coordinates": [2.241977377674507, 48.89913054155223]
        }
      },
      "dropoffLocation": {
        "address": "Arc de Triomphe, Paris, France",
        "coordinates": {
          "type": "Point", 
          "coordinates": [2.295, 48.8738]
        }
      },
      "orderType": "ride",
      "estimatedDistance": 4.8,
      "estimatedDuration": 12,
      "fare": {
        "baseFare": 30,
        "distanceFare": 57.6,
        "totalFare": 87.6
      },
      "customer": {
        "_id": "68ab0588fe438b8c2dfac066",
        "name": "Bob Wilson Updated",
        "phone": "+1234567892"
      },
      "createdAt": "2025-08-24T12:29:40.575Z",
      "distanceFromDriver": null,
      "priority": "normal"
    }
  ],
  "count": 3,
  "radius": 10,
  "driverLocation": {
    "latitude": 48.89913054155223,
    "longitude": 2.241977377674507
  }
}
```

### 2. Get Driver's Assigned Orders
```
GET /api/orders
```

**Purpose**: Get orders already assigned to the logged-in driver
**Use Case**: View accepted/in-progress orders
**Authentication**: Driver token required

**Response**: Returns only orders where `driver` matches the current driver's ID

### 3. Accept/Request Order (Manual Assignment) ✅ **RECOMMENDED**
```
PUT /api/drivers/orders/:orderId/request
```

**Purpose**: Driver manually requests to accept any available order
**Use Case**: Driver sees order in nearby-orders and wants to accept it
**Authentication**: Driver token required

**Path Parameters**:
- `orderId` (required): MongoDB ObjectId of the order (from nearby-orders response)

**Response**:
```json
{
  "message": "Order assigned successfully",
  "order": {
    "orderId": "ORD-1756044248350-10401FA0",
    "status": "accepted",
    "customer": {
      "_id": "68ab1bb8ec9840f62ebf05e5",
      "name": "Bob Wilson Updated",
      "phone": "+1234567892"
    },
    "pickupAddress": "Notre-Dame Cathedral, Paris, France",
    "dropoffAddress": "Champs-Élysées, Paris, France",
    "fare": {
      "baseFare": 30,
      "distanceFare": 43.32,
      "totalFare": 73.32
    }
  }
}
```

**Error Responses**:
- `404`: Order not found or no longer available
- `500`: Server error during assignment

---

## Customer Endpoints

### 1. Get Customer's Orders  
```
GET /api/orders
```

**Purpose**: Get all orders created by the logged-in customer
**Authentication**: Customer token required

**Response**: Returns only orders where `customer` matches the current customer's ID

### 2. Create Order
```
POST /api/orders
```

**Body**:
```json
{
  "pickupAddress": "Place de la Bastille, Paris, France",
  "pickupLatitude": 48.89913054155223,
  "pickupLongitude": 2.241977377674507,
  "dropoffAddress": "Arc de Triomphe, Paris, France", 
  "dropoffLatitude": 48.8738,
  "dropoffLongitude": 2.295,
  "orderType": "ride"
}
```

---

## Customer Location Endpoints (Enhanced)

### 1. Update Customer Location
```
PUT /api/customers/location
```

**Supports Multiple Coordinate Formats**:

**Format 1 - Traditional**:
```json
{
  "latitude": 48.8566,
  "longitude": 2.3522
}
```

**Format 2 - Coordinates Array**:
```json
{
  "coordinates": [2.3522, 48.8566]
}
```

**Format 3 - GeoJSON**:
```json
{
  "location": {
    "coordinates": [2.3522, 48.8566]
  }
}
```

### 2. Get Customer Location
```
GET /api/customers/location
```

### 3. Get Customer Profile
```
GET /api/customers/profile
```

### 4. Get Nearby Drivers
```
GET /api/customers/nearby-drivers?latitude={lat}&longitude={lng}&radius={km}
```

---

## Driver Location Endpoints

### 1. Update Driver Location
```
PUT /api/drivers/location
```

**Body**:
```json
{
  "latitude": 48.8566,
  "longitude": 2.3522
}
```

### 2. Update Driver Availability
```
PUT /api/drivers/availability
```

**Body**:
```json
{
  "isAvailable": true
}
```

---

## Authentication Endpoints (Enhanced)

### 1. Enhanced Profile Update
```
PUT /api/auth/profile
```

**Supports Multiple Coordinate Formats** (same as customer location endpoint):

**For Customers**:
```json
{
  "name": "Bob Wilson Updated",
  "location": {
    "coordinates": [139.6503, 35.6762]
  }
}
```

### 2. Get Profile
```
GET /api/auth/profile
```

**Returns**: User profile with location data if available

---

## Critical Frontend Implementation Notes

### ❗ Important: Use Correct Endpoints

**For Driver Dashboard - Available Orders**:
- ✅ **Use**: `/api/drivers/nearby-orders` - Shows unassigned orders drivers can accept
- ❌ **Don't Use**: `/api/orders` - Only shows orders already assigned to the driver

**For Driver Dashboard - Accept Order**:  
- ✅ **Use**: `/api/drivers/orders/:orderId/request` - Manual order acceptance (RECOMMENDED)
- ❌ **Avoid**: `/api/orders/:orderId/accept` - Requires OrderAssignmentService workflow

**For Driver Dashboard - My Orders**:  
- ✅ **Use**: `/api/orders` - Shows driver's assigned/accepted orders

**For Customer Dashboard**:
- ✅ **Use**: `/api/orders` - Shows customer's own orders

### Order Workflow for Frontend:
1. **Driver sees available orders**: `GET /api/drivers/nearby-orders`
2. **Driver requests to accept order**: `PUT /api/drivers/orders/:orderId/request`  
3. **Driver views accepted orders**: `GET /api/orders`
4. **Driver completes order**: `PUT /api/orders/:orderId/complete`

### Coordinate Format Support
All location endpoints now support multiple coordinate formats. The frontend can send coordinates in any of these formats:

1. `{latitude: number, longitude: number}` 
2. `{coordinates: [lng, lat]}`
3. `{location: {coordinates: [lng, lat]}}`

### Real-time Updates
- Frontend should poll `/api/drivers/nearby-orders` every 15 seconds for drivers
- Frontend should poll `/api/orders` every 60 seconds for customers
- Use WebSocket for real-time notifications when available

### Error Handling
All endpoints return consistent error formats:
```json
{
  "message": "Error description"
}
```

### Rate Limiting
- Nearby orders: 20 requests per minute
- Regular orders: 10 requests per minute
- Location updates: 60 requests per minute

---

## Testing Credentials

**Admin Dashboard**:
- Email: `admin2@test.com`
- Password: `password123`
- Dashboard: `http://localhost:3001/admin.html`

**Customer (Alice Johnson)**:
- Email: `customer@test.com`
- Password: `password123`

**Customer (Bob Wilson)**:
- Email: `customer2@test.com`
- Password: `password123`

**Driver (John Smith)**:
- Email: `driver@test.com`  
- Password: `password123`

**Driver (Sarah Davis)**:
- Email: `driver2@test.com`  
- Password: `password123`

**Base URL**: `http://localhost:3001`

---

## Recent Bug Fixes & Additions

1. **Driver Orders Query Fixed**: Orders with `driver: null` now appear in nearby-orders results
2. **Coordinate Format Support**: All location endpoints accept multiple coordinate formats
3. **Enhanced Auth Profiles**: Profile endpoints now support location data for both customers and drivers
4. **NEW: Manual Order Assignment**: Added `/api/drivers/orders/:orderId/request` for direct order acceptance without complex assignment service
5. **Tested Accept Workflow**: Confirmed order acceptance works perfectly with the new manual endpoint
6. **NEW: Complete Admin Dashboard System**: Full-featured admin panel with real-time monitoring, filtering, and comprehensive system statistics
7. **Admin Role-Based Access**: Secure admin authentication with proper role validation
8. **Real-time Data Updates**: Admin dashboard auto-refreshes every 30 seconds with live system data

**Migration Required**: 
- Update frontend to use `/api/drivers/nearby-orders` for showing available orders to drivers, not `/api/orders`
- Use `/api/drivers/orders/:orderId/request` for accepting orders (simpler than auto-assignment workflow)
- **NEW**: Admin users can access comprehensive dashboard at `http://localhost:3001/admin.html`
