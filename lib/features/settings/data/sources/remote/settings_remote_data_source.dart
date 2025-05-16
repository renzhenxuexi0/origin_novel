import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/settings_dto.dart';
import 'settings_remote_data_source_abstract.dart';

part 'settings_remote_data_source.g.dart';

/// 提供Settings远程数据源的Provider
@riverpod
ISettingsRemoteDataSource settingsRemoteDataSource(Ref ref) {
  return SettingsRemoteDataSource();
}

/// 远程数据源实现，处理Settings相关的API请求
class SettingsRemoteDataSource implements ISettingsRemoteDataSource {
  @override
  Future<SettingsDto> getSettings() async {
    // TODO: Implement the API call to fetch Settings
    throw UnimplementedError('getSettings not implemented');
  }

  @override
  Future<SettingsDto> createSettings(SettingsDto dto) async {
    // TODO: Implement the API call to create Settings
    throw UnimplementedError('createSettings not implemented');
  }

  @override
  Future<SettingsDto> updateSettings(SettingsDto dto) async {
    // TODO: Implement the API call to update Settings
    throw UnimplementedError('updateSettings not implemented');
  }

  @override
  Future<void> deleteSettings(String id) async {
    // TODO: Implement the API call to delete Settings
    throw UnimplementedError('deleteSettings not implemented');
  }
}
