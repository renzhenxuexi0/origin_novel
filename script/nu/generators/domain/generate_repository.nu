# 生成仓库接口

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
    provider_name: string           # 驼峰式命名的特性名
] {
    let content = $"import '../entities/($feature_name)_entity.dart';

/// 抽象仓库接口，定义($capitalized_feature_name)相关的业务操作
abstract interface class I($capitalized_feature_name)Repository {
  /// 获取($capitalized_feature_name)，可选是否强制刷新
  Future<($capitalized_feature_name)Entity> get($capitalized_feature_name)\({bool forceRefresh = false}\);
  
  /// 创建新的($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> create($capitalized_feature_name)\(($capitalized_feature_name)Entity entity\);
  
  /// 更新($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> update($capitalized_feature_name)\(($capitalized_feature_name)Entity entity\);
  
  /// 删除($capitalized_feature_name)
  Future<void> delete($capitalized_feature_name)\(String id\);
}"
    
    create_file $"lib/features/($feature_name)/domain/repositories/($feature_name)_repository.dart" $content
}
