#!/bin/bash

# LinkFox AI设计平台 - 停止脚本

echo "======================================"
echo "  LinkFox AI设计平台 - 停止脚本"
echo "======================================"
echo ""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 停止前端
if [ -f logs/frontend.pid ]; then
    FRONTEND_PID=$(cat logs/frontend.pid)
    if ps -p $FRONTEND_PID > /dev/null 2>&1; then
        echo -e "${BLUE}正在停止前端服务...${NC}"
        kill $FRONTEND_PID
        echo -e "${GREEN}✓ 前端服务已停止${NC}"
    fi
    rm -f logs/frontend.pid
else
    echo -e "${YELLOW}前端服务未运行${NC}"
fi

# 停止后端
if [ -f logs/backend.pid ]; then
    BACKEND_PID=$(cat logs/backend.pid)
    if ps -p $BACKEND_PID > /dev/null 2>&1; then
        echo -e "${BLUE}正在停止后端服务...${NC}"
        kill $BACKEND_PID
        echo -e "${GREEN}✓ 后端服务已停止${NC}"
    fi
    rm -f logs/backend.pid
else
    echo -e "${YELLOW}后端服务未运行${NC}"
fi

# 停止Docker容器
echo -e "${BLUE}正在停止数据库服务...${NC}"
if docker compose version >/dev/null 2>&1; then
    docker compose down
else
    docker-compose down
fi

echo -e "${GREEN}✓ 数据库服务已停止${NC}"
echo ""
echo "======================================"
echo -e "${GREEN}✓ 所有服务已停止${NC}"
echo "======================================"
echo ""
echo "如需完全清理数据，请运行："
if docker compose version >/dev/null 2>&1; then
    echo "  docker compose down -v"
else
    echo "  docker-compose down -v"
fi

