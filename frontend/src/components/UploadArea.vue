<template>
  <div class="upload-area">
    <div class="upload-container">
      <!-- 左侧上传框 -->
      <el-upload
        ref="uploadRef"
        class="upload-box"
        :auto-upload="false"
        :show-file-list="false"
        :on-change="handleFileChange"
        drag
        accept="image/*"
      >
        <div class="upload-icon-wrapper">
          <el-icon class="upload-icon"><Plus /></el-icon>
        </div>
      </el-upload>

      <!-- 右侧文字和描述 -->
      <div class="upload-info">
        <div class="upload-text">{{ uploadText }}</div>
      </div>
    </div>

    <!-- 预览区域 -->
    <div v-if="previewUrl" class="preview-area">
      <img :src="previewUrl" alt="预览图" class="preview-image" />
      <div class="preview-actions">
        <el-button type="danger" size="small" @click="clearPreview">
          <el-icon><Delete /></el-icon> 删除
        </el-button>
        <el-button type="primary" size="small" @click="handleUpload" :loading="uploading">
          <el-icon><Upload /></el-icon> 开始处理
        </el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

const props = defineProps({
  uploadText: {
    type: String,
    default: '请上传图片，并描述您想完成的任务'
  }
})

const emit = defineEmits(['upload'])

const uploadRef = ref()
const previewUrl = ref('')
const currentFile = ref(null)
const uploading = ref(false)

const handleFileChange = (file) => {
  // 验证文件类型
  const isImage = file.raw.type.startsWith('image/')
  if (!isImage) {
    ElMessage.error('请上传图片文件')
    return
  }

  // 验证文件大小
  const isLt10M = file.raw.size / 1024 / 1024 < 10
  if (!isLt10M) {
    ElMessage.error('图片大小不能超过 10MB')
    return
  }

  currentFile.value = file.raw
  previewUrl.value = URL.createObjectURL(file.raw)
}

const clearPreview = () => {
  if (previewUrl.value) {
    URL.revokeObjectURL(previewUrl.value)
  }
  previewUrl.value = ''
  currentFile.value = null
}

const handleUpload = async () => {
  if (!currentFile.value) {
    ElMessage.warning('请先选择文件')
    return
  }

  uploading.value = true
  try {
    await emit('upload', currentFile.value)
    clearPreview()
  } finally {
    uploading.value = false
  }
}

defineExpose({
  clearPreview
})
</script>

<style scoped lang="scss">
.upload-area {
  width: 100%;
}

.upload-container {
  display: flex;
  align-items: center;
  gap: 20px;
  background: #f5f5f5;
  border-radius: 8px;
  padding: 20px;
}

.upload-box {
  flex-shrink: 0;

  :deep(.el-upload) {
    width: 100px;
    height: 100px;
    border: 2px dashed #d9d9d9;
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;

    &:hover {
      border-color: #5B7FFF;
      background: #f8f9ff;
    }
  }

  :deep(.el-upload-dragger) {
    border: none;
    background: transparent;
    padding: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.upload-icon-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;

  .upload-icon {
    font-size: 36px;
    color: #bbb;
  }
}

.upload-info {
  flex: 1;
  
  .upload-text {
    font-size: 14px;
    color: #666;
    font-weight: 400;
    line-height: 1.6;
  }
}

.preview-area {
  margin-top: 24px;
  text-align: center;

  .preview-image {
    max-width: 100%;
    max-height: 400px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 16px;
  }

  .preview-actions {
    display: flex;
    justify-content: center;
    gap: 12px;
  }
}
</style>

