import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/settings_entity.dart';
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

  /// 加载Settings
  Future<void> load({bool forceRefresh = false}) async {
    state = SettingsState.loading();

    try {
      final data = await _useCase.get(forceRefresh: forceRefresh);
      state = SettingsState(data: data);
    } catch (e) {
      state = SettingsState.error('加载失败: ${e.toString()}');
    }
  }

  /// 创建新的Settings
  Future<void> create(SettingsEntity entity) async {
    state = state.copyWith(isLoading: true);

    try {
      final created = await _useCase.create(entity);
      state = SettingsState(data: created);
    } catch (e) {
      state = SettingsState.error('创建失败: ${e.toString}');
    }
  }

  /// 更新Settings
  Future<void> update(SettingsEntity entity) async {
    state = state.copyWith(isLoading: true);

    try {
      final updated = await _useCase.update(entity);
      state = SettingsState(data: updated);
    } catch (e) {
      state = SettingsState.error('更新失败: ${e.toString}');
    }
  }

  /// 删除Settings
  Future<void> delete(String id) async {
    state = state.copyWith(isLoading: true);

    try {
      await _useCase.delete(id);
      state = const SettingsState();
    } catch (e) {
      state = SettingsState.error('删除失败: ${e.toString()}');
    }
  }
}
