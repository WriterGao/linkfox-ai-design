package com.linkfox.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 作品实体
 */
@Data
@TableName("artwork")
public class Artwork implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    
    private Long userId;
    
    private Long categoryId;
    
    private String title;
    
    private String description;
    
    private String originalUrl;
    
    private String processedUrl;
    
    private String thumbnailUrl;
    
    private Integer width;
    
    private Integer height;
    
    private Long fileSize;
    
    private String processType;
    
    private String processParams;
    
    private Integer status;
    
    private Integer isPublic;
    
    private Integer viewCount;
    
    private Integer likeCount;
    
    private Integer pointsCost;
    
    @TableLogic
    private Integer deleted;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}

