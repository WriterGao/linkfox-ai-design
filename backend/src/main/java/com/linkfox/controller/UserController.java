package com.linkfox.controller;

import com.linkfox.common.Result;
import com.linkfox.dto.UserLoginDTO;
import com.linkfox.dto.UserRegisterDTO;
import com.linkfox.entity.User;
import com.linkfox.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 用户Controller
 */
@RestController
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    /**
     * 用户注册
     */
    @PostMapping("/register")
    public Result<User> register(@Validated @RequestBody UserRegisterDTO dto) {
        try {
            User user = userService.register(dto);
            user.setPassword(null); // 不返回密码
            return Result.success("注册成功", user);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 用户登录
     */
    @PostMapping("/login")
    public Result<Map<String, Object>> login(@Validated @RequestBody UserLoginDTO dto) {
        try {
            Map<String, Object> result = userService.login(dto);
            return Result.success("登录成功", result);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 获取用户信息
     */
    @GetMapping("/{id}")
    public Result<User> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        if (user != null) {
            user.setPassword(null);
            return Result.success(user);
        }
        return Result.error("用户不存在");
    }
    
    /**
     * 更新用户信息
     */
    @PutMapping("/update")
    public Result<Boolean> updateUser(@RequestBody User user) {
        try {
            boolean success = userService.updateUser(user);
            return Result.success(success);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}

