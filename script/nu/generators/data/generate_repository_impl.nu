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
import '../models/($feature_name)_model.dart';
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
  Future<List<($capitalized_feature_name)Entity>> getAll\({bool forceRefresh = false}\) async {
  List<($capitalized_feature_name)Model> localModels = await _localDataSource.getAll\(\);
  
  // 如果强制刷新或本地数据为空，则从远程获取
  if \(forceRefresh || localModels.isEmpty\) {
    try {
    final remoteDtos = await _remoteDataSource.getAll\(\);
    
    // 将远程DTO转换为Model并保存到本地
    final models = remoteDtos.map\(($capitalized_feature_name)Mapper.dtoToModel\).toList\(\);
    await _localDataSource.saveAll\(models\);
    
    // 从本地重新获取最新数据
    localModels = await _localDataSource.getAll\(\);
    } catch \(e\) {
    // 如果远程获取失败，继续使用本地数据
    print\('Error fetching remote data: \$e'\);
    }
  }
  
  // 将Model转换为Entity并返回
  return localModels.map\(($capitalized_feature_name)Mapper.modelToEntity\).toList\(\);
  }

  @override
  Future<($capitalized_feature_name)Entity?> getById\(int id, {bool forceRefresh = false}\) async {
  // 如果不强制刷新且本地存在，则直接返回本地数据
  if \(!forceRefresh\) {
    final localModel = await _localDataSource.getById\(id\);
    if \(localModel != null\) {
    return ($capitalized_feature_name)Mapper.modelToEntity\(localModel\);
    }
  }

  // 从远程获取数据
  try {
    final remoteDto = await _remoteDataSource.getById\(id\);
    final model = ($capitalized_feature_name)Mapper.dtoToModel\(remoteDto\);
    
    // 保存到本地
    await _localDataSource.save\(model\);
    return ($capitalized_feature_name)Mapper.modelToEntity\(model\);
  } catch \(e\) {
    // 如果远程获取失败但已有本地数据，则返回本地数据
    final localModel = await _localDataSource.getById\(id\);
    if \(localModel != null\) {
    return ($capitalized_feature_name)Mapper.modelToEntity\(localModel\);
    }
    // 如果本地也没有数据，则返回null或抛出异常
    return null;
  }
  }

  @override
  Future<($capitalized_feature_name)Entity> create\(($capitalized_feature_name)Entity entity\) async {
  // 将实体转换为DTO
  final dto = ($capitalized_feature_name)Mapper.entityToDto\(entity\);
  
  // 调用远程API创建记录
  final createdDto = await _remoteDataSource.create\(dto\);
  
  // 将返回的DTO转换为Model并保存到本地
  final model = ($capitalized_feature_name)Mapper.dtoToModel\(createdDto\);
  await _localDataSource.save\(model\);
  
  // 返回转换后的实体
  return ($capitalized_feature_name)Mapper.modelToEntity\(model\);
  }

  @override
  Future<($capitalized_feature_name)Entity> update\(($capitalized_feature_name)Entity entity\) async {
  // 将实体转换为DTO
  final dto = ($capitalized_feature_name)Mapper.entityToDto\(entity\);
  
  // 调用远程API更新记录
  final updatedDto = await _remoteDataSource.update\(dto\);
  
  // 将返回的DTO转换为Model并保存到本地
  final model = ($capitalized_feature_name)Mapper.dtoToModel\(updatedDto\);
  await _localDataSource.save\(model\);
  
  // 返回转换后的实体
  return ($capitalized_feature_name)Mapper.modelToEntity\(model\);
  }

  @override
  Future<void> delete\(int id\) async {
  // 调用远程API删除记录
  await _remoteDataSource.delete\(id\);
  
  // 同时从本地删除
  await _localDataSource.delete\(id\);
  }
}"
  
  create_file $"lib/features/($feature_name)/data/repositories/($feature_name)_repository_impl.dart" $content
}