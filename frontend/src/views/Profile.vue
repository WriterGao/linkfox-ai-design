<template>
  <div class="profile-page">
    <Navbar />
    
    <div class="profile-container">
      <div class="container">
        <div class="profile-card">
          <div class="profile-header">
            <el-avatar :size="100" :src="userStore.user?.avatar">
              {{ userStore.user?.nickname?.charAt(0) || 'U' }}
            </el-avatar>
            <div class="profile-info">
              <h2>{{ userStore.user?.nickname }}</h2>
              <p>@{{ userStore.user?.username }}</p>
            </div>
          </div>

          <div class="profile-stats">
            <div class="stat-item">
              <div class="stat-value">{{ userStore.user?.points || 0 }}</div>
              <div class="stat-label">算力余额</div>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <div class="stat-value">
                {{ userStore.user?.vipLevel === 1 ? 'VIP会员' : '普通用户' }}
              </div>
              <div class="stat-label">会员等级</div>
            </div>
          </div>

          <div class="profile-actions">
            <el-button type="primary" size="large">
              <el-icon><CreditCard /></el-icon> 充值算力
            </el-button>
            <el-button size="large">
              <el-icon><Crown /></el-icon> 升级VIP
            </el-button>
          </div>

          <div class="profile-detail">
            <el-descriptions :column="1" border>
              <el-descriptions-item label="邮箱">
                {{ userStore.user?.email || '未设置' }}
              </el-descriptions-item>
              <el-descriptions-item label="手机">
                {{ userStore.user?.phone || '未绑定' }}
              </el-descriptions-item>
              <el-descriptions-item label="注册时间">
                {{ formatDate(userStore.user?.createTime) }}
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import Navbar from '@/components/Navbar.vue'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('zh-CN')
}
</script>

<style scoped lang="scss">
.profile-page {
  min-height: 100vh;
  background: #f8f9fa;
}

.profile-container {
  padding: 40px 0 80px;
}

.profile-card {
  max-width: 800px;
  margin: 0 auto;
  background: #fff;
  border-radius: var(--radius-lg);
  padding: 48px;
  box-shadow: var(--shadow-sm);
}

.profile-header {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 32px;

  .el-avatar {
    background: linear-gradient(135deg, #5B7FFF 0%, #7B9FFF 100%);
  }

  .profile-info {
    h2 {
      font-size: 24px;
      font-weight: 600;
      color: #333;
      margin-bottom: 8px;
    }

    p {
      font-size: 14px;
      color: #999;
    }
  }
}

.profile-stats {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 48px;
  padding: 32px 0;
  margin-bottom: 32px;

  .stat-item {
    text-align: center;

    .stat-value {
      font-size: 32px;
      font-weight: 600;
      color: #333;
      margin-bottom: 8px;
    }

    .stat-label {
      font-size: 14px;
      color: #999;
    }
  }

  .stat-divider {
    width: 1px;
    height: 48px;
    background: #e5e7eb;
  }
}

.profile-actions {
  display: flex;
  gap: 16px;
  margin-bottom: 32px;

  .el-button {
    flex: 1;
    height: 48px;
  }
}

.profile-detail {
  margin-top: 32px;
}
</style>

