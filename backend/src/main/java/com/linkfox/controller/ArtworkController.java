package com.linkfox.controller;

import com.linkfox.common.PageResult;
import com.linkfox.common.Result;
import com.linkfox.dto.ArtworkQueryDTO;
import com.linkfox.entity.Artwork;
import com.linkfox.service.ArtworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 作品Controller
 */
@RestController
@RequestMapping("/artwork")
public class ArtworkController {
    
    @Autowired
    private ArtworkService artworkService;
    
    /**
     * 上传作品
     */
    @PostMapping("/upload")
    public Result<Artwork> uploadArtwork(
            @RequestParam("file") MultipartFile file,
            @RequestParam("userId") Long userId,
            @RequestParam(value = "processType", defaultValue = "smart_edit") String processType) {
        try {
            Artwork artwork = artworkService.uploadArtwork(file, userId, processType);
            return Result.success("上传成功", artwork);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 分页查询作品
     */
    @PostMapping("/list")
    public Result<PageResult<Artwork>> queryArtworks(@RequestBody ArtworkQueryDTO dto) {
        try {
            PageResult<Artwork> result = artworkService.queryArtworks(dto);
            return Result.success(result);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 获取作品详情
     */
    @GetMapping("/{id}")
    public Result<Artwork> getArtworkById(@PathVariable Long id) {
        Artwork artwork = artworkService.getArtworkById(id);
        if (artwork != null) {
            return Result.success(artwork);
        }
        return Result.error("作品不存在");
    }
    
    /**
     * 删除作品
     */
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteArtwork(@PathVariable Long id, @RequestParam Long userId) {
        try {
            boolean success = artworkService.deleteArtwork(id, userId);
            return Result.success(success);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}

