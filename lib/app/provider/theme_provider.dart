import 'package:flutter/material.dart';
import 'package:origin_novel/app/constant/app_preference_keys.dart'
    show AppPreferenceKeys;
import 'package:origin_novel/app/preference/app_preference.dart'
    show AppPreferences;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  Future<ThemeMode> build() async {
    return _loadTheme();
  }

  Future<ThemeMode> _loadTheme() async {
    return AppPreferences.getValue(AppPreferenceKeys.themeMode) ??
        ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    await AppPreferences.setValue(AppPreferenceKeys.themeMode, mode);
    state = AsyncData(mode);
  }
}
