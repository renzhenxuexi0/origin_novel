#!/usr/bin/env nu

# 文件操作工具函数

# 创建文件及其内容
export def create_file [
    file_path: string  # 文件路径
    content: string    # 文件内容
] {
    # 确保目录存在
    mkdir (dirname $file_path)
    
    # 将内容写入文件
    $content | save -f $file_path
}

# 创建基础目录结构
export def create_base_directories [
    feature_name: string # 特性名称
] {
    let base_dirs = [
        $"lib/features/($feature_name)/data/mappers"
        $"lib/features/($feature_name)/data/repositories"
        $"lib/features/($feature_name)/data/dto"
        $"lib/features/($feature_name)/data/sources/remote"
        $"lib/features/($feature_name)/data/sources/local"
        $"lib/features/($feature_name)/domain/entities"
        $"lib/features/($feature_name)/domain/repositories"
        $"lib/features/($feature_name)/domain/use_cases"
        $"lib/features/($feature_name)/presentation/providers"
        $"lib/features/($feature_name)/presentation/states"
        $"lib/features/($feature_name)/presentation/pages"
        $"lib/features/($feature_name)/presentation/widgets"
    ]
    
    # 创建每个基础目录
    $base_dirs | each {|dir|
        mkdir $dir
    }
}
