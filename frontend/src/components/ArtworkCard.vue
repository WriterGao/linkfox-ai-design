<template>
  <div class="artwork-card" @click="handleClick">
    <div class="artwork-image">
      <img 
        :src="artwork.thumbnailUrl || artwork.processedUrl" 
        :alt="artwork.title"
        @error="handleImageError"
        loading="lazy"
      />
      <div class="artwork-overlay">
        <div class="artwork-stats">
          <span><el-icon><View /></el-icon> {{ artwork.viewCount || 0 }}</span>
          <span><el-icon><Star /></el-icon> {{ artwork.likeCount || 0 }}</span>
        </div>
      </div>
    </div>
    <div v-if="showInfo" class="artwork-info">
      <div class="artwork-title">{{ artwork.title || '未命名作品' }}</div>
      <div class="artwork-meta">
        <span class="artwork-type">{{ getProcessTypeName(artwork.processType) }}</span>
        <span class="artwork-time">{{ formatTime(artwork.createTime) }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  artwork: {
    type: Object,
    required: true
  },
  showInfo: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits(['click'])

const handleClick = () => {
  emit('click', props.artwork)
}

const getProcessTypeName = (type) => {
  const typeMap = {
    'smart_edit': '智能修图',
    'scene_change': '场景制变',
    'product': '商品图',
    'ai_dress': 'AI穿衣',
    'model': '真人模特',
    'batch': '批量生成'
  }
  return typeMap[type] || '其他'
}

const formatTime = (time) => {
  if (!time) return ''
  const date = new Date(time)
  const now = new Date()
  const diff = now - date
  
  if (diff < 60000) return '刚刚'
  if (diff < 3600000) return `${Math.floor(diff / 60000)}分钟前`
  if (diff < 86400000) return `${Math.floor(diff / 3600000)}小时前`
  return date.toLocaleDateString()
}

const handleImageError = (e) => {
  // 图片加载失败时使用占位图
  e.target.src = 'https://via.placeholder.com/600x800/7B9FFF/ffffff?text=Artwork'
}
</script>

<style scoped lang="scss">
.artwork-card {
  background: #ffffff;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

    .artwork-image img {
      transform: scale(1.03);
    }

    .artwork-overlay {
      opacity: 1;
    }
  }

  .artwork-image {
    position: relative;
    width: 100%;
    aspect-ratio: 3/4;
    overflow: hidden;
    background: #f8f9fa;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .artwork-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(180deg, transparent 60%, rgba(0, 0, 0, 0.4) 100%);
      opacity: 0;
      transition: opacity 0.3s ease;
      display: flex;
      align-items: flex-end;
      padding: 12px;

      .artwork-stats {
        display: flex;
        gap: 12px;
        color: #fff;
        font-size: 12px;

        span {
          display: flex;
          align-items: center;
          gap: 4px;
        }
      }
    }
  }

  .artwork-info {
    padding: 10px 12px;

    .artwork-title {
      font-size: 13px;
      font-weight: 500;
      color: #333;
      margin-bottom: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .artwork-meta {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 11px;
      color: #999;

      .artwork-type {
        padding: 2px 6px;
        background: #f0f5ff;
        color: var(--primary-color);
        border-radius: 3px;
        font-size: 11px;
      }
    }
  }
}
</style>

