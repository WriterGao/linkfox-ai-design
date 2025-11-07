#!/bin/bash

# LinkFox AI设计平台 - 图片快速放置脚本
# 
# 使用方法：
# 1. 将您的图片放在一个文件夹中
# 2. 修改下面的 SOURCE_DIR 为您的图片文件夹路径
# 3. 运行脚本: chmod +x 复制图片脚本.sh && ./复制图片脚本.sh

echo "======================================"
echo "  LinkFox - 图片快速放置工具"
echo "======================================"
echo ""

# 修改这里为您的图片源目录
SOURCE_DIR="/path/to/your/images"

# 目标目录
TARGET_DIR="$(cd "$(dirname "$0")" && pwd)/public/images"

echo "源目录: $SOURCE_DIR"
echo "目标目录: $TARGET_DIR"
echo ""

# 检查源目录
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ 错误: 源目录不存在"
    echo "请修改脚本中的 SOURCE_DIR 变量"
    exit 1
fi

echo "📋 图片分类说明："
echo ""
echo "【功能卡片图片 - 6张】"
echo "1. 智能修图 (smart-edit.jpg) - T恤/服装图"
echo "2. 场景制变 (scene-change.jpg) - 室内场景"
echo "3. 商品图 (product.jpg) - 香水/产品"
echo "4. AI穿衣 (ai-dress.jpg) - 外套模特"
echo "5. 真人模特 (model.jpg) - 白衬衫模特"
echo "6. 批量生成 (batch.jpg) - 组合产品"
echo ""
echo "【作品展示图片 - 12+张】"
echo "artwork-1.jpg ~ artwork-12.jpg"
echo ""

read -p "是否要继续进行交互式图片选择？(y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消"
    exit 0
fi

# 功能卡片图片
echo ""
echo "=== 选择功能卡片图片 ==="
echo ""

# 智能修图
echo "1. 选择【智能修图】图片 (建议: T恤/服装图)"
read -p "   输入文件名: " file1
if [ -f "$SOURCE_DIR/$file1" ]; then
    cp "$SOURCE_DIR/$file1" "$TARGET_DIR/features/smart-edit.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# 场景制变
echo "2. 选择【场景制变】图片 (建议: 室内场景)"
read -p "   输入文件名: " file2
if [ -f "$SOURCE_DIR/$file2" ]; then
    cp "$SOURCE_DIR/$file2" "$TARGET_DIR/features/scene-change.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# 商品图
echo "3. 选择【商品图】图片 (建议: 香水/产品)"
read -p "   输入文件名: " file3
if [ -f "$SOURCE_DIR/$file3" ]; then
    cp "$SOURCE_DIR/$file3" "$TARGET_DIR/features/product.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# AI穿衣
echo "4. 选择【AI穿衣】图片 (建议: 外套模特)"
read -p "   输入文件名: " file4
if [ -f "$SOURCE_DIR/$file4" ]; then
    cp "$SOURCE_DIR/$file4" "$TARGET_DIR/features/ai-dress.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# 真人模特
echo "5. 选择【真人模特】图片 (建议: 白衬衫模特)"
read -p "   输入文件名: " file5
if [ -f "$SOURCE_DIR/$file5" ]; then
    cp "$SOURCE_DIR/$file5" "$TARGET_DIR/features/model.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# 批量生成
echo "6. 选择【批量生成】图片 (建议: 组合产品)"
read -p "   输入文件名: " file6
if [ -f "$SOURCE_DIR/$file6" ]; then
    cp "$SOURCE_DIR/$file6" "$TARGET_DIR/features/batch.jpg"
    echo "   ✓ 已复制"
else
    echo "   ✗ 文件不存在"
fi

# 作品展示图片
echo ""
echo "=== 作品展示图片 ==="
echo ""
read -p "是否批量复制作品图片？(y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "请在源目录中准备好图片，命名为:"
    echo "artwork-1.jpg, artwork-2.jpg, artwork-3.jpg, ..."
    echo ""
    read -p "请输入要复制的图片数量: " count
    
    for i in $(seq 1 $count); do
        if [ -f "$SOURCE_DIR/artwork-$i.jpg" ]; then
            cp "$SOURCE_DIR/artwork-$i.jpg" "$TARGET_DIR/artworks/"
            echo "   ✓ 已复制 artwork-$i.jpg"
        elif [ -f "$SOURCE_DIR/artwork-$i.png" ]; then
            cp "$SOURCE_DIR/artwork-$i.png" "$TARGET_DIR/artworks/artwork-$i.jpg"
            echo "   ✓ 已复制 artwork-$i.png (转换为jpg)"
        else
            echo "   ✗ 未找到 artwork-$i.jpg/png"
        fi
    done
fi

echo ""
echo "======================================"
echo "✅ 图片放置完成！"
echo "======================================"
echo ""
echo "请刷新浏览器查看效果"
echo "如果图片没有显示，请检查:"
echo "1. 文件名是否正确"
echo "2. 文件格式是否为 jpg/png/webp"
echo "3. 清除浏览器缓存后重试"

