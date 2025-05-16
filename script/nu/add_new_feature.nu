#!/usr/bin/env nu

# 导入所有工具模块
use utils/validators.nu *
use utils/string_utils.nu *
use utils/file_utils.nu *

# 导入所有生成器模块
use generators/data/generate_dto.nu
use generators/data/generate_mapper.nu
use generators/data/generate_remote_data_source.nu
use generators/data/generate_abstract_remote_data_source.nu
use generators/data/generate_local_data_source.nu
use generators/data/generate_abstract_local_data_source.nu
use generators/data/generate_repository_impl.nu
use generators/domain/generate_entity.nu
use generators/domain/generate_repository.nu
use generators/domain/generate_use_case.nu
use generators/presentation/generate_notifier.nu
use generators/presentation/generate_page.nu
use generators/generate_barrel_files.nu

# 创建特性的函数
def create_feature [
    feature_name: string  # 特性名称
] {
    print $"🔍 Validating feature name: ($feature_name)"
    
    # 验证特性名称
    let validation_result = (validate_feature_name $feature_name)
    if not $validation_result {
        exit 1
    }
    print "✅ Feature name validation passed"
    
    print "🔄 Converting naming conventions..."
    # 转换命名约定
    let capitalized_feature_name = (convert_to_pascal_case $feature_name)
    print $"  - PascalCase: ($capitalized_feature_name)"
    
    let provider_name = (convert_to_lower_camel_case $feature_name)
    print $"  - camelCase: ($provider_name)"
    
    print "📁 Creating base directory structure..."
    # 创建基础目录结构
    create_base_directories $feature_name
    print "✅ Base directories created"
    
    print "🏗️ Generating feature files..."
    
    print "  📝 Generating Data Layer..."
    # 生成Data层文件
    generate_repository $feature_name $capitalized_feature_name $provider_name
    generate_repository_impl $feature_name $capitalized_feature_name $provider_name
    generate_abstract_remote_data_source $feature_name $capitalized_feature_name $provider_name
    generate_abstract_local_data_source $feature_name $capitalized_feature_name $provider_name
    generate_remote_data_source $feature_name $capitalized_feature_name $provider_name
    generate_local_data_source $feature_name $capitalized_feature_name $provider_name
    generate_dto $feature_name $capitalized_feature_name
    generate_mapper $feature_name $capitalized_feature_name
    print "  ✅ Data Layer complete"
    
    print "  📝 Generating Domain Layer..."
    # 生成Domain层文件
    generate_entity $feature_name $capitalized_feature_name
    generate_use_case $feature_name $capitalized_feature_name $provider_name
    print "  ✅ Domain Layer complete"
    
    print "  📝 Generating Presentation Layer..."
    # 生成Presentation层文件
    generate_notifier $feature_name $capitalized_feature_name $provider_name
    generate_page $feature_name $capitalized_feature_name $provider_name
    print "  ✅ Presentation Layer complete"
    
    print "  📝 Generating Barrel Files..."
    # 生成Barrel文件
    generate_barrel_files $feature_name
    print "  ✅ Barrel Files complete"
    
    print "  🔨 Running build_runner to generate code..."
    # 运行build_runner生成代码
    flutter pub run build_runner build -d
    print "  ✅ Code generation complete"
    
    print "  🔧 Applying code fixes..."
    # 应用代码修复
    dart fix --apply
    print "  ✅ Code fixes applied"
    
    print "  💅 Formatting code..."
    # 格式化代码
    dart format lib/features/($feature_name)/
    print "  ✅ Code formatting complete"
}

# 主函数
def main [feature_name: string = ""] {
    if $feature_name == "" {
        # 如果没有提供特性名称，则显示错误信息
        print "❌ Error: Feature name is required."
        print "Usage: nu add_new_feature.nu <feature_name>"
        exit 1
    }
    
    print $"🚀 Starting feature generation for: ($feature_name)"
    create_feature $feature_name
    print $"✨ Clean architecture structure for feature '($feature_name)' created successfully!"
    
    # 显示生成的结构
    print $"
📁 Generated structure:
lib/features/($feature_name)/
├── data/
│   ├── dto/
│   ├── mappers/
│   ├── repositories/
│   └── sources/
│       ├── local/
│       └── remote/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
"
}
