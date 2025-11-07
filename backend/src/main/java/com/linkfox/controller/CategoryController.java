package com.linkfox.controller;

import com.linkfox.common.Result;
import com.linkfox.entity.Category;
import com.linkfox.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 分类Controller
 */
@RestController
@RequestMapping("/category")
public class CategoryController {
    
    @Autowired
    private CategoryService categoryService;
    
    /**
     * 获取所有分类
     */
    @GetMapping("/list")
    public Result<List<Category>> getAllCategories() {
        List<Category> categories = categoryService.getAllCategories();
        return Result.success(categories);
    }
    
    /**
     * 根据ID获取分类
     */
    @GetMapping("/{id}")
    public Result<Category> getCategoryById(@PathVariable Long id) {
        Category category = categoryService.getCategoryById(id);
        if (category != null) {
            return Result.success(category);
        }
        return Result.error("分类不存在");
    }
}

