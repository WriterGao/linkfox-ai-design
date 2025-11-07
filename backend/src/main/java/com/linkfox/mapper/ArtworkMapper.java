package com.linkfox.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.linkfox.entity.Artwork;
import org.apache.ibatis.annotations.Mapper;

/**
 * 作品Mapper
 */
@Mapper
public interface ArtworkMapper extends BaseMapper<Artwork> {
}

