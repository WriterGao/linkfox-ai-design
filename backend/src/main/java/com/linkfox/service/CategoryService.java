package com.linkfox.service;

import com.linkfox.entity.Category;
import java.util.List;

/**
 * 分类服务接口
 */
public interface CategoryService {
    
    /**
     * 获取所有分类
     */
    List<Category> getAllCategories();
    
    /**
     * 根据ID获取分类
     */
    Category getCategoryById(Long id);
}

