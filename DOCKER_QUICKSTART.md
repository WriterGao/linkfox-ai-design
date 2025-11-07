# Docker 快速启动指南

使用Docker运行数据库，一键启动完整的LinkFox AI设计平台。

## 📋 前置条件

确保已安装以下软件：

- ✅ **Docker Desktop** (推荐) 或 Docker Engine
- ✅ **Docker Compose** (通常包含在Docker Desktop中)
- ✅ **JDK 11+**
- ✅ **Maven 3.6+**
- ✅ **Node.js 16+**

### 检查安装

```bash
# 检查Docker
docker --version
# 输出示例: Docker version 24.0.6

# 检查Docker Compose
docker-compose --version
# 输出示例: Docker Compose version v2.23.0

# 检查Java
java -version
# 输出示例: openjdk version "11.0.20"

# 检查Maven
mvn -version
# 输出示例: Apache Maven 3.9.5

# 检查Node.js
node -v
# 输出示例: v16.20.0
```

## 🚀 一键启动（推荐）

### 方式一：使用启动脚本（最简单）

```bash
# 1. 进入项目目录
cd linkfox-ai-design

# 2. 赋予执行权限
chmod +x start.sh stop.sh

# 3. 运行启动脚本
./start.sh

# 脚本会自动完成：
# ✓ 检查环境
# ✓ 启动MySQL和Redis（Docker）
# ✓ 编译并启动后端
# ✓ 安装并启动前端
```

启动成功后会显示：

```
======================================
✓ 所有服务启动成功！
======================================

服务地址：
  前端: http://localhost:3000
  后端: http://localhost:8080/api
  MySQL: localhost:3306
  Redis: localhost:6379

测试账号：
  用户名: admin 或 testuser
  密码: 123456
```

### 停止服务

```bash
./stop.sh
```

## 🔧 手动启动（分步骤）

如果您想更精细地控制启动过程，可以按照以下步骤操作。

### 步骤1: 启动Docker数据库 (1分钟)

```bash
# 启动MySQL和Redis
docker-compose up -d

# 查看容器状态
docker-compose ps

# 应该看到：
# linkfox-mysql   running   0.0.0.0:3306->3306/tcp
# linkfox-redis   running   0.0.0.0:6379->6379/tcp

# 等待MySQL初始化完成（首次启动需要约30秒）
# 查看MySQL日志
docker-compose logs -f mysql

# 看到以下信息说明MySQL已就绪：
# [Server] /usr/sbin/mysqld: ready for connections
```

### 步骤2: 验证数据库 (可选)

```bash
# 连接到MySQL
docker-compose exec mysql mysql -uroot -plinkfox123456

# 在MySQL命令行中：
USE linkfox_db;
SHOW TABLES;

# 应该看到7张表：
# +----------------------+
# | Tables_in_linkfox_db |
# +----------------------+
# | artwork              |
# | artwork_tag          |
# | category             |
# | order                |
# | points_record        |
# | tag                  |
# | user                 |
# +----------------------+

# 查看测试用户
SELECT id, username, nickname, points FROM user;

# 退出MySQL
exit
```

### 步骤3: 启动后端 (2分钟)

```bash
# 进入后端目录
cd backend

# 编译项目
mvn clean package -DskipTests

# 启动后端（使用Docker配置）
java -jar target/linkfox-backend-1.0.0.jar --spring.profiles.active=docker

# 或者使用Maven直接运行
mvn spring-boot:run -Dspring-boot.run.profiles=docker

# 看到以下信息说明启动成功：
# ====================================
# LinkFox AI设计平台启动成功！
# 接口文档地址: http://localhost:8080/api
# ====================================
```

**测试后端：**

```bash
# 新开一个终端，测试接口
curl http://localhost:8080/api/category/list

# 应该返回分类列表的JSON数据
```

### 步骤4: 启动前端 (2分钟)

```bash
# 新开一个终端
cd frontend

# 安装依赖（首次运行）
npm install

# 启动前端
npm run dev

# 看到以下信息说明启动成功：
# VITE v4.5.0  ready in 500 ms
# ➜  Local:   http://localhost:3000/
```

### 步骤5: 访问应用

打开浏览器访问：**http://localhost:3000**

使用测试账号登录：
- 用户名：`admin` 或 `testuser`
- 密码：`123456`

## 📊 服务管理

### 查看服务状态

```bash
# 查看Docker容器
docker-compose ps

# 查看容器日志
docker-compose logs -f mysql    # MySQL日志
docker-compose logs -f redis    # Redis日志

# 查看后端日志（如果使用启动脚本）
tail -f logs/backend.log

# 查看前端日志（如果使用启动脚本）
tail -f logs/frontend.log
```

### 停止服务

```bash
# 使用停止脚本
./stop.sh

# 或手动停止
# 1. Ctrl+C 停止前端和后端（如果在前台运行）
# 2. 停止Docker容器
docker-compose down

# 完全清理（包括数据）
docker-compose down -v
```

