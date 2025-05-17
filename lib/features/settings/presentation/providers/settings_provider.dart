import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/use_cases/settings_use_case.dart';
import '../states/settings_state.dart';

part 'settings_provider.g.dart';

/// 管理Settings状态的Provider
@riverpod
class Settings extends _$Settings {
  late final _useCase = ref.read(settingsUseCaseProvider);

  @override
  SettingsState build() {
    // 初始状态
    return const SettingsState();
  }
}
