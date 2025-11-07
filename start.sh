#!/bin/bash

# LinkFox AI设计平台 - 一键启动脚本

echo "======================================"
echo "  LinkFox AI设计平台 - 启动脚本"
echo "======================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检查Docker Compose命令
check_docker_compose() {
    if docker compose version >/dev/null 2>&1; then
        echo "docker compose"
    elif command_exists docker-compose; then
        echo "docker-compose"
    else
        echo ""
    fi
}

# 检查端口是否被占用
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        return 0
    else
        return 1
    fi
}

# 步骤1: 检查环境
echo -e "${BLUE}[步骤 1/5]${NC} 检查环境..."

if ! command_exists docker; then
    echo -e "${RED}错误: 未安装Docker，请先安装Docker${NC}"
    exit 1
fi

DOCKER_COMPOSE_CMD=$(check_docker_compose)
if [ -z "$DOCKER_COMPOSE_CMD" ]; then
    echo -e "${RED}错误: 未安装Docker Compose，请先安装Docker Compose${NC}"
    exit 1
fi

if ! command_exists mvn; then
    echo -e "${RED}错误: 未安装Maven，请先安装Maven${NC}"
    exit 1
fi

if ! command_exists node; then
    echo -e "${RED}错误: 未安装Node.js，请先安装Node.js${NC}"
    exit 1
fi

echo -e "${GREEN}✓ 环境检查通过${NC}"
echo ""

# 步骤2: 启动Docker数据库
echo -e "${BLUE}[步骤 2/5]${NC} 启动MySQL和Redis..."

# 检查Docker服务是否运行
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}错误: Docker服务未运行，请先启动Docker${NC}"
    exit 1
fi

# 启动数据库容器
echo "正在启动数据库容器..."
$DOCKER_COMPOSE_CMD up -d mysql redis

# 等待MySQL启动完成
echo "等待MySQL启动完成（约30秒）..."
sleep 5

# 检查MySQL健康状态
for i in {1..30}; do
    if $DOCKER_COMPOSE_CMD exec -T mysql mysqladmin ping -h localhost -u root -plinkfox123456 >/dev/null 2>&1; then
        echo -e "${GREEN}✓ MySQL启动成功${NC}"
        break
    fi
    if [ $i -eq 30 ]; then
        echo -e "${RED}错误: MySQL启动超时${NC}"
        echo "请运行以下命令查看日志："
        echo "$DOCKER_COMPOSE_CMD logs mysql"
        exit 1
    fi
    echo -n "."
    sleep 1
done

echo -e "${GREEN}✓ 数据库启动完成${NC}"
echo ""

# 步骤3: 启动后端
echo -e "${BLUE}[步骤 3/5]${NC} 启动后端服务..."

# 检查8080端口
if check_port 8080; then
    echo -e "${YELLOW}警告: 端口8080已被占用${NC}"
    read -p "是否继续？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

cd backend

# 编译后端
echo "正在编译后端项目..."
mvn clean package -DskipTests -q

if [ $? -ne 0 ]; then
    echo -e "${RED}错误: 后端编译失败${NC}"
    exit 1
fi

# 启动后端（后台运行）
echo "正在启动后端服务..."
nohup java -jar target/linkfox-backend-1.0.0.jar --spring.profiles.active=docker > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > ../logs/backend.pid

# 等待后端启动
echo "等待后端启动（约20秒）..."
for i in {1..40}; do
    if curl -s http://localhost:8080/api/category/list > /dev/null 2>&1; then
        echo -e "${GREEN}✓ 后端启动成功${NC}"
        break
    fi
    if [ $i -eq 40 ]; then
        echo -e "${RED}错误: 后端启动超时${NC}"
        echo "请查看日志: tail -f logs/backend.log"
        exit 1
    fi
    echo -n "."
    sleep 1
done

cd ..
echo ""

# 步骤4: 启动前端
echo -e "${BLUE}[步骤 4/5]${NC} 启动前端服务..."

# 检查3000端口
if check_port 3000; then
    echo -e "${YELLOW}警告: 端口3000已被占用${NC}"
    read -p "是否继续？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

cd frontend

# 检查node_modules
if [ ! -d "node_modules" ]; then
    echo "首次运行，正在安装前端依赖（可能需要几分钟）..."
    npm install
    if [ $? -ne 0 ]; then
        echo -e "${RED}错误: 前端依赖安装失败${NC}"
        exit 1
    fi
fi

# 启动前端（后台运行）
echo "正在启动前端服务..."
nohup npm run dev > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > ../logs/frontend.pid

# 等待前端启动
echo "等待前端启动（约10秒）..."
for i in {1..20}; do
    if curl -s http://localhost:3000 > /dev/null 2>&1; then
        echo -e "${GREEN}✓ 前端启动成功${NC}"
        break
    fi
    if [ $i -eq 20 ]; then
        echo -e "${YELLOW}警告: 前端启动可能需要更长时间${NC}"
        echo "请稍后手动访问 http://localhost:3000"
        break
    fi
    echo -n "."
    sleep 1
done

cd ..
echo ""

# 步骤5: 显示启动信息
echo -e "${BLUE}[步骤 5/5]${NC} 启动完成"
echo ""
echo "======================================"
echo -e "${GREEN}✓ 所有服务启动成功！${NC}"
echo "======================================"
echo ""
echo "服务地址："
echo -e "  ${BLUE}前端:${NC} http://localhost:3000"
echo -e "  ${BLUE}后端:${NC} http://localhost:8080/api"
echo -e "  ${BLUE}MySQL:${NC} localhost:3306"
echo -e "  ${BLUE}Redis:${NC} localhost:6379"
echo ""
echo "测试账号："
echo -e "  ${BLUE}用户名:${NC} admin 或 testuser"
echo -e "  ${BLUE}密码:${NC} 123456"
echo ""
echo "数据库连接："
echo -e "  ${BLUE}主机:${NC} localhost:3306"
echo -e "  ${BLUE}数据库:${NC} linkfox_db"
echo -e "  ${BLUE}用户名:${NC} root"
echo -e "  ${BLUE}密码:${NC} linkfox123456"
echo ""
echo "常用命令："
echo -e "  ${YELLOW}查看后端日志:${NC} tail -f logs/backend.log"
echo -e "  ${YELLOW}查看前端日志:${NC} tail -f logs/frontend.log"
echo -e "  ${YELLOW}查看数据库日志:${NC} docker-compose logs -f mysql"
echo -e "  ${YELLOW}停止所有服务:${NC} ./stop.sh"
echo ""
echo "======================================"
echo -e "${GREEN}🎉 享受使用 LinkFox AI设计平台！${NC}"
echo "======================================"

