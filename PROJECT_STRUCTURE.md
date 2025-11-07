# 项目结构说明

```
linkfox-ai-design/
│
├── 📁 backend/                          # 后端项目（Spring Boot）
│   ├── 📁 src/
│   │   ├── 📁 main/
│   │   │   ├── 📁 java/com/linkfox/
│   │   │   │   ├── 📁 common/           # 通用类
│   │   │   │   │   ├── Result.java           # 统一返回结果
│   │   │   │   │   └── PageResult.java       # 分页返回结果
│   │   │   │   │
│   │   │   │   ├── 📁 config/           # 配置类
│   │   │   │   │   ├── CorsConfig.java       # 跨域配置
│   │   │   │   │   ├── SecurityConfig.java   # Security配置
│   │   │   │   │   └── MyBatisPlusConfig.java # MyBatis Plus配置
│   │   │   │   │
│   │   │   │   ├── 📁 controller/       # 控制器层
│   │   │   │   │   ├── UserController.java     # 用户接口
│   │   │   │   │   ├── ArtworkController.java  # 作品接口
│   │   │   │   │   └── CategoryController.java # 分类接口
│   │   │   │   │
│   │   │   │   ├── 📁 service/          # 服务层（接口）
│   │   │   │   │   ├── UserService.java
│   │   │   │   │   ├── ArtworkService.java
│   │   │   │   │   ├── CategoryService.java
│   │   │   │   │   └── 📁 impl/              # 服务层实现
│   │   │   │   │       ├── UserServiceImpl.java
│   │   │   │   │       ├── ArtworkServiceImpl.java
│   │   │   │   │       └── CategoryServiceImpl.java
│   │   │   │   │
│   │   │   │   ├── 📁 mapper/           # 数据访问层
│   │   │   │   │   ├── UserMapper.java
│   │   │   │   │   ├── ArtworkMapper.java
│   │   │   │   │   └── CategoryMapper.java
│   │   │   │   │
│   │   │   │   ├── 📁 entity/           # 实体类
│   │   │   │   │   ├── User.java
│   │   │   │   │   ├── Artwork.java
│   │   │   │   │   └── Category.java
│   │   │   │   │
│   │   │   │   ├── 📁 dto/              # 数据传输对象
│   │   │   │   │   ├── UserLoginDTO.java
│   │   │   │   │   ├── UserRegisterDTO.java
│   │   │   │   │   └── ArtworkQueryDTO.java
│   │   │   │   │
│   │   │   │   ├── 📁 utils/            # 工具类
│   │   │   │   │   └── JwtUtil.java          # JWT工具
│   │   │   │   │
│   │   │   │   └── LinkFoxApplication.java   # 启动类
│   │   │   │
│   │   │   └── 📁 resources/
│   │   │       ├── application.yml           # 应用配置
│   │   │       └── 📁 sql/
│   │   │           └── schema.sql            # 数据库脚本
│   │   │
│   │   └── 📁 test/                     # 测试代码
│   │
│   ├── pom.xml                          # Maven配置
│   └── .env.example                     # 环境变量示例
│
├── 📁 frontend/                         # 前端项目（Vue 3）
│   ├── 📁 src/
│   │   ├── 📁 api/                     # API接口封装
│   │   │   ├── request.js                  # Axios封装
│   │   │   ├── user.js                     # 用户接口
│   │   │   ├── artwork.js                  # 作品接口
│   │   │   └── category.js                 # 分类接口
│   │   │
│   │   ├── 📁 assets/                  # 静态资源
│   │   │   └── 📁 styles/
│   │   │       └── main.scss               # 全局样式
│   │   │
│   │   ├── 📁 components/              # 组件
│   │   │   ├── Navbar.vue                  # 导航栏
│   │   │   ├── UploadArea.vue              # 上传区域
│   │   │   ├── FeatureCard.vue             # 功能卡片
│   │   │   └── ArtworkCard.vue             # 作品卡片
│   │   │
│   │   ├── 📁 views/                   # 页面
│   │   │   ├── Home.vue                    # 首页
│   │   │   ├── Login.vue                   # 登录页
│   │   │   ├── Register.vue                # 注册页
│   │   │   ├── Artworks.vue                # 作品广场
│   │   │   ├── MyArtworks.vue              # 我的作品
│   │   │   └── Profile.vue                 # 个人中心
│   │   │
│   │   ├── 📁 router/                  # 路由
│   │   │   └── index.js                    # 路由配置
│   │   │
│   │   ├── 📁 stores/                  # 状态管理
│   │   │   └── user.js                     # 用户状态
│   │   │
│   │   ├── App.vue                     # 根组件
│   │   └── main.js                     # 入口文件
│   │
│   ├── index.html                      # HTML模板
│   ├── package.json                    # 依赖配置
│   ├── vite.config.js                  # Vite配置
│   ├── .env.development                # 开发环境变量
│   └── .env.production                 # 生产环境变量
│
├── 📁 docs/                            # 文档目录
│   ├── API文档.md                       # API接口文档
│   ├── 部署指南.md                      # 部署说明
│   ├── UI设计说明.md                    # UI设计规范
│   └── 开发规范.md                      # 代码规范
│
├── README.md                           # 项目说明
├── QUICKSTART.md                       # 快速启动指南
├── PROJECT_STRUCTURE.md                # 本文件
└── .gitignore                          # Git忽略文件

```

