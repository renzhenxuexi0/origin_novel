import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/settings_dto.dart';
import 'settings_local_data_source_abstract.dart';

part 'settings_local_data_source.g.dart';

/// 提供Settings本地数据源的Provider
@riverpod
ISettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  return SettingsLocalDataSource();
}

/// 本地数据源实现，处理Settings相关的本地存储操作
class SettingsLocalDataSource implements ISettingsLocalDataSource {
  @override
  Future<SettingsDto?> getLocalSettings() async {
    // TODO: Implement the logic to retrieve Settings from local storage
    throw UnimplementedError('getLocalSettings not implemented');
  }

  @override
  Future<void> saveLocalSettings(SettingsDto dto) async {
    // TODO: Implement the logic to save Settings to local storage
    throw UnimplementedError('saveLocalSettings not implemented');
  }

  @override
  Future<void> deleteLocalSettings() async {
    // TODO: Implement the logic to delete Settings from local storage
  }

  @override
  Future<bool> hasLocalSettingsCache() async {
    // TODO: Implement the logic to check if Settings is cached locally
    throw UnimplementedError('hasLocalSettingsCache not implemented');
  }
}
