<template>
  <div class="feature-card" @click="handleClick">
    <div class="feature-image">
      <img 
        :src="feature.image" 
        :alt="feature.title"
        @error="handleImageError"
        loading="lazy"
      />
    </div>
    <div class="feature-title">{{ feature.title }}</div>
  </div>
</template>

<script setup>
const props = defineProps({
  feature: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['click'])

const handleClick = () => {
  emit('click', props.feature)
}

const handleImageError = (e) => {
  // 图片加载失败时使用占位图
  e.target.src = `https://via.placeholder.com/800x450/5B7FFF/ffffff?text=${props.feature.title}`
}
</script>

<style scoped lang="scss">
.feature-card {
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  position: relative;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
    
    .feature-image img {
      transform: scale(1.05);
    }
  }

  .feature-image {
    width: 100%;
    height: 160px;
    overflow: hidden;
    background: #f8f9fa;
    position: relative;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
    }
  }

  .feature-title {
    padding: 14px 12px;
    font-size: 14px;
    font-weight: 600;
    color: #333;
    text-align: center;
    background: #fff;
  }
}
</style>

