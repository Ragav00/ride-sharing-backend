# MongoDB Atlas Setup Guide

## 🚀 Setting up MongoDB Atlas for Ride-Sharing Backend

### Step 1: Create MongoDB Atlas Account
1. Go to [MongoDB Atlas](https://cloud.mongodb.com/)
2. Sign up for a free account or log in
3. Create a new project (e.g., "Ride-Sharing-App")

### Step 2: Create a Cluster
1. Click "Build a Database"
2. Choose "M0 Sandbox" (Free tier)
3. Select your preferred cloud provider and region
4. Name your cluster (e.g., "ride-sharing-cluster")
5. Click "Create Cluster"

### Step 3: Create Database User
1. Go to "Database Access" in the left sidebar
2. Click "Add New Database User"
3. Choose "Password" authentication
4. Username: `ride-admin`
5. Password: Generate a secure password (save it!)
6. Database User Privileges: "Read and write to any database"
7. Click "Add User"

### Step 4: Configure Network Access
1. Go to "Network Access" in the left sidebar
2. Click "Add IP Address"
3. For development: Click "Allow Access from Anywhere" (0.0.0.0/0)
   - For production, add only specific IPs
4. Click "Confirm"

### Step 5: Get Connection String
1. Go to "Clusters" and click "Connect" on your cluster
2. Choose "Connect your application"
3. Select "Node.js" and latest version
4. Copy the connection string
5. It will look like: `mongodb+srv://ride-admin:<password>@ride-sharing-cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority`

### Step 6: Update Environment Variables
Replace the placeholders in your `.env` file:

```env
# MongoDB Atlas Configuration
MONGODB_URI=mongodb+srv://ride-admin:<YOUR_PASSWORD>@<YOUR_CLUSTER>.xxxxx.mongodb.net/ride-sharing?retryWrites=true&w=majority
USE_MOCK_DATABASE=false
```

### Step 7: Install MongoDB Compass (Optional)
Download [MongoDB Compass](https://www.mongodb.com/products/compass) for a GUI to view your database.

---

## 🔧 Quick Setup Commands

After getting your connection string from MongoDB Atlas:

```bash
# Update .env file with your MongoDB Atlas connection string
echo "MONGODB_URI=your_mongodb_atlas_connection_string_here" >> .env
echo "USE_MOCK_DATABASE=false" >> .env

# Restart your server
npm run dev
```

## 📋 Connection String Format

Your final connection string should look like:
```
mongodb+srv://ride-admin:yourpassword@ride-sharing-cluster.xxxxx.mongodb.net/ride-sharing?retryWrites=true&w=majority
```

Replace:
- `yourpassword` with your database user password
- `ride-sharing-cluster.xxxxx` with your actual cluster name
- `ride-sharing` with your preferred database name

## ✅ Verification

Once connected, you should see in your server logs:
```
📦 MongoDB Connected: ride-sharing-cluster.xxxxx.mongodb.net
```

Instead of:
```
🔧 In-memory MongoDB connected: 127.0.0.1
```

## 🔒 Security Best Practices

1. **Never commit credentials**: Keep your `.env` file in `.gitignore`
2. **Use strong passwords**: Generate complex database passwords
3. **Limit IP access**: In production, only allow specific IP addresses
4. **Rotate credentials**: Change passwords regularly
5. **Monitor access**: Check Atlas logs regularly

## 📊 Database Structure

Your MongoDB Atlas database will contain:
- **users** collection: Admin, customers, drivers
- **orders** collection: All ride orders
- **indexes**: Geospatial indexes for location-based queries

## 🆘 Troubleshooting

**Connection Issues:**
- Check network access settings
- Verify IP whitelist
- Confirm username/password
- Check connection string format

**Permission Errors:**
- Ensure user has read/write permissions
- Verify database name in connection string

**Performance:**
- Free tier has connection limits
- Consider upgrading for production use
