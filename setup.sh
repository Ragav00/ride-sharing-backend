#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Ride Sharing Backend Setup${NC}"

# Check if .env file exists, if not copy from example
if [ ! -f .env ]; then
    echo -e "${YELLOW}📝 Creating .env file from template...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✅ .env file created. Please update it with your configuration.${NC}"
else
    echo -e "${GREEN}✅ .env file already exists.${NC}"
fi

# Check if MongoDB is running
echo -e "${YELLOW}🔍 Checking MongoDB connection...${NC}"
if command -v mongosh &> /dev/null; then
    mongosh --eval "db.adminCommand('ping')" --quiet > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ MongoDB is running${NC}"
    else
        echo -e "${RED}❌ MongoDB is not running. Please start MongoDB first.${NC}"
        echo -e "${YELLOW}💡 Try: brew services start mongodb/brew/mongodb-community${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  MongoDB Shell (mongosh) not found. Please install MongoDB.${NC}"
fi

# Check if Redis is running
echo -e "${YELLOW}🔍 Checking Redis connection...${NC}"
if command -v redis-cli &> /dev/null; then
    redis-cli ping > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Redis is running${NC}"
    else
        echo -e "${RED}❌ Redis is not running. Please start Redis first.${NC}"
        echo -e "${YELLOW}💡 Try: brew services start redis${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Redis CLI not found. Please install Redis.${NC}"
fi

echo -e "${GREEN}🏁 Setup complete! You can now run:${NC}"
echo -e "${YELLOW}   npm run dev    ${NC}# Start development server"
echo -e "${YELLOW}   npm start      ${NC}# Start production server"
echo -e "${YELLOW}   npm test       ${NC}# Run tests"
