# 生成仓库实现

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {
    let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/($feature_name)_entity.dart';
import '../../domain/repositories/($feature_name)_repository.dart';
import '../mappers/($feature_name)_mapper.dart';
import '../sources/local/($feature_name)_local_data_source.dart';
import '../sources/remote/($feature_name)_remote_data_source.dart';
import '../sources/local/($feature_name)_local_data_source_abstract.dart';
import '../sources/remote/($feature_name)_remote_data_source_abstract.dart';

part '($feature_name)_repository_impl.g.dart';

/// 提供($capitalized_feature_name)Repository的Provider
@riverpod
I($capitalized_feature_name)Repository ($provider_name)Repository\(Ref ref\) {
  final remoteDataSource = ref.watch\(($provider_name)RemoteDataSourceProvider\);
  final localDataSource = ref.watch\(($provider_name)LocalDataSourceProvider\);
  return ($capitalized_feature_name)RepositoryImpl\(remoteDataSource, localDataSource\);
}

/// ($capitalized_feature_name)Repository的实现
class ($capitalized_feature_name)RepositoryImpl implements I($capitalized_feature_name)Repository {
  final I($capitalized_feature_name)RemoteDataSource _remoteDataSource;
  final I($capitalized_feature_name)LocalDataSource _localDataSource;

  const ($capitalized_feature_name)RepositoryImpl\(this._remoteDataSource, this._localDataSource\);

  @override
  Future<($capitalized_feature_name)Entity> get($capitalized_feature_name)\({bool forceRefresh = false}\) async {
    // 检查是否有本地缓存且不强制刷新
    if \(!forceRefresh && await _localDataSource.hasLocal($capitalized_feature_name)Cache\(\)\) {
      final localDto = await _localDataSource.getLocal($capitalized_feature_name)\(\);
      if \(localDto != null\) {
        return ($capitalized_feature_name)Mapper.toEntity\(localDto\);
      }
    }

    // 从远程获取数据
    try {
      final remoteDto = await _remoteDataSource.get($capitalized_feature_name)\(\);
      // 缓存到本地
      await _localDataSource.saveLocal($capitalized_feature_name)\(remoteDto\);
      return ($capitalized_feature_name)Mapper.toEntity\(remoteDto\);
    } catch \(e\) {
      // 如果远程获取失败，尝试从本地获取
      final localDto = await _localDataSource.getLocal($capitalized_feature_name)\(\);
      if \(localDto != null\) {
        return ($capitalized_feature_name)Mapper.toEntity\(localDto\);
      }
      rethrow; // 如果本地也没有，则重新抛出异常
    }
  }

  @override
  Future<($capitalized_feature_name)Entity> create($capitalized_feature_name)\(($capitalized_feature_name)Entity entity\) async {
    final dto = ($capitalized_feature_name)Mapper.toDto\(entity\);
    final createdDto = await _remoteDataSource.create($capitalized_feature_name)\(dto\);
    await _localDataSource.saveLocal($capitalized_feature_name)\(createdDto\);
    return ($capitalized_feature_name)Mapper.toEntity\(createdDto\);
  }

  @override
  Future<($capitalized_feature_name)Entity> update($capitalized_feature_name)\(($capitalized_feature_name)Entity entity\) async {
    final dto = ($capitalized_feature_name)Mapper.toDto\(entity\);
    final updatedDto = await _remoteDataSource.update($capitalized_feature_name)\(dto\);
    await _localDataSource.saveLocal($capitalized_feature_name)\(updatedDto\);
    return ($capitalized_feature_name)Mapper.toEntity\(updatedDto\);
  }

  @override
  Future<void> delete($capitalized_feature_name)\(String id\) async {
    await _remoteDataSource.delete($capitalized_feature_name)\(id\);
    await _localDataSource.deleteLocal($capitalized_feature_name)\(\);
  }
}"
    
    create_file $"lib/features/($feature_name)/data/repositories/($feature_name)_repository_impl.dart" $content
}
