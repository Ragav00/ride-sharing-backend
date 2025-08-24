# 🚂 Railway.com Deployment Guide

## ✅ Pre-Deployment Checklist

Your setup is ready! Here's what we've configured:

- ✅ **MongoDB Atlas**: Connected to `rider.dvycreo.mongodb.net`
- ✅ **Database**: `ride-sharing` 
- ✅ **User**: `ride-admin`
- ✅ **Railway Config**: Dockerfile and nixpacks.toml created
- ✅ **Environment**: Production .env configured

## 🚀 Step-by-Step Railway Deployment

### Step 1: Push to GitHub
```bash
# Add all files
git add .

# Commit your changes
git commit -m "Ready for Railway deployment with MongoDB Atlas"

# Push to GitHub
git push origin main
```

### Step 2: Create Railway Account
1. Go to https://railway.app/
2. Sign up with GitHub (recommended)
3. Verify your account (you may need to add payment method for free credits)

### Step 3: Deploy from GitHub
1. **Click "New Project"**
2. **Select "Deploy from GitHub repo"**
3. **Choose your ride-sharing repository**
4. **Railway will automatically detect Node.js and start building**

### Step 4: Add Redis Service
1. **In your Railway project dashboard**
2. **Click "New Service"**
3. **Select "Redis"** 
4. **Railway will automatically provide `REDIS_URL`**

### Step 5: Configure Environment Variables

In your Railway project, go to **Variables** tab and add:

```env
NODE_ENV=production
```bash
# Set your MongoDB Atlas connection string
MONGODB_URI=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/YOUR_DATABASE?retryWrites=true&w=majority&appName=YOUR_APP_NAME

# Important: Replace placeholders with your actual values
# URL-encode special characters in password (@ becomes %40, # becomes %23, etc.)
```
JWT_SECRET=ride-sharing-super-secret-jwt-key-2024-railway-production
FRONTEND_URL=https://your-app.vercel.app
ALLOWED_ORIGINS=https://your-app.vercel.app
RATE_LIMIT_WINDOW=900000
RATE_LIMIT_MAX_REQUESTS=100
```

**Note**: `REDIS_URL` and `PORT` are automatically provided by Railway

### Step 6: Custom Domain (Optional)
1. **In Railway dashboard → Settings**
2. **Add custom domain**: `api.yourdomain.com`
3. **Add CNAME record in your domain DNS**:
   ```
   CNAME api yourproject.railway.app
   ```

## 🔧 MongoDB Atlas Verification

If you encounter authentication issues:

1. **Go to MongoDB Atlas Dashboard**
2. **Check Database Access**:
   - User: `ride-admin`
   - Password: `Ragav@95` 
   - Roles: `readWrite` on `ride-sharing` database

3. **Check Network Access**:
   - Add IP: `0.0.0.0/0` (allow from anywhere)
   - Or add Railway's IP ranges

4. **Test Connection** from your local machine:
   ```bash
   # Test with our backend
   npm run dev
   ```

## 🎯 After Deployment

Your Railway app will be available at:
- **API**: `https://yourproject.railway.app/api`
- **Admin Dashboard**: `https://yourproject.railway.app/admin.html`
- **Health Check**: `https://yourproject.railway.app/api/health`
- **API Documentation**: `https://yourproject.railway.app/api-docs`

## 🔄 Update Your Vercel Frontend

Once deployed, update your Vercel environment variables:

```env
NEXT_PUBLIC_API_URL=https://yourproject.railway.app/api
NEXT_PUBLIC_WS_URL=wss://yourproject.railway.app
```

## 📊 Test Your Deployment

1. **Health Check**:
   ```bash
   curl https://yourproject.railway.app/api/health
   ```

2. **Create Admin User**:
   ```bash
   curl -X POST https://yourproject.railway.app/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{"name":"Railway Admin","email":"admin@yourdomain.com","password":"password123","phone":"+1234567890","userType":"admin"}'
   ```

3. **Test Admin Login**:
   - Go to: `https://yourproject.railway.app/admin.html`
   - Login with your admin credentials

## 💰 Railway Costs

**Free Tier Benefits**:
- ✅ $5/month usage credit
- ✅ Redis included (saves $10-15/month)
- ✅ Automatic scaling
- ✅ SSL certificates
- ✅ Custom domains

**Expected Usage**:
- **Development**: $0-2/month
- **Small Production**: $2-5/month
- **Active Production**: $5-15/month

## 🆘 Troubleshooting

### Common Issues:

1. **Build Fails**:
   - Check Node.js version in package.json
   - Verify all dependencies are listed

2. **MongoDB Connection**:
   - Verify password URL encoding for special characters
   - Check MongoDB Atlas network access
   - Ensure user has correct permissions

3. **Redis Issues**:
   - Make sure Redis service is added to Railway project
   - `REDIS_URL` should be automatically set

4. **CORS Errors**:
   - Update `ALLOWED_ORIGINS` with your Vercel URL
   - Ensure frontend URL is correct

### Debug Commands:
```bash
# Check Railway logs
railway logs

# Connect to Railway shell
railway shell

# Check environment variables
railway variables
```

## 🎉 Success Checklist

- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] Redis service added
- [ ] Environment variables configured
- [ ] Deployment successful (green checkmark)
- [ ] Health check returns 200 OK
- [ ] Admin dashboard accessible
- [ ] MongoDB connection working
- [ ] Redis connection working
- [ ] Frontend can communicate with backend

## 📞 Support

If you encounter issues:
1. Check Railway deployment logs
2. Verify MongoDB Atlas settings
3. Test health endpoint
4. Check environment variable configuration

Your ride-sharing backend is ready for production! 🚗✨
