import request from './request'

/**
 * 作品相关API
 */

// 上传作品
export const uploadArtwork = (formData) => {
  return request({
    url: '/artwork/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

// 查询作品列表
export const getArtworkList = (data) => {
  return request({
    url: '/artwork/list',
    method: 'post',
    data
  })
}

// 获取作品详情
export const getArtworkDetail = (id) => {
  return request({
    url: `/artwork/${id}`,
    method: 'get'
  })
}

// 删除作品
export const deleteArtwork = (id, userId) => {
  return request({
    url: `/artwork/${id}`,
    method: 'delete',
    params: { userId }
  })
}

