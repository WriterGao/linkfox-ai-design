<template>
  <nav class="navbar">
    <div class="container navbar-container">
      <!-- Logo -->
      <div class="navbar-brand">
        <router-link to="/" class="logo">
          <span class="logo-text">LinkFox</span>
          <span class="logo-badge">AI</span>
        </router-link>
      </div>

      <!-- 导航菜单 -->
      <div class="navbar-menu">
        <router-link to="/" class="nav-item" active-class="active">首页</router-link>
        <router-link to="/artworks" class="nav-item" active-class="active">模特图</router-link>
        <a class="nav-item">商品图</a>
        <a class="nav-item">POD素材</a>
        <a class="nav-item">商品图设计</a>
        <a class="nav-item">AI视频</a>
        <a class="nav-item">AI修图</a>
        <el-dropdown trigger="hover" class="nav-item">
          <span class="nav-item-dropdown">
            更多
            <el-icon class="el-icon--right"><arrow-down /></el-icon>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item>批量处理</el-dropdown-item>
              <el-dropdown-item>AI换脸</el-dropdown-item>
              <el-dropdown-item>背景生成</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
        <a class="nav-item">教程</a>
      </div>

      <!-- 右侧操作 -->
      <div class="navbar-actions">
        <template v-if="!userStore.isLoggedIn">
          <router-link to="/login" class="btn-text">登录</router-link>
          <router-link to="/register">
            <el-button type="primary" class="btn-register">注册</el-button>
          </router-link>
        </template>
        <template v-else>
          <div class="user-points">
            <el-icon><Coin /></el-icon>
            <span>{{ userStore.user?.points || 0 }} 算力</span>
          </div>
          <el-dropdown trigger="hover">
            <div class="user-avatar">
              <el-avatar :src="userStore.user?.avatar || '/default-avatar.png'">
                {{ userStore.user?.nickname?.charAt(0) || 'U' }}
              </el-avatar>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="router.push('/profile')">个人中心</el-dropdown-item>
                <el-dropdown-item @click="router.push('/my-artworks')">我的作品</el-dropdown-item>
                <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { useUserStore } from '@/stores/user'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const userStore = useUserStore()
const router = useRouter()

const handleLogout = () => {
  userStore.logout()
  ElMessage.success('退出成功')
  router.push('/')
}
</script>

<style scoped lang="scss">
.navbar {
  background: #ffffff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  position: sticky;
  top: 0;
  z-index: 1000;
  height: 64px;
}

.navbar-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
}

.navbar-brand {
  .logo {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    font-size: 24px;
    font-weight: 700;
    color: #333;

    .logo-text {
      background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .logo-badge {
      background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
      color: white;
      padding: 2px 8px;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 600;
    }
  }
}

.navbar-menu {
  display: flex;
  align-items: center;
  gap: 32px;
  flex: 1;
  margin-left: 60px;

  .nav-item {
    color: #666;
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    cursor: pointer;
    transition: color 0.3s ease;
    white-space: nowrap;

    &:hover {
      color: var(--primary-color);
    }

    &.active {
      color: var(--primary-color);
      font-weight: 600;
    }
  }

  .nav-item-dropdown {
    color: #666;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 4px;
    transition: color 0.3s ease;

    &:hover {
      color: var(--primary-color);
    }
  }
}

.navbar-actions {
  display: flex;
  align-items: center;
  gap: 20px;

  .btn-text {
    color: #666;
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: color 0.3s ease;

    &:hover {
      color: var(--primary-color);
    }
  }

  .btn-register {
    background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
    border: none;
    border-radius: 20px;
    padding: 0 20px;
    height: 36px;
    font-weight: 500;
    box-shadow: 0 2px 8px rgba(91, 127, 255, 0.25);

    &:hover {
      opacity: 0.95;
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(91, 127, 255, 0.35);
    }
  }

  .user-points {
    display: flex;
    align-items: center;
    gap: 6px;
    background: linear-gradient(135deg, #FFF7E6 0%, #FFE7BA 100%);
    padding: 6px 16px;
    border-radius: 20px;
    color: #FF7849;
    font-size: 14px;
    font-weight: 600;
  }

  .user-avatar {
    cursor: pointer;
    
    .el-avatar {
      width: 36px;
      height: 36px;
      background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
    }
  }
}

@media (max-width: 1200px) {
  .navbar-menu {
    gap: 20px;
    margin-left: 40px;
  }
}

@media (max-width: 768px) {
  .navbar-menu {
    display: none;
  }
}
</style>

