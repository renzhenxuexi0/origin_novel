import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/realm_provider.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_repository_impl.g.dart';

/// 提供SettingsRepository的Provider
@riverpod
ISettingsRepository settingsRepository(Ref ref) {
  final realm = ref.watch(realmProvider);
  return SettingsRepositoryImpl(realm);
}

/// SettingsRepository的实现
class SettingsRepositoryImpl implements ISettingsRepository {
  final _realm;

  const SettingsRepositoryImpl(this._realm);
}
