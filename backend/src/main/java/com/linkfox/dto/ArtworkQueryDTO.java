package com.linkfox.dto;

import lombok.Data;

/**
 * 作品查询DTO
 */
@Data
public class ArtworkQueryDTO {
    
    private Long pageNum = 1L;
    
    private Long pageSize = 20L;
    
    private Long categoryId;
    
    private String processType;
    
    private String keyword;
    
    private Integer isPublic;
    
    private String sortField = "create_time";
    
    private String sortOrder = "desc";
}

