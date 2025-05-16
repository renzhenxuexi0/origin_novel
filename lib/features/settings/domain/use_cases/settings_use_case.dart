import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/settings_repository_impl.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

part 'settings_use_case.g.dart';

/// 获取SettingsUseCase的Provider
@riverpod
SettingsUseCase settingsUseCase(Ref ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsUseCase(repository);
}

/// Settings相关的用例
class SettingsUseCase {
  final ISettingsRepository _repository;

  const SettingsUseCase(this._repository);

  /// 获取Settings
  Future<SettingsEntity> get({bool forceRefresh = false}) async {
    return _repository.getSettings(forceRefresh: forceRefresh);
  }

  /// 创建新的Settings
  Future<SettingsEntity> create(SettingsEntity entity) async {
    return _repository.createSettings(entity);
  }

  /// 更新Settings
  Future<SettingsEntity> update(SettingsEntity entity) async {
    return _repository.updateSettings(entity);
  }

  /// 删除Settings
  Future<void> delete(String id) async {
    return _repository.deleteSettings(id);
  }
}
