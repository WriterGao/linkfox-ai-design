package com.linkfox.common;

import lombok.Data;
import java.io.Serializable;
import java.util.List;

/**
 * 分页返回结果
 */
@Data
public class PageResult<T> implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Long total;      // 总记录数
    private Long pageNum;    // 当前页
    private Long pageSize;   // 每页大小
    private List<T> records; // 数据列表
    
    public PageResult() {}
    
    public PageResult(Long total, Long pageNum, Long pageSize, List<T> records) {
        this.total = total;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.records = records;
    }
}

