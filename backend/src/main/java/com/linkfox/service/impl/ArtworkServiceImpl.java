package com.linkfox.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.linkfox.common.PageResult;
import com.linkfox.dto.ArtworkQueryDTO;
import com.linkfox.entity.Artwork;
import com.linkfox.mapper.ArtworkMapper;
import com.linkfox.service.ArtworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * 作品服务实现
 */
@Service
public class ArtworkServiceImpl implements ArtworkService {
    
    @Autowired
    private ArtworkMapper artworkMapper;
    
    @Value("${file.upload-path}")
    private String uploadPath;
    
    @Value("${file.access-url}")
    private String accessUrl;
    
    @Override
    public Artwork uploadArtwork(MultipartFile file, Long userId, String processType) {
        if (file.isEmpty()) {
            throw new RuntimeException("文件不能为空");
        }
        
        try {
            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String ext = FileUtil.extName(originalFilename);
            String filename = IdUtil.simpleUUID() + "." + ext;
            
            // 保存文件
            File dest = new File(uploadPath + filename);
            FileUtil.mkParentDirs(dest);
            file.transferTo(dest);
            
            // 创建作品记录
            Artwork artwork = new Artwork();
            artwork.setUserId(userId);
            artwork.setOriginalUrl(accessUrl + filename);
            artwork.setProcessedUrl(accessUrl + filename); // 实际项目中这里应该调用AI处理接口
            artwork.setThumbnailUrl(accessUrl + filename);
            artwork.setFileSize(file.getSize());
            artwork.setProcessType(processType);
            artwork.setStatus(1);
            artwork.setIsPublic(1);
            artwork.setViewCount(0);
            artwork.setLikeCount(0);
            artwork.setPointsCost(10); // 消耗10算力
            
            artworkMapper.insert(artwork);
            return artwork;
            
        } catch (IOException e) {
            throw new RuntimeException("文件上传失败: " + e.getMessage());
        }
    }
    
    @Override
    public PageResult<Artwork> queryArtworks(ArtworkQueryDTO dto) {
        Page<Artwork> page = new Page<>(dto.getPageNum(), dto.getPageSize());
        LambdaQueryWrapper<Artwork> wrapper = new LambdaQueryWrapper<>();
        
        // 条件查询
        if (dto.getCategoryId() != null) {
            wrapper.eq(Artwork::getCategoryId, dto.getCategoryId());
        }
        if (dto.getProcessType() != null) {
            wrapper.eq(Artwork::getProcessType, dto.getProcessType());
        }
        if (dto.getIsPublic() != null) {
            wrapper.eq(Artwork::getIsPublic, dto.getIsPublic());
        }
        
        // 排序
        if ("create_time".equals(dto.getSortField())) {
            wrapper.orderByDesc(Artwork::getCreateTime);
        } else if ("view_count".equals(dto.getSortField())) {
            wrapper.orderByDesc(Artwork::getViewCount);
        } else if ("like_count".equals(dto.getSortField())) {
            wrapper.orderByDesc(Artwork::getLikeCount);
        }
        
        Page<Artwork> result = artworkMapper.selectPage(page, wrapper);
        
        return new PageResult<>(
            result.getTotal(),
            result.getCurrent(),
            result.getSize(),
            result.getRecords()
        );
    }
    
    @Override
    public Artwork getArtworkById(Long id) {
        return artworkMapper.selectById(id);
    }
    
    @Override
    public boolean deleteArtwork(Long id, Long userId) {
        Artwork artwork = artworkMapper.selectById(id);
        if (artwork == null) {
            throw new RuntimeException("作品不存在");
        }
        if (!artwork.getUserId().equals(userId)) {
            throw new RuntimeException("无权删除该作品");
        }
        return artworkMapper.deleteById(id) > 0;
    }
}

