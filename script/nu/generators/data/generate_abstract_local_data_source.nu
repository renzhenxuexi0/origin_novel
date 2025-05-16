# 生成本地数据源接口

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {
    let content = $"import '../../dto/($feature_name)_dto.dart';

/// 抽象本地数据源接口，处理($capitalized_feature_name)相关的本地存储操作
abstract interface class I($capitalized_feature_name)LocalDataSource {
  /// 获取本地存储的($capitalized_feature_name)
  Future<($capitalized_feature_name)Dto?> getLocal($capitalized_feature_name)\(\);
  
  /// 保存($capitalized_feature_name)到本地
  Future<void> saveLocal($capitalized_feature_name)\(($capitalized_feature_name)Dto dto\);
  
  /// 从本地删除($capitalized_feature_name)
  Future<void> deleteLocal($capitalized_feature_name)\(\);

  /// 检查本地是否有缓存的($capitalized_feature_name)
  Future<bool> hasLocal($capitalized_feature_name)Cache\(\);
}"
    
    create_file $"lib/features/($feature_name)/data/sources/local/($feature_name)_local_data_source_abstract.dart" $content
}
