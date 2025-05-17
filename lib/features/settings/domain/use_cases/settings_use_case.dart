import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/settings_repository_impl.dart';
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
}
