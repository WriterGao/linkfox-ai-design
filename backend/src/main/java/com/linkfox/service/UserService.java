package com.linkfox.service;

import com.linkfox.dto.UserLoginDTO;
import com.linkfox.dto.UserRegisterDTO;
import com.linkfox.entity.User;
import java.util.Map;

/**
 * 用户服务接口
 */
public interface UserService {
    
    /**
     * 用户注册
     */
    User register(UserRegisterDTO dto);
    
    /**
     * 用户登录
     */
    Map<String, Object> login(UserLoginDTO dto);
    
    /**
     * 根据ID获取用户
     */
    User getUserById(Long id);
    
    /**
     * 根据用户名获取用户
     */
    User getUserByUsername(String username);
    
    /**
     * 更新用户信息
     */
    boolean updateUser(User user);
}

