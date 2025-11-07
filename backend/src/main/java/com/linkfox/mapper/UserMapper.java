package com.linkfox.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.linkfox.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户Mapper
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
}

