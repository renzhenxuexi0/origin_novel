# 生成本地数据源实现

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {
    let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/($feature_name)_dto.dart';
import '($feature_name)_local_data_source_abstract.dart';

part '($feature_name)_local_data_source.g.dart';

/// 提供($capitalized_feature_name)本地数据源的Provider
@riverpod
I($capitalized_feature_name)LocalDataSource ($provider_name)LocalDataSource\(Ref ref\) {
  return ($capitalized_feature_name)LocalDataSource\(\);
}

/// 本地数据源实现，处理($capitalized_feature_name)相关的本地存储操作
class ($capitalized_feature_name)LocalDataSource implements I($capitalized_feature_name)LocalDataSource {
  
  @override
  Future<($capitalized_feature_name)Dto?> getLocal($capitalized_feature_name)\(\) async {
    // TODO: Implement the logic to retrieve ($capitalized_feature_name) from local storage
    throw UnimplementedError\('getLocal($capitalized_feature_name) not implemented'\);
  }
  
  @override
  Future<void> saveLocal($capitalized_feature_name)\(($capitalized_feature_name)Dto dto\) async {
    // TODO: Implement the logic to save ($capitalized_feature_name) to local storage
    throw UnimplementedError\('saveLocal($capitalized_feature_name) not implemented'\);
  }
  
  @override
  Future<void> deleteLocal($capitalized_feature_name)\(\) async {
    // TODO: Implement the logic to delete ($capitalized_feature_name) from local storage
  }

  @override
  Future<bool> hasLocal($capitalized_feature_name)Cache\(\) async {
    // TODO: Implement the logic to check if ($capitalized_feature_name) is cached locally
    throw UnimplementedError\('hasLocal($capitalized_feature_name)Cache not implemented'\);
  }
}"
    
    create_file $"lib/features/($feature_name)/data/sources/local/($feature_name)_local_data_source.dart" $content
}
