package com.linkfox.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.linkfox.entity.Category;
import com.linkfox.mapper.CategoryMapper;
import com.linkfox.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 分类服务实现
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    
    @Autowired
    private CategoryMapper categoryMapper;
    
    @Override
    public List<Category> getAllCategories() {
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Category::getStatus, 1);
        wrapper.orderByAsc(Category::getSortOrder);
        return categoryMapper.selectList(wrapper);
    }
    
    @Override
    public Category getCategoryById(Long id) {
        return categoryMapper.selectById(id);
    }
}

