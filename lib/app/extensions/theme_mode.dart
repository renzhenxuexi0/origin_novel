part of 'extensions.dart';

extension ThemeModeExtension on ThemeMode {
  Brightness? get brightness {
    switch (this) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return null;
    }
  }
}
