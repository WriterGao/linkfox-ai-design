<template>
  <div class="my-artworks-page">
    <Navbar />
    
    <div class="my-artworks-container">
      <div class="container">
        <div class="page-header">
          <h1>我的作品</h1>
          <el-button type="primary" @click="router.push('/')">
            <el-icon><Plus /></el-icon> 创建新作品
          </el-button>
        </div>

        <div v-loading="loading" class="artworks-grid">
          <ArtworkCard
            v-for="artwork in artworks"
            :key="artwork.id"
            :artwork="artwork"
            @click="handleArtworkClick"
          />
        </div>

        <el-empty
          v-if="!loading && artworks.length === 0"
          description="还没有作品，快去创作吧"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import Navbar from '@/components/Navbar.vue'
import ArtworkCard from '@/components/ArtworkCard.vue'
import { getArtworkList } from '@/api/artwork'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()
const loading = ref(false)
const artworks = ref([])

const loadMyArtworks = async () => {
  loading.value = true
  try {
    const res = await getArtworkList({
      pageNum: 1,
      pageSize: 100,
      userId: userStore.user.id
    })
    artworks.value = res.data.records
  } catch (error) {
    console.error('加载作品失败:', error)
  } finally {
    loading.value = false
  }
}

const handleArtworkClick = (artwork) => {
  console.log('查看作品:', artwork)
}

onMounted(() => {
  loadMyArtworks()
})
</script>

<style scoped lang="scss">
.my-artworks-page {
  min-height: 100vh;
  background: #f8f9fa;
}

.my-artworks-container {
  padding: 40px 0 80px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;

  h1 {
    font-size: 28px;
    font-weight: 600;
    color: #333;
  }
}

.artworks-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 24px;
  min-height: 400px;
}

@media (max-width: 768px) {
  .artworks-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }
}
</style>

