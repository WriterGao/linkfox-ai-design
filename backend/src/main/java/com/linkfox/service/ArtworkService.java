package com.linkfox.service;

import com.linkfox.common.PageResult;
import com.linkfox.dto.ArtworkQueryDTO;
import com.linkfox.entity.Artwork;
import org.springframework.web.multipart.MultipartFile;

/**
 * 作品服务接口
 */
public interface ArtworkService {
    
    /**
     * 上传作品
     */
    Artwork uploadArtwork(MultipartFile file, Long userId, String processType);
    
    /**
     * 分页查询作品
     */
    PageResult<Artwork> queryArtworks(ArtworkQueryDTO dto);
    
    /**
     * 获取作品详情
     */
    Artwork getArtworkById(Long id);
    
    /**
     * 删除作品
     */
    boolean deleteArtwork(Long id, Long userId);
}

