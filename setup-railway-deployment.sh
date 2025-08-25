#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${PURPLE}🚂 Railway.com Deployment Setup${NC}"
echo -e "${BLUE}================================================================${NC}"

# Create Railway configuration files
echo -e "${YELLOW}📝 Creating Railway configuration files...${NC}"

# Railway Dockerfile
cat > Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Change ownership
RUN chown -R nodejs:nodejs /app
USER nodejs

# Expose port
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:$PORT/api/health || exit 1

# Start application
CMD ["npm", "start"]
EOF

# Railway nixpacks.toml for better build configuration
cat > nixpacks.toml << 'EOF'
[phases.build]
cmds = ['npm ci --include=dev', 'npm run build']

[phases.start]
cmd = 'npm start'

[variables]
NPM_CONFIG_PRODUCTION = 'false'
NODE_ENV = 'production'
EOF

echo -e "${GREEN}✅ Railway configuration files created!${NC}"

# Update .env with MongoDB Atlas connection
echo -e "${YELLOW}📝 Setting up environment configuration...${NC}"

cat > .env.production << 'EOF'
# Production Environment Configuration
NODE_ENV=production
PORT=$PORT

# MongoDB Atlas Connection
MONGODB_URI=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/YOUR_DATABASE?retryWrites=true&w=majority&appName=YOUR_APP
USE_MOCK_DATABASE=false

# Railway Redis (Automatically provided by Railway)
REDIS_URL=$REDIS_URL
USE_MOCK_REDIS=false

# JWT Configuration
JWT_SECRET=ride-sharing-super-secret-jwt-key-2024-railway-production
JWT_EXPIRES_IN=24h

# CORS Configuration (Update with your Vercel URL)
FRONTEND_URL=https://your-app.vercel.app
ALLOWED_ORIGINS=https://your-app.vercel.app,$RAILWAY_PUBLIC_DOMAIN

# Security Settings
RATE_LIMIT_WINDOW=900000
RATE_LIMIT_MAX_REQUESTS=100

# WebSocket Configuration
WEBSOCKET_CORS_ORIGINS=https://your-app.vercel.app,$RAILWAY_PUBLIC_DOMAIN

# Railway Variables (Automatically set by Railway)
RAILWAY_ENVIRONMENT=$RAILWAY_ENVIRONMENT
RAILWAY_PROJECT_NAME=$RAILWAY_PROJECT_NAME
RAILWAY_PUBLIC_DOMAIN=$RAILWAY_PUBLIC_DOMAIN
EOF

echo -e "${GREEN}✅ Environment configuration created with your MongoDB Atlas connection!${NC}"

# Update package.json for Railway
echo -e "${YELLOW}📦 Updating package.json for Railway deployment...${NC}"

node << 'SCRIPT'
const fs = require('fs');

try {
  // Read current package.json
  const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));

  // Add Railway-optimized scripts
  packageJson.scripts = {
    ...packageJson.scripts,
    "start": "node src/app.js",
    "build": "echo 'Build completed - ready for Railway'",
    "railway:health": "curl $RAILWAY_PUBLIC_DOMAIN/api/health",
    "railway:logs": "railway logs"
  };

  // Add engines for Railway
  packageJson.engines = {
    "node": ">=18.0.0",
    "npm": ">=8.0.0"
  };

  // Write updated package.json
  fs.writeFileSync('package.json', JSON.stringify(packageJson, null, 2));
  console.log('✅ Package.json updated for Railway deployment');
} catch (error) {
  console.error('❌ Error updating package.json:', error.message);
}
SCRIPT

echo -e "${GREEN}🎉 Railway deployment setup complete!${NC}"
echo -e "${BLUE}================================================================${NC}"
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo -e "${YELLOW}1. Push your code to GitHub${NC}"
echo -e "${YELLOW}2. Go to https://railway.app and create account${NC}"
echo -e "${YELLOW}3. Create new project from GitHub repository${NC}"
echo -e "${YELLOW}4. Add Redis service to your Railway project${NC}"
echo -e "${YELLOW}5. Set environment variables in Railway dashboard${NC}"
echo -e "${YELLOW}6. Deploy and test!${NC}"
echo -e "${BLUE}================================================================${NC}"

echo -e "${PURPLE}🔧 Environment Variables for Railway Dashboard:${NC}"
echo -e "${BLUE}Add these in your Railway project settings:${NC}"
echo ""
echo -e "${GREEN}NODE_ENV=production${NC}"
echo -e "${GREEN}MONGODB_URI=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/YOUR_DATABASE?retryWrites=true&w=majority&appName=YOUR_APP${NC}"
echo -e "${GREEN}JWT_SECRET=ride-sharing-super-secret-jwt-key-2024-railway-production${NC}"
echo -e "${GREEN}FRONTEND_URL=https://your-app.vercel.app${NC}"
echo -e "${GREEN}ALLOWED_ORIGINS=https://your-app.vercel.app${NC}"
echo ""
echo -e "${YELLOW}Note: REDIS_URL and PORT are automatically provided by Railway${NC}"

echo -e "${PURPLE}📖 Your MongoDB connection is ready!${NC}"
echo -e "${GREEN}Database: YOUR_CLUSTER.mongodb.net${NC}"
echo -e "${GREEN}Collection: ride-sharing${NC}"
