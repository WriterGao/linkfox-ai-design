# 🎉 LinkFox AI设计平台 - GitHub 发布说明

## 📦 仓库信息

- **仓库地址**: https://github.com/WriterGao/linkfox-ai-design
- **项目描述**: 🎨 LinkFox AI设计平台 - 基于Spring Boot和Vue3的AI图像生成和电商设计平台
- **默认分支**: main
- **创建时间**: 2025-11-07

## 🏷️ 项目标签

- vue3
- spring-boot
- ai
- image-generation
- ecommerce
- design-platform
- element-plus
- mybatis-plus
- mysql
- redis
- docker
- java
- javascript
- ai-design
- fullstack

## ✨ 主要特性

### 后端技术栈
- ✅ Spring Boot 2.7.x
- ✅ MyBatis Plus
- ✅ MySQL 8.0
- ✅ Redis
- ✅ Spring Security + JWT
- ✅ Docker 容器化部署

### 前端技术栈
- ✅ Vue 3 + Vite
- ✅ Element Plus UI组件库
- ✅ Pinia 状态管理
- ✅ Vue Router 路由
- ✅ Axios HTTP客户端
- ✅ SCSS 样式预处理

## 🚀 快速开始

### 使用Docker（推荐）

```bash
# 1. 克隆项目
git clone https://github.com/WriterGao/linkfox-ai-design.git
cd linkfox-ai-design

# 2. 一键启动（自动启动MySQL、Redis、后端、前端）
chmod +x start.sh
./start.sh

# 3. 访问应用
# 前端: http://localhost:3001
# 后端: http://localhost:8080
```

### 停止服务

```bash
./stop.sh
```

## 👤 测试账号

### 管理员账号
- **用户名**: admin
- **密码**: 123456
- **初始积分**: 10000

### 测试账号
- **用户名**: testuser
- **密码**: 123456
- **初始积分**: 100

## 📖 文档

- [快速开始指南](./QUICKSTART.md)
- [Docker部署指南](./DOCKER_QUICKSTART.md)
- [项目结构说明](./PROJECT_STRUCTURE.md)
- [API文档](./docs/API文档.md)
- [UI设计说明](./docs/UI设计说明.md)
- [开发规范](./docs/开发规范.md)
- [部署指南](./docs/部署指南.md)

## 🔧 环境要求

### Docker部署（推荐）
- Docker 20.10+
- Docker Compose 2.0+
- 8GB+ RAM
- 20GB+ 可用磁盘空间

### 传统部署
- JDK 11+
- Maven 3.6+
- Node.js 16+
- MySQL 8.0+
- Redis 6.0+

## 📂 项目结构

```
linkfox-ai-design/
├── backend/                 # Spring Boot 后端
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/       # Java 源码
│   │   │   └── resources/  # 配置文件
│   │   └── test/           # 测试代码
│   └── pom.xml             # Maven 配置
├── frontend/               # Vue 3 前端
│   ├── src/
│   │   ├── api/           # API 接口
│   │   ├── components/    # 组件
│   │   ├── views/         # 页面
│   │   ├── stores/        # 状态管理
│   │   └── router/        # 路由配置
│   └── package.json       # npm 配置
├── docker/                # Docker 配置
│   └── mysql/            # MySQL 配置
├── docs/                 # 项目文档
├── docker-compose.yml    # Docker Compose 配置
├── start.sh             # 启动脚本
└── stop.sh              # 停止脚本
```

## 🎯 核心功能

1. **用户系统**
   - 用户注册、登录
   - JWT Token 认证
   - 积分系统
   - VIP会员

2. **AI功能**
   - 智能修图
   - 场景制变
   - 商品图生成
   - AI穿衣
   - 真人模特
   - 批量生图

3. **作品管理**
   - 作品上传
   - 作品展示
   - 作品分类
   - 作品搜索

4. **界面设计**
   - 响应式布局
   - 美观的UI设计
   - 流畅的动画效果
   - 优秀的用户体验

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

## 📝 更新日志

### v1.0.0 (2025-11-07)

#### ✨ 新增功能
- ✅ 完整的用户认证系统（注册、登录、JWT）
- ✅ 6大AI功能模块展示
- ✅ 作品管理和展示系统
- ✅ 响应式UI设计
- ✅ Docker一键部署
- ✅ 完整的API文档

#### 🐛 问题修复
- ✅ 修复BCrypt密码验证问题
- ✅ 修复JWT密钥长度不足问题
- ✅ 优化前端布局和样式
- ✅ 修复Element Plus图标导入问题

#### 📚 文档完善
- ✅ 添加完整的README文档
- ✅ 添加Docker快速开始指南
- ✅ 添加API接口文档
- ✅ 添加开发规范文档

## 📄 许可证

MIT License

Copyright (c) 2025 WriterGao

## 🔗 相关链接

- [GitHub仓库](https://github.com/WriterGao/linkfox-ai-design)
- [作者GitHub](https://github.com/WriterGao)
- [参考网站](https://www.linkfox.com/home)

---

**⭐ 如果这个项目对你有帮助，请给个 Star 支持一下！**

**📧 联系方式**: writergao@users.noreply.github.com

