package com.linkfox.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.linkfox.dto.UserLoginDTO;
import com.linkfox.dto.UserRegisterDTO;
import com.linkfox.entity.User;
import com.linkfox.mapper.UserMapper;
import com.linkfox.service.UserService;
import com.linkfox.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 用户服务实现
 */
@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Override
    @Transactional
    public User register(UserRegisterDTO dto) {
        // 检查用户名是否存在
        User existUser = getUserByUsername(dto.getUsername());
        if (existUser != null) {
            throw new RuntimeException("用户名已存在");
        }
        
        // 检查邮箱是否存在
        if (StrUtil.isNotBlank(dto.getEmail())) {
            LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(User::getEmail, dto.getEmail());
            if (userMapper.selectCount(wrapper) > 0) {
                throw new RuntimeException("邮箱已被注册");
            }
        }
        
        // 创建新用户
        User user = new User();
        user.setUsername(dto.getUsername());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setEmail(dto.getEmail());
        user.setNickname(StrUtil.isNotBlank(dto.getNickname()) ? dto.getNickname() : dto.getUsername());
        user.setPoints(100); // 注册赠送100算力
        user.setVipLevel(0);
        user.setStatus(1);
        
        userMapper.insert(user);
        return user;
    }
    
    @Override
    public Map<String, Object> login(UserLoginDTO dto) {
        // 查询用户
        User user = getUserByUsername(dto.getUsername());
        if (user == null) {
            throw new RuntimeException("用户名或密码错误");
        }
        
        // 验证密码
        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new RuntimeException("用户名或密码错误");
        }
        
        // 检查账号状态
        if (user.getStatus() == 0) {
            throw new RuntimeException("账号已被禁用");
        }
        
        // 生成token
        String token = jwtUtil.generateToken(user.getId(), user.getUsername());
        
        // 返回用户信息和token
        Map<String, Object> result = new HashMap<>();
        user.setPassword(null); // 不返回密码
        result.put("user", user);
        result.put("token", token);
        
        return result;
    }
    
    @Override
    public User getUserById(Long id) {
        return userMapper.selectById(id);
    }
    
    @Override
    public User getUserByUsername(String username) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, username);
        return userMapper.selectOne(wrapper);
    }
    
    @Override
    public boolean updateUser(User user) {
        return userMapper.updateById(user) > 0;
    }
}

