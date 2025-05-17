# 生成Realm本地数据源接口

export def main [
  feature_name: string            # 特性名称
  capitalized_feature_name: string  # 首字母大写的特性名称
  provider_name: string            # 驼峰式命名的特性名
] {    
  let content = $"import '../../models/($feature_name)_model.dart';

/// 抽象本地数据源接口，处理($capitalized_feature_name)相关的本地存储操作
abstract interface class I($capitalized_feature_name)LocalDataSource {
  /// 获取所有($capitalized_feature_name)
  Future<List<($capitalized_feature_name)Model>> getAll\(\);
  
  /// 根据ID获取($capitalized_feature_name)
  Future<($capitalized_feature_name)Model?> getById\(int id\);
  
  /// 保存单个($capitalized_feature_name)
  Future<void> save\(($capitalized_feature_name)Model model\);
  
  /// 批量保存($capitalized_feature_name)
  Future<void> saveAll\(List<($capitalized_feature_name)Model> models\);
  
  /// 根据ID删除($capitalized_feature_name)
  Future<void> delete\(int id\);
  
  /// 删除所有($capitalized_feature_name)
  Future<void> deleteAll\(\);
  
  /// 检查指定ID的($capitalized_feature_name)是否存在
  Future<bool> exists\(int id\);
}"
  
  create_file $"lib/features/($feature_name)/data/sources/local/($feature_name)_local_data_source_abstract.dart" $content
}