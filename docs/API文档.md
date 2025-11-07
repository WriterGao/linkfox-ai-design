# LinkFox AI设计平台 - API文档

## 基础说明

### 请求地址
- 开发环境：`http://localhost:8080/api`
- 生产环境：`https://api.linkfox.com/api`

### 请求头
```
Content-Type: application/json
Authorization: Bearer {token}  // 需要登录的接口
```

### 统一返回格式
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {}
}
```

## 用户相关接口

### 1. 用户注册
**接口地址：** `POST /user/register`

**请求参数：**
```json
{
  "username": "testuser",
  "password": "123456",
  "email": "test@example.com",
  "nickname": "测试用户"
}
```

**返回示例：**
```json
{
  "code": 200,
  "message": "注册成功",
  "data": {
    "id": 1,
    "username": "testuser",
    "email": "test@example.com",
    "nickname": "测试用户",
    "points": 100,
    "vipLevel": 0
  }
}
```

### 2. 用户登录
**接口地址：** `POST /user/login`

**请求参数：**
```json
{
  "username": "testuser",
  "password": "123456"
}
```

**返回示例：**
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "user": {
      "id": 1,
      "username": "testuser",
      "nickname": "测试用户",
      "points": 100
    },
    "token": "eyJhbGciOiJIUzUxMiJ9..."
  }
}
```

### 3. 获取用户信息
**接口地址：** `GET /user/{id}`

**返回示例：**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "testuser",
    "nickname": "测试用户",
    "points": 100,
    "vipLevel": 0
  }
}
```

## 作品相关接口

### 1. 上传作品
**接口地址：** `POST /artwork/upload`

**请求方式：** `multipart/form-data`

**请求参数：**
- `file`: 图片文件
- `userId`: 用户ID
- `processType`: 处理类型（smart_edit/scene_change/product/ai_dress/model/batch）

**返回示例：**
```json
{
  "code": 200,
  "message": "上传成功",
  "data": {
    "id": 1,
    "userId": 1,
    "originalUrl": "http://localhost:8080/api/files/xxx.jpg",
    "processedUrl": "http://localhost:8080/api/files/xxx.jpg",
    "processType": "smart_edit",
    "status": 1
  }
}
```

### 2. 查询作品列表
**接口地址：** `POST /artwork/list`

**请求参数：**
```json
{
  "pageNum": 1,
  "pageSize": 20,
  "categoryId": null,
  "processType": "smart_edit",
  "isPublic": 1,
  "sortField": "create_time",
  "sortOrder": "desc"
}
```

**返回示例：**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "total": 100,
    "pageNum": 1,
    "pageSize": 20,
    "records": [
      {
        "id": 1,
        "userId": 1,
        "title": "作品标题",
        "processedUrl": "http://localhost:8080/api/files/xxx.jpg",
        "processType": "smart_edit",
        "viewCount": 100,
        "likeCount": 50,
        "createTime": "2024-01-01T12:00:00"
      }
    ]
  }
}
```

### 3. 获取作品详情
**接口地址：** `GET /artwork/{id}`

**返回示例：**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "userId": 1,
    "title": "作品标题",
    "description": "作品描述",
    "originalUrl": "http://localhost:8080/api/files/xxx.jpg",
    "processedUrl": "http://localhost:8080/api/files/xxx_processed.jpg",
    "processType": "smart_edit",
    "viewCount": 100,
    "likeCount": 50,
    "createTime": "2024-01-01T12:00:00"
  }
}
```

### 4. 删除作品
**接口地址：** `DELETE /artwork/{id}`

**请求参数：**
- `userId`: 用户ID（Query参数）

**返回示例：**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": true
}
```

## 分类相关接口

### 1. 获取所有分类
**接口地址：** `GET /category/list`

**返回示例：**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "name": "智能修图",
      "code": "smart_edit",
      "icon": "http://localhost:8080/api/files/icon.png",
      "sortOrder": 1
    }
  ]
}
```

## 错误码说明

| 错误码 | 说明 |
|-------|------|
| 200 | 操作成功 |
| 400 | 请求参数错误 |
| 401 | 未授权，请登录 |
| 403 | 禁止访问 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

