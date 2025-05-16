import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../mappers/settings_mapper.dart';
import '../sources/local/settings_local_data_source.dart';
import '../sources/local/settings_local_data_source_abstract.dart';
import '../sources/remote/settings_remote_data_source.dart';
import '../sources/remote/settings_remote_data_source_abstract.dart';

part 'settings_repository_impl.g.dart';

/// 提供SettingsRepository的Provider
@riverpod
ISettingsRepository settingsRepository(Ref ref) {
  final remoteDataSource = ref.watch(settingsRemoteDataSourceProvider);
  final localDataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(remoteDataSource, localDataSource);
}

/// SettingsRepository的实现
class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsRemoteDataSource _remoteDataSource;
  final ISettingsLocalDataSource _localDataSource;

  const SettingsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<SettingsEntity> getSettings({bool forceRefresh = false}) async {
    // 检查是否有本地缓存且不强制刷新
    if (!forceRefresh && await _localDataSource.hasLocalSettingsCache()) {
      final localDto = await _localDataSource.getLocalSettings();
      if (localDto != null) {
        return SettingsMapper.toEntity(localDto);
      }
    }

    // 从远程获取数据
    try {
      final remoteDto = await _remoteDataSource.getSettings();
      // 缓存到本地
      await _localDataSource.saveLocalSettings(remoteDto);
      return SettingsMapper.toEntity(remoteDto);
    } catch (e) {
      // 如果远程获取失败，尝试从本地获取
      final localDto = await _localDataSource.getLocalSettings();
      if (localDto != null) {
        return SettingsMapper.toEntity(localDto);
      }
      rethrow; // 如果本地也没有，则重新抛出异常
    }
  }

  @override
  Future<SettingsEntity> createSettings(SettingsEntity entity) async {
    final dto = SettingsMapper.toDto(entity);
    final createdDto = await _remoteDataSource.createSettings(dto);
    await _localDataSource.saveLocalSettings(createdDto);
    return SettingsMapper.toEntity(createdDto);
  }

  @override
  Future<SettingsEntity> updateSettings(SettingsEntity entity) async {
    final dto = SettingsMapper.toDto(entity);
    final updatedDto = await _remoteDataSource.updateSettings(dto);
    await _localDataSource.saveLocalSettings(updatedDto);
    return SettingsMapper.toEntity(updatedDto);
  }

  @override
  Future<void> deleteSettings(String id) async {
    await _remoteDataSource.deleteSettings(id);
    await _localDataSource.deleteLocalSettings();
  }
}
