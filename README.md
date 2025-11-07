# LinkFox AI设计平台

![LinkFox](https://img.shields.io/badge/LinkFox-AI%20Design-blue)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.16-green)
![Vue](https://img.shields.io/badge/Vue-3.3.4-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

一个功能强大的AI图像生成和电商设计平台，参考 [LinkFox.com](https://www.linkfox.com/home) 的UI设计风格构建。

## ✨ 功能特性

### 核心功能
- 🎨 **智能修图** - AI驱动的图片智能编辑
- 🌄 **场景制变** - 一键更换图片背景和场景
- 🛍️ **商品图生成** - 专业电商商品图制作
- 👔 **AI穿衣** - 虚拟试衣，AI换装
- 👤 **真人模特** - AI生成真人模特图
- 🚀 **批量处理** - 批量图片处理，提高效率

### 用户系统
- ✅ 用户注册/登录
- 💰 算力积分系统
- 👑 VIP会员体系
- 📊 个人作品管理

### UI设计特点
- 🎯 参考LinkFox的现代化UI设计
- 🎨 渐变色彩搭配（蓝色系+橙色系）
- 💎 大圆角卡片设计
- ✨ 流畅的动画效果
- 📱 响应式布局，支持移动端

## 🛠️ 技术栈

### 后端技术
- **Spring Boot 2.7.16** - 核心框架
- **MyBatis Plus 3.5.3** - ORM框架
- **MySQL 8.0** - 数据库
- **Redis** - 缓存
- **Spring Security** - 安全认证
- **JWT** - Token认证
- **Hutool** - 工具类库

### 前端技术
- **Vue 3.3.4** - 前端框架
- **Vite 4.5.0** - 构建工具
- **Element Plus 2.4.2** - UI组件库
- **Vue Router 4.2.5** - 路由管理
- **Pinia 2.1.7** - 状态管理
- **Axios 1.5.1** - HTTP客户端
- **SCSS** - CSS预处理器

## 📁 项目结构

```
linkfox-ai-design/
├── backend/                      # 后端项目
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/linkfox/
│   │   │   │   ├── config/      # 配置类
│   │   │   │   ├── controller/  # 控制器
│   │   │   │   ├── service/     # 服务层
│   │   │   │   ├── mapper/      # 数据访问层
│   │   │   │   ├── entity/      # 实体类
│   │   │   │   ├── dto/         # 数据传输对象
│   │   │   │   ├── common/      # 通用类
│   │   │   │   └── utils/       # 工具类
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       └── sql/
│   │   │           └── schema.sql  # 数据库脚本
│   │   └── test/
│   └── pom.xml
│
└── frontend/                     # 前端项目
    ├── src/
    │   ├── api/                 # API接口
    │   ├── assets/              # 静态资源
    │   ├── components/          # 组件
    │   ├── router/              # 路由
    │   ├── stores/              # 状态管理
    │   ├── views/               # 页面
    │   ├── App.vue
    │   └── main.js
    ├── index.html
    ├── package.json
    └── vite.config.js
```

## 🚀 快速开始

### 方式一：Docker一键启动 ⭐ 推荐

**最简单的方式！** 使用Docker运行数据库，自动完成所有配置。

#### 环境要求
- Docker Desktop (或 Docker + Docker Compose)
- JDK 11+
- Maven 3.6+
- Node.js 16+

#### 启动步骤

```bash
# 1. 进入项目目录
cd linkfox-ai-design

# 2. 一键启动（包含数据库、后端、前端）
./start.sh

# 3. 访问应用
# 浏览器打开 http://localhost:3000
```

**就这么简单！** 脚本会自动：
- ✅ 启动MySQL和Redis（Docker容器）
- ✅ 初始化数据库和测试数据
- ✅ 编译并启动后端服务
- ✅ 安装并启动前端服务

停止服务：
```bash
./stop.sh
```

📖 详细说明请查看 [DOCKER_QUICKSTART.md](DOCKER_QUICKSTART.md)

---

### 方式二：传统方式部署

需要自己安装和配置数据库。

#### 环境要求
- JDK 11+
- Node.js 16+
- MySQL 8.0+
- Redis 5.0+ (可选)
- Maven 3.6+

### 后端部署

1. **导入数据库**
```bash
# 创建数据库并执行SQL脚本
mysql -u root -p < backend/src/main/resources/sql/schema.sql
```

2. **修改配置文件**
```yaml
# backend/src/main/resources/application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/linkfox_db
    username: your_username
    password: your_password
```

3. **启动后端服务**
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

后端服务将在 `http://localhost:8080/api` 启动

### 前端部署

1. **安装依赖**
```bash
cd frontend
npm install
```

2. **启动开发服务器**
```bash
npm run dev
```

前端服务将在 `http://localhost:3000` 启动

3. **构建生产版本**
```bash
npm run build
```

## 📊 数据库设计

### 主要数据表
- `user` - 用户表
- `category` - 分类表
- `artwork` - 作品表
- `tag` - 标签表
- `artwork_tag` - 作品标签关联表
- `order` - 订单表
- `points_record` - 积分记录表

详细的数据库表结构请查看 `backend/src/main/resources/sql/schema.sql`

## 🎨 UI设计参考

本项目UI设计完全参考 [LinkFox.com](https://www.linkfox.com/home)，主要特点：

1. **配色方案**
   - 主色调：蓝色渐变 (#5B7FFF → #7B9FFF)
   - 辅助色：橙色渐变 (#FF7849 → #FF9869)
   - 背景色：白色 + 浅灰 (#F8F9FA)

2. **设计元素**
   - 大圆角卡片 (16px+)
   - 柔和阴影效果
   - 渐变按钮
   - 悬浮动画效果

3. **布局特点**
   - 固定顶部导航栏
   - 居中内容区域（最大宽度1400px）
   - 网格布局展示内容
   - 悬浮客服按钮

## 🔐 默认账号

系统内置了测试账号：

| 用户名 | 密码 | 角色 | 算力 |
|-------|------|------|------|
| admin | 123456 | 管理员 | 10000 |
| testuser | 123456 | 普通用户 | 100 |

## 📝 API文档

### 用户相关
- `POST /api/user/register` - 用户注册
- `POST /api/user/login` - 用户登录
- `GET /api/user/{id}` - 获取用户信息
- `PUT /api/user/update` - 更新用户信息

### 作品相关
- `POST /api/artwork/upload` - 上传作品
- `POST /api/artwork/list` - 查询作品列表
- `GET /api/artwork/{id}` - 获取作品详情
- `DELETE /api/artwork/{id}` - 删除作品

### 分类相关
- `GET /api/category/list` - 获取所有分类
- `GET /api/category/{id}` - 获取分类详情

## 🔧 开发指南

### 后端开发
1. 所有API统一返回格式使用 `Result<T>` 包装
2. 分页查询使用 `PageResult<T>`
3. 使用MyBatis Plus简化CRUD操作
4. JWT Token存储在请求头 `Authorization: Bearer {token}`

### 前端开发
1. 使用Composition API编写Vue组件
2. 使用Pinia进行状态管理
3. 使用Axios拦截器统一处理请求/响应
4. 遵循Element Plus组件库规范

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

1. Fork本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

## 📄 开源协议

本项目采用 MIT 协议开源。

## 📧 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 Issue
- 发送邮件至：dev@linkfox.com

## 🙏 致谢

- 感谢 [LinkFox.com](https://www.linkfox.com/home) 提供的UI设计参考
- 感谢所有开源项目的贡献者

## 📸 项目截图

### 首页
![首页](docs/screenshots/home.png)

### 作品广场
![作品广场](docs/screenshots/artworks.png)

### 个人中心
![个人中心](docs/screenshots/profile.png)

---

⭐ 如果这个项目对您有帮助，请给个Star支持一下！

