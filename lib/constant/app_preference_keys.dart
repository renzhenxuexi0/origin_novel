import 'package:flutter/material.dart' show ThemeMode;
import '../preference/app_preference.dart' show PreferenceKey;

/// 应用偏好设置键定义
class AppPreferenceKeys {
  // 私有构造函数，防止实例化
  AppPreferenceKeys._();

  /// 主题模式偏好设置键
  static final themeMode = PreferenceKey.enum_(
    'app_theme_mode',
    defaultValue: ThemeMode.system,
    converter: (index) => ThemeMode.values[index],
  );
}
