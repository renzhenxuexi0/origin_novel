import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../global_providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "主题设置",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            themeMode.when(
              data:
                  (mode) => ThemeSelectionWidget(
                    currentTheme: mode,
                    onThemeChanged: (newMode) {
                      ref.read(appThemeModeProvider.notifier).setTheme(newMode);
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text("加载主题失败: $e"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeSelectionWidget extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(ThemeMode) onThemeChanged;

  const ThemeSelectionWidget({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: const Text("跟随系统"),
          value: ThemeMode.system,
          groupValue: currentTheme,
          onChanged: (value) => onThemeChanged(value!),
        ),
        RadioListTile<ThemeMode>(
          title: const Text("浅色模式"),
          value: ThemeMode.light,
          groupValue: currentTheme,
          onChanged: (value) => onThemeChanged(value!),
        ),
        RadioListTile<ThemeMode>(
          title: const Text("深色模式"),
          value: ThemeMode.dark,
          groupValue: currentTheme,
          onChanged: (value) => onThemeChanged(value!),
        ),
      ],
    );
  }
}
