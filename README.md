# LinkFox AI设计平台 🎨

<div align="center">

![LinkFox](https://img.shields.io/badge/LinkFox-AI%20Design-5B7FFF?style=for-the-badge)
![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-green?style=for-the-badge&logo=spring)
![Vue](https://img.shields.io/badge/Vue-3.4-42b883?style=for-the-badge&logo=vue.js)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**基于Spring Boot和Vue3的AI图像生成和电商设计平台**

[在线演示](#) | [使用文档](./docs) | [API文档](./docs/API文档.md) | [问题反馈](https://github.com/WriterGao/linkfox-ai-design/issues)

</div>

---

## 📋 项目简介

LinkFox AI设计平台是一个功能强大的AI驱动的图像生成和电商设计平台，提供智能修图、场景制变、商品图生成、AI穿衣、真人模特等多种AI设计功能。

## 📸 项目预览

![LinkFox AI设计平台](./docs/home-screenshot.png)

LinkFox AI设计平台提供智能修图、场景制变、商品图、AI穿衣、真人模特、批量生图等六大核心功能。

## ✨ 核心特性

- 🎨 **智能修图** - AI驱动的图像优化和美化
- 🏠 **场景制变** - 智能场景替换和背景生成
- 🛍️ **商品图生成** - 专业电商产品图制作
- 👔 **AI穿衣** - 虚拟试衣和服装搭配
- 👤 **真人模特** - AI生成的真实模特图
- 📦 **批量生图** - 批量处理和生成功能
- 🔐 **用户系统** - 完整的用户注册、登录、权限管理
- 💎 **积分系统** - 算力点数管理和VIP等级
- 📊 **作品管理** - 作品上传、分类、展示和分享

## 🏗️ 技术栈

### 后端技术

- **框架**: Spring Boot 3.2.0
- **数据库**: MySQL 8.0 + MyBatis Plus
- **缓存**: Redis 7.0
- **安全**: Spring Security + JWT
- **工具**: Lombok, Hutool

### 前端技术

- **框架**: Vue 3.4 + Vite 5.0
- **UI库**: Element Plus
- **状态管理**: Pinia
- **路由**: Vue Router
- **HTTP**: Axios
- **样式**: SCSS

### 基础设施

- **容器化**: Docker + Docker Compose
- **构建**: Maven + npm
- **版本控制**: Git

## 🚀 快速开始

### 环境要求

- Java 17+
- Node.js 18+
- Docker & Docker Compose
- Maven 3.8+

### Docker一键启动（推荐）

```bash
# 1. 克隆项目
git clone https://github.com/WriterGao/linkfox-ai-design.git
cd linkfox-ai-design

# 2. 启动所有服务
chmod +x start.sh
./start.sh
```

启动成功后：
- 前端地址: http://localhost:3001
- 后端地址: http://localhost:8080
- 默认账号: `admin` / `123456`

### 手动启动

#### 1. 启动数据库

```bash
docker-compose up -d mysql redis
```

#### 2. 启动后端

```bash
cd backend
mvn clean install
mvn spring-boot:run -Dspring-boot.run.profiles=docker
```

#### 3. 启动前端

```bash
cd frontend
npm install
npm run dev
```

## 📁 项目结构

```
linkfox-ai-design/
├── backend/                 # Spring Boot后端
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/linkfox/
│   │   │   │       ├── controller/    # 控制器
│   │   │   │       ├── service/       # 服务层
│   │   │   │       ├── mapper/        # 数据访问层
│   │   │   │       ├── entity/        # 实体类
│   │   │   │       ├── dto/           # 数据传输对象
│   │   │   │       ├── config/        # 配置类
│   │   │   │       └── utils/         # 工具类
│   │   │   └── resources/
│   │   │       ├── application.yml           # 配置文件
│   │   │       ├── application-docker.yml    # Docker配置
│   │   │       └── sql/schema.sql            # 数据库脚本
│   │   └── test/
│   └── pom.xml              # Maven依赖
├── frontend/                # Vue3前端
│   ├── src/
│   │   ├── api/             # API接口
│   │   ├── assets/          # 静态资源
│   │   ├── components/      # 组件
│   │   ├── router/          # 路由
│   │   ├── stores/          # 状态管理
│   │   └── views/           # 页面
│   ├── public/              # 公共资源
│   ├── package.json         # npm依赖
│   └── vite.config.js       # Vite配置
├── docker/                  # Docker配置
│   └── mysql/
├── docs/                    # 项目文档
├── docker-compose.yml       # Docker编排
├── start.sh                 # 一键启动脚本
├── stop.sh                  # 停止脚本
└── README.md                # 项目说明
```

## 📖 详细文档

- [快速开始指南](./QUICKSTART.md)
- [Docker快速部署](./DOCKER_QUICKSTART.md)
- [项目结构说明](./PROJECT_STRUCTURE.md)
- [API接口文档](./docs/API文档.md)
- [UI设计说明](./docs/UI设计说明.md)
- [开发规范](./docs/开发规范.md)
- [部署指南](./docs/部署指南.md)

## 🔌 主要API接口

### 用户相关

```
POST   /api/user/register     # 用户注册
POST   /api/user/login        # 用户登录
GET    /api/user/info         # 获取用户信息
PUT    /api/user/update       # 更新用户信息
```

### 作品相关

```
GET    /api/artwork/list      # 获取作品列表
GET    /api/artwork/{id}      # 获取作品详情
POST   /api/artwork/upload    # 上传作品
DELETE /api/artwork/{id}      # 删除作品
```

### 分类相关

```
GET    /api/category/list     # 获取分类列表
POST   /api/category/create   # 创建分类
```

## 🎯 功能演示

### 主页
- 图片上传和AI处理
- 6大核心功能展示
- 优秀案例展示（6列瀑布流）

### 用户中心
- 个人信息管理
- 积分和VIP等级
- 我的作品管理

### 作品广场
- 分类浏览
- 搜索和筛选
- 点赞和收藏

## 🛠️ 开发指南

### 添加新功能

1. **后端**: 在 `backend/src/main/java/com/linkfox/` 下创建对应的 Controller、Service、Mapper
2. **前端**: 在 `frontend/src/` 下创建对应的 API、组件和页面
3. **数据库**: 在 `backend/src/main/resources/sql/schema.sql` 中添加表结构

### 代码规范

- 后端遵循阿里巴巴Java开发规范
- 前端遵循Vue官方风格指南
- 使用统一的代码格式化工具

## 📝 测试账号

| 账号 | 密码 | 角色 | 积分 |
|------|------|------|------|
| admin | 123456 | 管理员 | 10000 |
| testuser | 123456 | 普通用户 | 100 |

## 🤝 贡献指南

欢迎提交 Pull Request 或 Issue！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 开源协议

本项目采用 [MIT](LICENSE) 协议开源。

## 👨‍💻 作者

**WriterGao**

- GitHub: [@WriterGao](https://github.com/WriterGao)

## 🙏 致谢

- 感谢 [Spring Boot](https://spring.io/projects/spring-boot)
- 感谢 [Vue.js](https://vuejs.org/)
- 感谢 [Element Plus](https://element-plus.org/)

## 📧 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 [Issue](https://github.com/WriterGao/linkfox-ai-design/issues)
- 发送邮件至项目维护者

---

<div align="center">

⭐ 如果这个项目对你有帮助，请给个 Star 支持一下！

Made with ❤️ by WriterGao

</div>
