<template>
  <div class="artworks-page">
    <Navbar />
    
    <div class="artworks-container">
      <div class="container">
        <!-- 页面标题 -->
        <div class="page-header">
          <h1>作品广场</h1>
          <p>探索更多优秀AI设计作品</p>
        </div>

        <!-- 筛选区域 -->
        <div class="filter-bar">
          <div class="filter-item">
            <span class="filter-label">分类：</span>
            <el-radio-group v-model="filters.processType" @change="handleFilterChange">
              <el-radio-button label="">全部</el-radio-button>
              <el-radio-button label="smart_edit">智能修图</el-radio-button>
              <el-radio-button label="scene_change">场景制变</el-radio-button>
              <el-radio-button label="product">商品图</el-radio-button>
              <el-radio-button label="ai_dress">AI穿衣</el-radio-button>
              <el-radio-button label="model">真人模特</el-radio-button>
            </el-radio-group>
          </div>

          <div class="filter-item">
            <span class="filter-label">排序：</span>
            <el-select v-model="filters.sortField" @change="handleFilterChange">
              <el-option label="最新发布" value="create_time" />
              <el-option label="最多浏览" value="view_count" />
              <el-option label="最多点赞" value="like_count" />
            </el-select>
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

        <!-- 空状态 -->
        <el-empty
          v-if="!loading && artworks.length === 0"
          description="暂无作品"
        />

        <!-- 分页 -->
        <div v-if="total > 0" class="pagination">
          <el-pagination
            v-model:current-page="filters.pageNum"
            v-model:page-size="filters.pageSize"
            :total="total"
            :page-sizes="[20, 40, 60, 100]"
            layout="total, sizes, prev, pager, next, jumper"
            @current-change="loadArtworks"
            @size-change="loadArtworks"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import Navbar from '@/components/Navbar.vue'
import ArtworkCard from '@/components/ArtworkCard.vue'
import { getArtworkList } from '@/api/artwork'

const loading = ref(false)
const artworks = ref([])
const total = ref(0)

const filters = reactive({
  pageNum: 1,
  pageSize: 20,
  processType: '',
  sortField: 'create_time',
  isPublic: 1
})

const loadArtworks = async () => {
  loading.value = true
  try {
    const res = await getArtworkList(filters)
    artworks.value = res.data.records
    total.value = res.data.total
  } catch (error) {
    console.error('加载作品失败:', error)
  } finally {
    loading.value = false
  }
}

const handleFilterChange = () => {
  filters.pageNum = 1
  loadArtworks()
}

const handleArtworkClick = (artwork) => {
  console.log('查看作品:', artwork)
}

onMounted(() => {
  loadArtworks()
})
</script>

<style scoped lang="scss">
.artworks-page {
  min-height: 100vh;
  background: #f8f9fa;
}

.artworks-container {
  padding: 40px 0 80px;
}

.page-header {
  text-align: center;
  margin-bottom: 40px;

  h1 {
    font-size: 36px;
    font-weight: 600;
    color: #333;
    margin-bottom: 12px;
  }

  p {
    font-size: 16px;
    color: #666;
  }
}

.filter-bar {
  background: #fff;
  border-radius: var(--radius-lg);
  padding: 24px;
  margin-bottom: 32px;
  box-shadow: var(--shadow-sm);

  .filter-item {
    display: flex;
    align-items: center;
    margin-bottom: 16px;

    &:last-child {
      margin-bottom: 0;
    }

    .filter-label {
      font-size: 14px;
      color: #666;
      margin-right: 16px;
      white-space: nowrap;
    }
  }
}

.artworks-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 24px;
  min-height: 400px;
}

.pagination {
  display: flex;
  justify-content: center;
  margin-top: 48px;
}

@media (max-width: 768px) {
  .page-header h1 {
    font-size: 28px;
  }

  .filter-bar .filter-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .artworks-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }
}
</style>

