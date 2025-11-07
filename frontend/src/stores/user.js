import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useUserStore = defineStore('user', () => {
  // 状态
  const user = ref(null)
  const token = ref(localStorage.getItem('token') || '')
  
  // 计算属性
  const isLoggedIn = computed(() => !!token.value)
  
  // 方法
  const setUser = (userData) => {
    user.value = userData
  }
  
  const setToken = (newToken) => {
    token.value = newToken
    localStorage.setItem('token', newToken)
  }
  
  const logout = () => {
    user.value = null
    token.value = ''
    localStorage.removeItem('token')
  }
  
  return {
    user,
    token,
    isLoggedIn,
    setUser,
    setToken,
    logout
  }
})