### 重启服务

```bash
# 重启数据库
docker-compose restart mysql redis

# 重启所有服务
./stop.sh
./start.sh
```

## 🗄️ 数据库管理

### 连接信息

```yaml
主机: localhost
端口: 3306
数据库: linkfox_db
用户名: root
密码: linkfox123456
```

### 使用命令行连接

```bash
# 使用Docker执行MySQL命令
docker-compose exec mysql mysql -uroot -plinkfox123456 linkfox_db

# 或使用本地MySQL客户端
mysql -h localhost -P 3306 -u root -plinkfox123456 linkfox_db
```

### 使用图形化工具

推荐使用以下工具连接数据库：
- **MySQL Workbench**
- **Navicat**
- **DBeaver**
- **phpMyAdmin**

### 数据备份

```bash
# 备份数据库
docker-compose exec mysql mysqldump -uroot -plinkfox123456 linkfox_db > backup.sql

# 恢复数据库
docker-compose exec -T mysql mysql -uroot -plinkfox123456 linkfox_db < backup.sql
```

### 重置数据库

```bash
# 停止服务
docker-compose down

# 删除数据卷（会清空所有数据）
docker volume rm linkfox-ai-design_mysql_data

# 重新启动（会自动执行初始化脚本）
docker-compose up -d mysql

# 等待初始化完成
docker-compose logs -f mysql
```

## ⚙️ 配置说明

### Docker Compose配置

文件位置：`docker-compose.yml`

主要配置：
```yaml
services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: linkfox123456  # 可修改密码
      MYSQL_DATABASE: linkfox_db
    ports:
      - "3306:3306"  # 如端口冲突可改为 "3307:3306"
    
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"  # 如端口冲突可改为 "6380:6379"
```

### 后端配置

文件位置：`backend/src/main/resources/application-docker.yml`

关键配置：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/linkfox_db
    username: root
    password: linkfox123456  # 需与Docker配置一致
  
  redis:
    host: localhost
    port: 6379
```

## ❓ 常见问题

### 1. Docker容器启动失败

**问题：** 端口已被占用

```bash
# 检查端口占用
lsof -i :3306  # MySQL
lsof -i :6379  # Redis

# 解决方案1: 停止占用端口的程序
# 解决方案2: 修改docker-compose.yml中的端口映射
# 例如将 "3306:3306" 改为 "3307:3306"
```

**问题：** Docker服务未运行

```bash
# macOS
open -a Docker

# Linux
sudo systemctl start docker

# 验证Docker是否运行
docker info
```

### 2. MySQL初始化失败

**问题：** 数据库脚本执行失败

```bash
# 查看MySQL日志
docker-compose logs mysql

# 手动执行初始化脚本
docker-compose exec -T mysql mysql -uroot -plinkfox123456 < backend/src/main/resources/sql/schema.sql
```

### 3. 后端连接数据库失败

**问题：** `Access denied for user`

- 检查密码是否正确
- 确认 `application-docker.yml` 中的密码与 `docker-compose.yml` 一致

**问题：** `Communications link failure`

```bash
# 确认MySQL已启动
docker-compose ps mysql

# 测试数据库连接
docker-compose exec mysql mysql -uroot -plinkfox123456 -e "SELECT 1"
```

### 4. 前端无法连接后端

**问题：** 网络错误

```bash
# 测试后端是否运行
curl http://localhost:8080/api/category/list

# 检查Vite代理配置
# frontend/vite.config.js
```

### 5. 文件上传失败

**问题：** 权限不足

```bash
# 创建上传目录并设置权限
mkdir -p /tmp/linkfox/uploads
chmod 777 /tmp/linkfox/uploads
```

## 🔍 调试技巧

### 查看详细日志

```bash
# Docker容器日志
docker-compose logs -f --tail=100 mysql

# 后端调试模式
# 修改 application-docker.yml
logging:
  level:
    com.linkfox: debug
    
# 前端开发者工具
# 浏览器按F12打开控制台
```

### 进入容器调试

```bash
# 进入MySQL容器
docker-compose exec mysql bash

# 进入Redis容器
docker-compose exec redis sh

# 执行Redis命令
docker-compose exec redis redis-cli
```

## 📦 数据持久化

Docker Compose会自动创建数据卷来持久化数据：

- `mysql_data` - MySQL数据
- `redis_data` - Redis数据

即使容器被删除，数据也会保留。

查看数据卷：
```bash
docker volume ls | grep linkfox
```

## 🚀 生产环境部署

Docker方式也适用于生产环境，详见 [部署指南](docs/部署指南.md)。

---

🎉 **恭喜！** 您已成功使用Docker启动LinkFox AI设计平台！

如有问题，请查看 [README.md](README.md) 或提交Issue。

