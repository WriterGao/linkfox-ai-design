<template>
  <div class="home-page">
    <Navbar />
    
    <!-- Banner区域 -->
    <div class="banner-section">
      <div class="banner-content">
        <div class="banner-promo">
          <el-icon><TrophyBase /></el-icon>
          <span>填写问卷，即刻领取 <strong>100 算力</strong></span>
          <el-button text type="primary">前往填写 →</el-button>
        </div>
      </div>
    </div>

    <div class="main-container">
      <!-- 左侧边栏 -->
      <aside class="left-sidebar">
        <div class="sidebar-item">
          <el-icon><Star /></el-icon>
          <span>为你推荐</span>
        </div>
        <div class="sidebar-item">
          <span>添加快捷访问</span>
        </div>
      </aside>

      <!-- 主内容区 -->
      <div class="content-wrapper">
        <!-- 上传区域 -->
        <div class="upload-section">
          <div class="upload-row">
            <UploadArea 
              upload-text="请上传图片，并描述您想完成的任务"
              @upload="handleUpload"
            />
            <el-button class="search-btn">功能搜索</el-button>
          </div>
        </div>

        <!-- 功能卡片区域 -->
        <div class="features-section">
          <div class="features-grid">
            <FeatureCard
              v-for="feature in features"
              :key="feature.id"
              :feature="feature"
              @click="handleFeatureClick"
            />
          </div>
        </div>

        <!-- 优秀案例区域 -->
        <div class="showcase-section">
          <div class="section-header">
            <h2>优秀案例</h2>
            <div class="category-tabs">
              <el-button
                v-for="tab in showcaseTabs"
                :key="tab.value"
                :type="activeTab === tab.value ? 'primary' : ''"
                text
                @click="activeTab = tab.value"
              >
                {{ tab.label }}
              </el-button>
            </div>
          </div>

          <!-- 作品网格 -->
          <div v-loading="loading" class="artworks-grid">
            <ArtworkCard
              v-for="artwork in artworks"
              :key="artwork.id"
              :artwork="artwork"
              @click="handleArtworkClick"
            />
          </div>

          <!-- 加载更多 -->
          <div class="load-more">
            <el-button v-if="hasMore" @click="loadMore" :loading="loading">
              加载更多
            </el-button>
          </div>
        </div>
      </div>
    </div>

    <!-- 右侧悬浮按钮组 -->
    <div class="float-buttons">
      <div class="float-btn" title="操作咨询">
        <el-icon><Headset /></el-icon>
        <span>操作咨询</span>
      </div>
      <div class="float-btn" title="产品教程">
        <el-icon><QuestionFilled /></el-icon>
        <span>产品教程</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import Navbar from '@/components/Navbar.vue'
import UploadArea from '@/components/UploadArea.vue'
import FeatureCard from '@/components/FeatureCard.vue'
import ArtworkCard from '@/components/ArtworkCard.vue'
import { getArtworkList } from '@/api/artwork'
import { uploadArtwork } from '@/api/artwork'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

// 功能卡片数据 - 参考LinkFox原网站风格
const features = ref([
  { 
    id: 1, 
    title: '智能修图', 
    image: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&h=400&fit=crop&q=80',
    type: 'smart_edit' 
  },
  { 
    id: 2, 
    title: '场景制变', 
    image: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=600&h=400&fit=crop&q=80',
    type: 'scene_change' 
  },
  { 
    id: 3, 
    title: '商品图', 
    image: 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=600&h=400&fit=crop&q=80',
    type: 'product' 
  },
  { 
    id: 4, 
    title: 'AI穿衣', 
    image: 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=600&h=400&fit=crop&q=80',
    type: 'ai_dress' 
  },
  { 
    id: 5, 
    title: '真人模特', 
    image: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600&h=400&fit=crop&q=80',
    type: 'model' 
  },
  { 
    id: 6, 
    title: '批量生图', 
    image: 'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?w=600&h=400&fit=crop&q=80',
    type: 'batch' 
  }
])

