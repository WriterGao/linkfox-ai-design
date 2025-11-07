package com.linkfox;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * LinkFox AI设计平台 - 启动类
 * 
 * @author LinkFox
 * @date 2024
 */
@SpringBootApplication
@MapperScan("com.linkfox.mapper")
public class LinkFoxApplication {

    public static void main(String[] args) {
        SpringApplication.run(LinkFoxApplication.class, args);
        System.out.println("\n====================================");
        System.out.println("LinkFox AI设计平台启动成功！");
        System.out.println("接口文档地址: http://localhost:8080/api");
        System.out.println("====================================\n");
    }
}

