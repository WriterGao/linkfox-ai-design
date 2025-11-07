# LinkFox AI设计平台 - UI设计说明

本文档详细说明了项目UI设计参考LinkFox.com的要点。

## 📐 整体设计风格

### 设计理念
- **现代简约** - 采用扁平化设计，去除多余装饰
- **清新明快** - 使用清爽的色彩搭配
- **用户友好** - 注重用户体验和交互流畅度
- **视觉层次** - 通过卡片和阴影营造层次感

## 🎨 色彩系统

### 主色调 (Primary Color)
```scss
--primary-color: #5B7FFF;        // 主蓝色
--primary-hover: #4A6FEE;        // 悬停状态
--primary-gradient: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
```

**使用场景：**
- 主要按钮
- Logo
- 导航激活状态
- 重要信息强调

### 辅助色 (Secondary Color)
```scss
--secondary-color: #FF7849;      // 橙色
--secondary-gradient: linear-gradient(135deg, #FF7849 0%, #FF9869 100%);
```

**使用场景：**
- 算力/积分显示
- 促销Banner
- 次要按钮
- VIP标识

### 中性色 (Neutral Colors)
```scss
--text-primary: #333333;         // 主要文字
--text-secondary: #666666;       // 次要文字
--text-tertiary: #999999;        // 辅助文字
--border-color: #e5e7eb;         // 边框
--bg-primary: #ffffff;           // 主背景
--bg-secondary: #f8f9fa;         // 次背景
```

### 功能色 (Functional Colors)
```scss
--success-color: #52c41a;        // 成功
--warning-color: #faad14;        // 警告
--error-color: #ff4d4f;          // 错误
```

## 🔲 布局规范

### 容器宽度
```scss
.container {
  max-width: 1400px;             // 最大宽度
  margin: 0 auto;                // 居中
  padding: 0 24px;               // 左右内边距
}
```

### 栅格系统
- 主要使用CSS Grid布局
- 响应式断点：
  - 移动端：< 768px
  - 平板：768px - 1024px
  - 桌面端：> 1024px

### 间距系统
```scss
// 8px基础单位
--spacing-xs: 4px;
--spacing-sm: 8px;
--spacing-md: 16px;
--spacing-lg: 24px;
--spacing-xl: 32px;
--spacing-2xl: 48px;
```

## 📦 组件设计

### 1. 导航栏 (Navbar)
**高度：** 64px

**特点：**
- 固定在顶部 (sticky)
- 白色背景
- 柔和阴影：`box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06)`
- Logo左对齐，导航居中，用户信息右对齐

**交互：**
- 导航项悬停变色
- 当前页面高亮显示
- 用户头像下拉菜单

### 2. 卡片 (Card)
**圆角：** 16px (--radius-lg)

**特点：**
- 白色背景
- 阴影：`box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06)`
- Hover效果：向上移动4px，阴影加深

**代码示例：**
```scss
.card {
  background: #ffffff;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  }
}
```

### 3. 按钮 (Button)
**圆角：** 8px (--radius-sm)

**主按钮（Primary）：**
```scss
.btn-primary {
  background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 10px 24px;
  font-weight: 500;
  transition: all 0.3s ease;
  
  &:hover {
    opacity: 0.9;
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(91, 127, 255, 0.3);
  }
}
```

**次要按钮（Secondary）：**
```scss
.btn-secondary {
  background: linear-gradient(135deg, #FF7849 0%, #FF9869 100%);
  // 其他样式同主按钮
}
```

### 4. 图片卡片 (Image Card)
**特点：**
- 3:4宽高比
- 圆角16px
- 图片悬停放大效果
- 底部叠加信息层

**代码示例：**
```scss
.image-card {
  .image-wrapper {
    aspect-ratio: 3/4;
    overflow: hidden;
    border-radius: 16px;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
    }
    
    &:hover img {
      transform: scale(1.05);
    }
  }
  
  .overlay {
    position: absolute;
    bottom: 0;
    background: linear-gradient(180deg, transparent 0%, rgba(0, 0, 0, 0.5) 100%);
    color: #fff;
    padding: 16px;
  }
}
```

### 5. 上传区域 (Upload Area)
**特点：**
- 虚线边框
- 拖拽上传支持
- 悬停高亮效果

**代码示例：**
```scss
.upload-area {
  border: 2px dashed #d9d9d9;
  border-radius: 16px;
  background: #fafafa;
  padding: 60px 40px;
  text-align: center;
  transition: all 0.3s ease;
  
  &:hover {
    border-color: #5B7FFF;
    background: #f0f5ff;
  }
}
```

## ✨ 动画效果

### 页面进入动画
```scss
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in {
  animation: fadeIn 0.6s ease;
}
```

### 悬停效果
- **卡片：** 向上移动4px + 阴影加深
- **按钮：** 向上移动2px + 阴影扩散
- **图片：** 缩放1.05倍

### 过渡时间
```scss
transition: all 0.3s ease;  // 标准过渡
```

## 🖼️ 图标系统

使用 **Element Plus Icons**

**常用图标：**
- `<Plus />` - 添加/上传
- `<User />` - 用户
- `<Picture />` - 图片
- `<View />` - 浏览
- `<Star />` - 点赞/收藏
- `<Delete />` - 删除
- `<Edit />` - 编辑
- `<Search />` - 搜索

## 📱 响应式设计

### 移动端适配 (< 768px)
```scss
@media (max-width: 768px) {
  // 导航栏简化
  .navbar-menu {
    display: none;  // 隐藏导航菜单
  }
  
  // 网格布局改为2列
  .grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }
  
  // 卡片内边距减小
  .card {
    padding: 16px;
  }
  
  // 字体大小调整
  h1 {
    font-size: 24px;
  }
}
```

## 🎯 关键页面设计

### 首页 (Home)
1. **Banner区域** - 促销信息，渐变背景
2. **上传区域** - 居中大型上传框
3. **功能卡片** - 6个功能，网格布局
4. **案例展示** - 瀑布流/网格布局

### 登录/注册页
- 全屏渐变背景
- 居中白色卡片
- 表单简洁明了
- 大按钮设计

### 作品广场
- 顶部筛选栏
- 网格布局展示作品
- 底部分页器

## 🔍 设计细节

### 阴影层次
```scss
--shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.06);    // 轻微
--shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);   // 中等
--shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.12);   // 较深
```

### 圆角规范
```scss
--radius-sm: 8px;    // 小圆角（按钮）
--radius-md: 12px;   // 中圆角
--radius-lg: 16px;   // 大圆角（卡片）
```

### 字体规范
```scss
// 字体家族
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;

// 字体大小
--font-xs: 12px;
--font-sm: 13px;
--font-base: 14px;
--font-lg: 16px;
--font-xl: 18px;
--font-2xl: 24px;
--font-3xl: 32px;

// 字重
--font-normal: 400;
--font-medium: 500;
--font-semibold: 600;
--font-bold: 700;
```

## 🎁 特殊元素

### 悬浮客服按钮
- 位置：右下角固定
- 圆形按钮
- 蓝色渐变背景
- 阴影效果
- Hover放大

### 算力显示
- 橙色渐变背景
- 圆角标签
- 金币图标

### VIP标识
- 金色渐变
- 皇冠图标
- 特殊边框

## 📚 参考资源

- **LinkFox官网：** https://www.linkfox.com/home
- **Element Plus：** https://element-plus.org/
- **Vue 3：** https://cn.vuejs.org/
- **设计灵感：** Dribbble, Behance

---

遵循以上设计规范，可以确保UI风格与LinkFox保持一致，同时保持良好的用户体验。

