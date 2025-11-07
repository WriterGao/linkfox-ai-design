import request from './request'

/**
 * 分类相关API
 */

// 获取所有分类
export const getAllCategories = () => {
  return request({
    url: '/category/list',
    method: 'get'
  })
}

// 获取分类详情
export const getCategoryDetail = (id) => {
  return request({
    url: `/category/${id}`,
    method: 'get'
  })
}

