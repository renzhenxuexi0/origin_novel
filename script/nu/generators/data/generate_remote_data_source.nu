# 生成远程数据源实现

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {
    let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/($feature_name)_dto.dart';
import '($feature_name)_remote_data_source_abstract.dart';

part '($feature_name)_remote_data_source.g.dart';

/// 提供($capitalized_feature_name)远程数据源的Provider
@riverpod
I($capitalized_feature_name)RemoteDataSource ($provider_name)RemoteDataSource\(Ref ref\) {
  return ($capitalized_feature_name)RemoteDataSource\(\);
}

/// 远程数据源实现，处理($capitalized_feature_name)相关的API请求
class ($capitalized_feature_name)RemoteDataSource implements I($capitalized_feature_name)RemoteDataSource {
  
  @override
  Future<($capitalized_feature_name)Dto> get($capitalized_feature_name)\(\) async {
    // TODO: Implement the API call to fetch ($capitalized_feature_name)
    throw UnimplementedError\('get($capitalized_feature_name) not implemented'\);
  }
  
  @override
  Future<($capitalized_feature_name)Dto> create($capitalized_feature_name)\(($capitalized_feature_name)Dto dto\) async {
    // TODO: Implement the API call to create ($capitalized_feature_name)
    throw UnimplementedError\('create($capitalized_feature_name) not implemented'\);
  }
  
  @override
  Future<($capitalized_feature_name)Dto> update($capitalized_feature_name)\(($capitalized_feature_name)Dto dto\) async {
    // TODO: Implement the API call to update ($capitalized_feature_name)
    throw UnimplementedError\('update($capitalized_feature_name) not implemented'\);
  }
  
  @override
  Future<void> delete($capitalized_feature_name)\(String id\) async {
    // TODO: Implement the API call to delete ($capitalized_feature_name)
    throw UnimplementedError\('delete($capitalized_feature_name) not implemented'\);
  }
}"
    
    create_file $"lib/features/($feature_name)/data/sources/remote/($feature_name)_remote_data_source.dart" $content
}
