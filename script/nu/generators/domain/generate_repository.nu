# 生成仓库接口

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
] {    
    let content = $"import '../entities/($feature_name)_entity.dart';

/// 抽象仓库接口，定义($capitalized_feature_name)相关的业务操作
abstract interface class I($capitalized_feature_name)Repository {
  /// 获取所有($capitalized_feature_name)
  Future<List<($capitalized_feature_name)Entity>> getAll\({bool forceRefresh = false}\);
  
  /// 根据ID获取($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity?> getById\(int id, {bool forceRefresh = false}\);
  
  /// 创建新的($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> create\(($capitalized_feature_name)Entity entity\);
  
  /// 更新($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> update\(($capitalized_feature_name)Entity entity\);
  
  /// 删除($capitalized_feature_name)
  Future<void> delete\(int id\);
}"
    
    create_file $"lib/features/($feature_name)/domain/repositories/($feature_name)_repository.dart" $content
}