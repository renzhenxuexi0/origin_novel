import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/app_preference_repository_impl.dart';
import '../../domain/repositories/app_preference_repository.dart';

part 'app_theme_mode_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  static final _key = PreferenceKey.enum_(
    'app_theme_mode',
    defaultValue: ThemeMode.system,
    converter: (index) => ThemeMode.values[index],
  );
  late IAppPreferenceRepository _appPreferenceRepository;
  @override
  Future<ThemeMode> build() async {
    _appPreferenceRepository = await ref.watch(
      appPreferenceRepositoryProvider.future,
    );
    return _loadTheme();
  }

  Future<ThemeMode> _loadTheme() async {
    return _appPreferenceRepository.getValue(_key) ?? ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _appPreferenceRepository.setValue(_key, mode);
    state = AsyncData(mode);
  }
}
