# 🚂 Railway Deployment - Environment Variables Setup

Copy and paste these 2. **MongoDB Connection Failed**
   - Ensure password is URL-encoded (special characters like @, #, etc.)
   - Check MongoDB Atlas network access allows 0.0.0.0/0xact** environment variables in your Railway project dashboard:

## 📋 **Required Environment Variables**

### **Core Application**
```
NODE_ENV=production
JWT_SECRET=ride-sharing-super-secret-jwt-key-2024-railway-production
JWT_EXPIRES_IN=24h
```

### **MongoDB Atlas Connection** ⚠️ **IMPORTANT**
```
MONGODB_URI=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/YOUR_DATABASE?retryWrites=true&w=majority&appName=YOUR_APP_NAME
```
**Note:** Replace with your actual MongoDB Atlas connection string with URL-encoded password

### **Security & Rate Limiting**
```
RATE_LIMIT_WINDOW=900000
RATE_LIMIT_MAX_REQUESTS=100
```

### **CORS (Update after getting Railway URL)**
```
FRONTEND_URL=https://your-railway-app.railway.app
ALLOWED_ORIGINS=https://your-railway-app.railway.app
WEBSOCKET_CORS_ORIGINS=https://your-railway-app.railway.app
```

---

## ✅ **Automatic Railway Variables**

These are **automatically set** by Railway (don't add manually):
- `PORT` - Railway assigns port automatically
- `REDIS_URL` - Set when you add Redis service
- `RAILWAY_ENVIRONMENT` - Set to production
- `RAILWAY_PUBLIC_DOMAIN` - Your app's public URL

---

## 🔧 **Step-by-Step Setup**

### **1. Add Redis Service**
1. In Railway dashboard → Click **"+ New Service"**
2. Select **"Database"** → **"Redis"**
3. Click **"Add Redis"**

### **2. Set Environment Variables**
1. Go to your service → **"Variables"** tab
2. Click **"+ New Variable"**
3. Add each variable from the list above
4. Click **"Deploy"**

### **3. Verify Deployment**
1. Check **"Deployments"** tab for build status
2. Click on your deployment URL
3. Test endpoint: `https://your-app.railway.app/api/health`

---

## 🚀 **Expected Railway URLs**

After deployment, you'll get:
- **API Base:** `https://your-project-name.railway.app`
- **Health Check:** `https://your-project-name.railway.app/api/health`
- **Admin Dashboard:** `https://your-project-name.railway.app/admin.html`

---

## 🔍 **Troubleshooting**

### **Common Issues:**
1. **MongoDB Connection Failed**
   - Ensure password is URL-encoded: `Ragav%4095` (not `Ragav@95`)
   - Check MongoDB Atlas network access allows 0.0.0.0/0

2. **Redis Connection Failed**
   - Ensure Redis service is added to your project
   - `REDIS_URL` should be automatically provided

3. **Build Failed**
   - Check build logs in Railway dashboard
   - Ensure all dependencies are in package.json

### **Test Commands**
```bash
# Test MongoDB connection
curl https://your-app.railway.app/api/health

# Test API endpoints
curl https://your-app.railway.app/api/auth/health
```

---

## 🎉 **Success Checklist**

- [ ] Redis service added to Railway project
- [ ] All environment variables configured
- [ ] MongoDB connection string properly URL-encoded
- [ ] Build completed successfully
- [ ] Health check endpoint responds
- [ ] Admin dashboard accessible

**Your ride-sharing backend is now live on Railway! 🚀**
