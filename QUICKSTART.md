# 快速启动指南

这是一个5分钟快速启动指南，帮助您快速运行LinkFox AI设计平台。

## 📋 前置条件

确保您的系统已安装：
- ✅ JDK 11 或更高版本
- ✅ Maven 3.6+
- ✅ MySQL 8.0+
- ✅ Node.js 16+
- ✅ npm 或 yarn

## 🚀 快速启动（3步）

### 步骤1: 初始化数据库 (1分钟)

```bash
# 1. 登录MySQL
mysql -u root -p

# 2. 执行数据库脚本（在MySQL命令行中）
source /path/to/linkfox-ai-design/backend/src/main/resources/sql/schema.sql

# 或者使用命令行直接执行
mysql -u root -p < backend/src/main/resources/sql/schema.sql

# 验证数据库创建成功
mysql -u root -p -e "USE linkfox_db; SHOW TABLES;"
```

### 步骤2: 启动后端服务 (1分钟)

```bash
# 进入后端目录
cd linkfox-ai-design/backend

# 修改数据库配置（重要！）
# 编辑 src/main/resources/application.yml
# 修改以下配置：
#   username: your_username
#   password: your_password

# 启动后端（选择其中一种方式）

# 方式1: 使用Maven直接运行（推荐开发环境）
mvn spring-boot:run

# 方式2: 打包后运行
mvn clean package -DskipTests
java -jar target/linkfox-backend-1.0.0.jar

# 看到以下信息说明启动成功：
# ====================================
# LinkFox AI设计平台启动成功！
# 接口文档地址: http://localhost:8080/api
# ====================================
```

### 步骤3: 启动前端服务 (1分钟)

```bash
# 新开一个终端窗口
# 进入前端目录
cd linkfox-ai-design/frontend

# 安装依赖（首次运行需要，约30秒）
npm install

# 启动前端
npm run dev

# 看到以下信息说明启动成功：
# VITE v4.5.0  ready in 500 ms
# ➜  Local:   http://localhost:3000/
```

## 🎉 完成！

现在您可以：

1. **打开浏览器访问：** http://localhost:3000
2. **使用测试账号登录：**
   - 用户名：`admin` 或 `testuser`
   - 密码：`123456`

## 📸 您将看到

### 首页
- 顶部导航栏
- Banner促销区域
- 图片上传区域
- 功能卡片展示
- 优秀案例展示

### 可以做什么
- ✅ 注册新账号
- ✅ 登录系统
- ✅ 上传图片
- ✅ 浏览作品
- ✅ 查看个人中心

## ⚠️ 常见问题

### 1. 后端启动失败

**问题：** `Access denied for user 'root'@'localhost'`

**解决：**
```bash
# 检查MySQL是否运行
mysql --version

# 确认密码正确
mysql -u root -p

# 修改 application.yml 中的密码
```

### 2. 前端启动失败

**问题：** `Cannot find module ...`

**解决：**
```bash
# 删除node_modules重新安装
rm -rf node_modules package-lock.json
npm install
```

### 3. 无法连接后端

**问题：** 前端显示网络错误

**解决：**
```bash
# 检查后端是否启动
curl http://localhost:8080/api/category/list

# 检查端口是否被占用
lsof -i :8080
```

### 4. 数据库连接失败

**问题：** `Communications link failure`

**解决：**
```bash
# 检查MySQL服务
# macOS
brew services list | grep mysql

# Linux
sudo systemctl status mysql

# 启动MySQL
# macOS
brew services start mysql

# Linux
sudo systemctl start mysql
```

## 🔧 配置文件位置

### 后端配置
```
backend/src/main/resources/application.yml
```

关键配置：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/linkfox_db
    username: root        # 修改为您的用户名
    password: your_pass   # 修改为您的密码
```

### 前端配置
```
frontend/vite.config.js
```

代理配置（如果后端不是8080端口）：
```javascript
server: {
  proxy: {
    '/api': {
      target: 'http://localhost:8080',  // 修改为您的后端地址
      changeOrigin: true
    }
  }
}
```

## 📱 端口说明

| 服务 | 默认端口 | 说明 |
|-----|---------|------|
| 前端 | 3000 | Vue开发服务器 |
| 后端 | 8080 | Spring Boot应用 |
| MySQL | 3306 | 数据库服务 |
| Redis | 6379 | 缓存服务（可选）|

## 🎯 下一步

项目启动成功后，您可以：

1. **查看完整文档：**
   - [README.md](README.md) - 项目介绍
   - [API文档.md](docs/API文档.md) - 接口说明
   - [部署指南.md](docs/部署指南.md) - 生产部署
   - [UI设计说明.md](docs/UI设计说明.md) - UI规范
   - [开发规范.md](docs/开发规范.md) - 代码规范

2. **开始开发：**
   ```bash
   # 后端开发
   cd backend
   # 修改代码后会自动重启（如果使用spring-boot-devtools）
   
   # 前端开发
   cd frontend
   # 修改代码后会自动热更新
   ```

3. **运行测试：**
   ```bash
   # 后端测试
   cd backend
   mvn test
   
   # 前端测试
   cd frontend
   npm run test
   ```

## 💡 开发技巧

### 后端热更新
在 `pom.xml` 中已添加 `spring-boot-devtools`，代码修改后会自动重启。

### 前端热更新
Vite支持热模块替换（HMR），修改代码后浏览器自动刷新。

### 调试技巧
```bash
# 后端日志级别调整（application.yml）
logging:
  level:
    com.linkfox: debug

# 前端开发工具
# 安装Vue DevTools浏览器插件
```

## 📞 获取帮助

如果遇到问题：

1. **查看日志：**
   ```bash
   # 后端日志
   tail -f backend/logs/spring.log
   
   # 前端控制台
   # 按F12打开浏览器开发者工具
   ```

2. **查看文档：**
   - README.md
   - docs/目录下的所有文档

3. **提交Issue：**
   - 在GitHub上提交问题
   - 附上错误日志和环境信息

---

🎊 **恭喜！** 您已成功启动LinkFox AI设计平台！

现在可以开始探索和开发了。祝您开发愉快！ 🚀