## 📊 技术栈对应关系

### 后端技术
| 目录/文件 | 技术栈 | 说明 |
|----------|--------|------|
| controller/ | Spring MVC | RESTful接口 |
| service/ | Spring | 业务逻辑层 |
| mapper/ | MyBatis Plus | 数据访问层 |
| entity/ | JPA | 实体映射 |
| config/ | Spring Boot | 配置类 |
| utils/ | Java | 工具类 |

### 前端技术
| 目录/文件 | 技术栈 | 说明 |
|----------|--------|------|
| views/ | Vue 3 | 页面组件 |
| components/ | Vue 3 | 可复用组件 |
| router/ | Vue Router | 路由管理 |
| stores/ | Pinia | 状态管理 |
| api/ | Axios | HTTP请求 |
| assets/ | SCSS | 样式文件 |

## 🔍 关键文件说明

### 后端关键文件

#### 1. `LinkFoxApplication.java` - 启动类
```java
@SpringBootApplication
@MapperScan("com.linkfox.mapper")
public class LinkFoxApplication {
    public static void main(String[] args) {
        SpringApplication.run(LinkFoxApplication.class, args);
    }
}
```

#### 2. `Result.java` - 统一返回格式
所有接口都使用此类包装返回结果，统一格式。

#### 3. `application.yml` - 配置文件
包含数据库、Redis、JWT等所有配置。

#### 4. `schema.sql` - 数据库脚本
包含所有表结构和初始数据。

### 前端关键文件

#### 1. `main.js` - 入口文件
```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'

const app = createApp(App)
app.use(createPinia())
app.use(router)
app.use(ElementPlus)
app.mount('#app')
```

#### 2. `router/index.js` - 路由配置
定义所有页面路由和权限控制。

#### 3. `stores/user.js` - 用户状态
管理登录状态和用户信息。

#### 4. `api/request.js` - HTTP封装
Axios实例配置，包含拦截器。

## 📝 开发流程

### 添加新功能的典型流程

#### 后端
1. 在 `entity/` 创建实体类
2. 在 `mapper/` 创建Mapper接口
3. 在 `dto/` 创建DTO类（如需要）
4. 在 `service/` 创建Service接口和实现
5. 在 `controller/` 创建Controller

#### 前端
1. 在 `api/` 添加接口方法
2. 在 `components/` 创建组件（如需要）
3. 在 `views/` 创建页面
4. 在 `router/` 添加路由
5. 在 `stores/` 添加状态（如需要）

## 🗂️ 数据库表结构

| 表名 | 说明 | 主要字段 |
|-----|------|---------|
| user | 用户表 | id, username, password, points, vip_level |
| category | 分类表 | id, name, code, sort_order |
| artwork | 作品表 | id, user_id, category_id, original_url, processed_url |
| tag | 标签表 | id, name, use_count |
| artwork_tag | 作品标签关联 | id, artwork_id, tag_id |
| order | 订单表 | id, user_id, amount, status |
| points_record | 积分记录表 | id, user_id, points, type |

## 🎯 核心功能模块

### 1. 用户模块
- 注册/登录
- 个人信息管理
- 积分系统
- VIP会员

### 2. 作品模块
- 图片上传
- AI处理
- 作品展示
- 作品管理

### 3. 分类模块
- 分类管理
- 功能分类展示

## 📦 依赖说明

### 后端主要依赖
- `spring-boot-starter-web` - Web框架
- `mybatis-plus-boot-starter` - ORM框架
- `mysql-connector-java` - MySQL驱动
- `spring-boot-starter-security` - 安全框架
- `jjwt` - JWT token
- `hutool-all` - 工具类

### 前端主要依赖
- `vue` - 前端框架
- `vue-router` - 路由
- `pinia` - 状态管理
- `axios` - HTTP客户端
- `element-plus` - UI组件库
- `sass` - CSS预处理器

## 🔐 安全机制

1. **JWT认证** - Token based认证
2. **密码加密** - BCrypt加密
3. **CORS配置** - 跨域安全控制
4. **SQL注入防护** - MyBatis Plus参数化查询
5. **XSS防护** - 前端输入验证和转义

## 🚀 性能优化

1. **数据库索引** - 关键字段建立索引
2. **分页查询** - 大数据量分页加载
3. **图片压缩** - 上传图片自动压缩
4. **静态资源缓存** - Nginx缓存配置
5. **代码分割** - Vue路由懒加载

---

这个文档帮助您快速理解项目结构和开发流程。

