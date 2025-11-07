-- 创建数据库
CREATE DATABASE IF NOT EXISTS linkfox_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE linkfox_db;

-- 用户表
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(255) NOT NULL COMMENT '密码',
    `email` VARCHAR(100) COMMENT '邮箱',
    `phone` VARCHAR(20) COMMENT '手机号',
    `avatar` VARCHAR(500) COMMENT '头像URL',
    `nickname` VARCHAR(50) COMMENT '昵称',
    `points` INT DEFAULT 0 COMMENT '算力积分',
    `vip_level` TINYINT DEFAULT 0 COMMENT 'VIP等级 0-普通 1-会员',
    `vip_expire_time` DATETIME COMMENT 'VIP过期时间',
    `status` TINYINT DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
    `deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除 0-未删除 1-已删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 分类表
CREATE TABLE `category` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
    `code` VARCHAR(50) NOT NULL COMMENT '分类代码',
    `icon` VARCHAR(500) COMMENT '分类图标',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `status` TINYINT DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
    `deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

-- 作品表
CREATE TABLE `artwork` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '作品ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `category_id` BIGINT COMMENT '分类ID',
    `title` VARCHAR(200) COMMENT '作品标题',
    `description` TEXT COMMENT '作品描述',
    `original_url` VARCHAR(500) COMMENT '原图URL',
    `processed_url` VARCHAR(500) COMMENT '处理后图片URL',
    `thumbnail_url` VARCHAR(500) COMMENT '缩略图URL',
    `width` INT COMMENT '图片宽度',
    `height` INT COMMENT '图片高度',
    `file_size` BIGINT COMMENT '文件大小(字节)',
    `process_type` VARCHAR(50) COMMENT '处理类型: smart_edit|scene_change|product|ai_dress|model|batch',
    `process_params` TEXT COMMENT '处理参数(JSON)',
    `status` TINYINT DEFAULT 0 COMMENT '状态 0-处理中 1-成功 2-失败',
    `is_public` TINYINT DEFAULT 1 COMMENT '是否公开 0-私有 1-公开',
    `view_count` INT DEFAULT 0 COMMENT '浏览次数',
    `like_count` INT DEFAULT 0 COMMENT '点赞次数',
    `points_cost` INT DEFAULT 0 COMMENT '消耗算力',
    `deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_category_id` (`category_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作品表';

-- 标签表
CREATE TABLE `tag` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '标签ID',
    `name` VARCHAR(50) NOT NULL COMMENT '标签名称',
    `use_count` INT DEFAULT 0 COMMENT '使用次数',
    `deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='标签表';

-- 作品标签关联表
CREATE TABLE `artwork_tag` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `artwork_id` BIGINT NOT NULL COMMENT '作品ID',
    `tag_id` BIGINT NOT NULL COMMENT '标签ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_artwork_id` (`artwork_id`),
    KEY `idx_tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作品标签关联表';

-- 订单表
CREATE TABLE `order` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `order_type` TINYINT NOT NULL COMMENT '订单类型 1-积分充值 2-VIP购买',
    `amount` DECIMAL(10,2) NOT NULL COMMENT '订单金额',
    `points` INT COMMENT '积分数量',
    `pay_method` VARCHAR(20) COMMENT '支付方式',
    `pay_time` DATETIME COMMENT '支付时间',
    `status` TINYINT DEFAULT 0 COMMENT '状态 0-待支付 1-已支付 2-已取消 3-已退款',
    `deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- 积分记录表
CREATE TABLE `points_record` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `points` INT NOT NULL COMMENT '积分变动',
    `balance` INT NOT NULL COMMENT '变动后余额',
    `type` TINYINT NOT NULL COMMENT '类型 1-充值 2-消费 3-赠送 4-退款',
    `remark` VARCHAR(200) COMMENT '备注',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分记录表';

-- 插入初始分类数据
INSERT INTO `category` (`name`, `code`, `sort_order`) VALUES
('智能修图', 'smart_edit', 1),
('场景制变', 'scene_change', 2),
('商品图', 'product', 3),
('AI穿衣', 'ai_dress', 4),
('真人模特', 'model', 5),
('批量生成', 'batch', 6),
('模特图', 'model_photo', 7),
('POD素材', 'pod_material', 8),
('AI视频', 'ai_video', 9),
('AI修图', 'ai_retouch', 10);

-- 插入测试用户 (密码: 123456)
INSERT INTO `user` (`username`, `password`, `email`, `nickname`, `points`, `vip_level`) VALUES
('admin', '$2a$10$mMXTafj9mSyatSWfwIWNyehO2sqrzV/do8AvT5PtXkiLhVXBHFHyu', 'admin@linkfox.com', '管理员', 10000, 1),
('testuser', '$2a$10$mMXTafj9mSyatSWfwIWNyehO2sqrzV/do8AvT5PtXkiLhVXBHFHyu', 'test@linkfox.com', '测试用户', 100, 0);

