package com.linkfox.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.linkfox.entity.Category;
import org.apache.ibatis.annotations.Mapper;

/**
 * 分类Mapper
 */
@Mapper
public interface CategoryMapper extends BaseMapper<Category> {
}

