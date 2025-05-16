#!/usr/bin/env nu

# 字符串处理工具函数

# 将特性名称转换为PascalCase
export def convert_to_pascal_case [
    feature_name: string # 要转换的特性名称
] {
    # 将特性名称按下划线分割成单词
    let words = ($feature_name | split row '_')
    
    # 对每个单词首字母大写，然后拼接
    $words | each {|word|
        $word | str capitalize
    } | str join ''
}

# 将特性名称转换为lowerCamelCase
export def convert_to_lower_camel_case [
    feature_name: string # 要转换的特性名称
] {
    # 将特性名称按下划线分割成单词
    let words = ($feature_name | split row '_')
    
    # 第一个单词保持小写
    let first_word = ($words | first | str downcase)
    
    # 如果只有一个单词，直接返回
    if ($words | length) <= 1 {
        return $first_word
    }
    
    # 其余单词首字母大写，然后与第一个单词拼接
    let remaining_words = ($words | skip 1 | each {|word|
        $word | str capitalize
    } | str join '')
    
    # 拼接结果
    $first_word + $remaining_words
}
