# 生成远程数据源接口

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {
    let content = $"import '../../dtos/($feature_name)_dto.dart';

/// 抽象远程数据源接口，处理($capitalized_feature_name)相关的远程操作
abstract interface class I($capitalized_feature_name)RemoteDataSource {
  /// 获取所有($capitalized_feature_name)
  Future<List<($capitalized_feature_name)Dto>> getAll\(\);
  
  /// 根据ID获取($capitalized_feature_name)
  Future<($capitalized_feature_name)Dto> getById\(int id\);
  
  /// 创建新的($capitalized_feature_name)
  Future<($capitalized_feature_name)Dto> create\(($capitalized_feature_name)Dto dto\);
  
  /// 更新($capitalized_feature_name)
  Future<($capitalized_feature_name)Dto> update\(($capitalized_feature_name)Dto dto\);
  
  /// 删除($capitalized_feature_name)
  Future<void> delete\(int id\);
}"
    
    create_file $"lib/features/($feature_name)/data/sources/remote/($feature_name)_remote_data_source_abstract.dart" $content
}