// 案例分类标签
const showcaseTabs = ref([
  { label: '全部', value: 'all' },
  { label: '商品图', value: 'product' },
  { label: '模特图', value: 'model' },
  { label: '穿衣图', value: 'ai_dress' },
  { label: '穿戴图', value: 'smart_edit' },
  { label: '视频', value: 'ai_video' },
  { label: 'AI修图', value: 'ai_retouch' }
])

const activeTab = ref('all')
const artworks = ref([])
const loading = ref(false)
const hasMore = ref(true)
const pageNum = ref(1)

// 模拟作品数据
const mockArtworks = [
  { id: 1, title: '时尚穿搭', thumbnailUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600&h=800&fit=crop&q=80', viewCount: 1250, likeCount: 89, processType: 'ai_dress' },
  { id: 2, title: '商业人像', thumbnailUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600&h=800&fit=crop&q=80', viewCount: 980, likeCount: 67, processType: 'model' },
  { id: 3, title: '创意装饰', thumbnailUrl: 'https://images.unsplash.com/photo-1513519245088-0e12902e35ca?w=600&h=800&fit=crop&q=80', viewCount: 756, likeCount: 54, processType: 'product' },
  { id: 4, title: '运动风尚', thumbnailUrl: 'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?w=600&h=800&fit=crop&q=80', viewCount: 2100, likeCount: 156, processType: 'ai_dress' },
  { id: 5, title: '高级定制', thumbnailUrl: 'https://images.unsplash.com/photo-1492106087820-71f1a00d2b11?w=600&h=800&fit=crop&q=80', viewCount: 1890, likeCount: 134, processType: 'model' },
  { id: 6, title: '夏日清新', thumbnailUrl: 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=600&h=800&fit=crop&q=80', viewCount: 1456, likeCount: 98, processType: 'ai_dress' },
  { id: 7, title: '咖啡时光', thumbnailUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=600&h=800&fit=crop&q=80', viewCount: 845, likeCount: 72, processType: 'product' },
  { id: 8, title: '都市风格', thumbnailUrl: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600&h=800&fit=crop&q=80', viewCount: 1567, likeCount: 112, processType: 'model' },
  { id: 9, title: '护肤美妆', thumbnailUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=600&h=800&fit=crop&q=80', viewCount: 2340, likeCount: 189, processType: 'product' },
  { id: 10, title: '耳机产品', thumbnailUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&h=800&fit=crop&q=80', viewCount: 1678, likeCount: 123, processType: 'product' },
  { id: 11, title: '智能手表', thumbnailUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&h=800&fit=crop&q=80', viewCount: 2890, likeCount: 234, processType: 'product' },
  { id: 12, title: '优雅装扮', thumbnailUrl: 'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=600&h=800&fit=crop&q=80', viewCount: 1234, likeCount: 87, processType: 'ai_dress' }
]

// 加载作品列表
const loadArtworks = async (loadMore = false) => {
  if (loading.value) return
  
  loading.value = true
  try {
    const params = {
      pageNum: loadMore ? pageNum.value : 1,
      pageSize: 20,
      isPublic: 1
    }
    
    if (activeTab.value !== 'all') {
      params.processType = activeTab.value
    }
    
    const res = await getArtworkList(params)
    
    if (loadMore) {
      artworks.value.push(...res.data.records)
    } else {
      artworks.value = res.data.records
    }
    
    hasMore.value = artworks.value.length < res.data.total
  } catch (error) {
    console.error('加载作品失败，使用模拟数据:', error)
    // 使用模拟数据
    artworks.value = mockArtworks
    hasMore.value = false
  } finally {
    loading.value = false
  }
}

// 加载更多
const loadMore = () => {
  pageNum.value++
  loadArtworks(true)
}

// 切换分类时重新加载
watch(activeTab, () => {
  pageNum.value = 1
  loadArtworks()
})

// 处理上传
const handleUpload = async (file) => {
  if (!userStore.isLoggedIn) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }

  const formData = new FormData()
  formData.append('file', file)
  formData.append('userId', userStore.user.id)
  formData.append('processType', 'smart_edit')

  try {
    await uploadArtwork(formData)
    ElMessage.success('上传成功')
    loadArtworks()
  } catch (error) {
    ElMessage.error('上传失败')
  }
}

// 功能卡片点击
const handleFeatureClick = (feature) => {
  ElMessage.info(`即将使用 ${feature.title} 功能`)
}

// 作品卡片点击
const handleArtworkClick = (artwork) => {
  console.log('查看作品:', artwork)
}

onMounted(() => {
  loadArtworks()
})
</script>

<style scoped lang="scss">
.home-page {
  min-height: 100vh;
  background: #f5f6f8;
}

.banner-section {
  background: linear-gradient(90deg, #FFF7E6 0%, #FFE7BA 50%, #FFF7E6 100%);
  padding: 10px 0;
  
  .banner-content {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
    
    .banner-promo {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      color: #FF7849;
      font-size: 14px;

      .el-icon {
        font-size: 18px;
      }

      strong {
        color: #FF5722;
        font-weight: 600;
      }
    }
  }
}

.main-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  gap: 0;
  padding-top: 20px;
}

.left-sidebar {
  width: 120px;
  flex-shrink: 0;
  margin-right: 0;

  .sidebar-item {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    color: #666;
    padding: 8px 0;
    cursor: pointer;
    
    .el-icon {
      font-size: 16px;
      color: #999;
    }

    &:hover {
      color: var(--primary-color);
      
      .el-icon {
        color: var(--primary-color);
      }
    }
  }
}

.content-wrapper {
  flex: 1;
  min-width: 0;
  padding-left: 20px;
}

.upload-section {
  padding: 0 0 20px;

  .upload-row {
    display: flex;
    align-items: center;
    gap: 16px;
  }

  .search-btn {
    padding: 0 28px;
    height: 40px;
    border-radius: 20px;
    border: 1px solid #e0e0e0;
    background: #fff;
    color: #666;
    font-size: 13px;
    flex-shrink: 0;

    &:hover {
      border-color: var(--primary-color);
      color: var(--primary-color);
    }
  }
}

.features-section {
  padding: 20px 0;

  .features-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 16px;
  }
}

.showcase-section {
  padding: 30px 0 60px;

  .section-header {
    margin-bottom: 20px;

    h2 {
      font-size: 20px;
      font-weight: 600;
      color: #333;
      margin-bottom: 16px;
    }

    .category-tabs {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }
  }

  .artworks-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 16px;
    min-height: 400px;
  }

  .load-more {
    text-align: center;
    margin-top: 32px;
  }
}

.float-buttons {
  position: fixed;
  right: 24px;
  bottom: 80px;
  z-index: 1000;
  display: flex;
  flex-direction: column;
  gap: 12px;

  .float-btn {
    width: 56px;
    height: 56px;
    background: #fff;
    border-radius: 50%;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;

    .el-icon {
      font-size: 22px;
      color: #5B7FFF;
      margin-bottom: 2px;
    }

    span {
      font-size: 10px;
      color: #666;
      text-align: center;
      line-height: 1;
    }

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 16px rgba(91, 127, 255, 0.25);
      
      .el-icon {
        color: #4A6FEE;
      }
    }
  }
}

@media (max-width: 1400px) {
  .features-section .features-grid {
    grid-template-columns: repeat(3, 1fr);
  }

  .showcase-section .artworks-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (max-width: 1200px) {
  .features-section .features-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .showcase-section .artworks-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .main-container {
    flex-direction: column;
    padding-top: 10px;
  }

  .left-sidebar {
    width: 100%;
    margin-bottom: 10px;
    display: flex;
    gap: 20px;
  }

  .content-wrapper {
    padding-left: 0;
  }

  .features-section .features-grid {
    grid-template-columns: repeat(1, 1fr);
    gap: 16px;
  }

  .showcase-section .artworks-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }

  .float-buttons {
    right: 16px;
    bottom: 60px;
    
    .float-btn {
      width: 48px;
      height: 48px;
      
      .el-icon {
        font-size: 18px;
      }
      
      span {
        font-size: 9px;
      }
    }
  }
}
</style>

