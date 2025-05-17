import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/localization/translations.g.dart';
import '../../../../shared/presentation/providers/app_language_provider.dart';
import '../../../../shared/presentation/providers/app_theme_mode_provider.dart';
import '../providers/settings_provider.dart';
import '../states/settings_state.dart';

/// Settings功能的主页面
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final appLanguage = ref.watch(appLanguageProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);
    final t = context.t;

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.title)),
      body: _buildBody(context, ref, settingsState, appLanguage, appThemeMode),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    SettingsState state,
    AsyncValue<AppLocale> appLanguage,
    AsyncValue<ThemeMode> appThemeMode,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        _buildThemeSettings(context, ref, appThemeMode),
        const Divider(),
        _buildLanguageSettings(context, ref, appLanguage),
      ],
    );
  }

  Widget _buildThemeSettings(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<ThemeMode> themeMode,
  ) {
    final t = context.t;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.settings.theme,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          themeMode.when(
            data:
                (mode) => Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(t.settings.system_default),
                      value: ThemeMode.system,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) async {
                        if (value != null) {
                          await ref
                              .read(appThemeModeProvider.notifier)
                              .setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(t.settings.light_mode),
                      value: ThemeMode.light,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) async {
                        if (value != null) {
                          await ref
                              .read(appThemeModeProvider.notifier)
                              .setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(t.settings.dark_mode),
                      value: ThemeMode.dark,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) async {
                        if (value != null) {
                          await ref
                              .read(appThemeModeProvider.notifier)
                              .setTheme(value);
                        }
                      },
                    ),
                  ],
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('无法加载主题设置'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSettings(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<AppLocale> appLanguage,
  ) {
    final t = context.t;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.settings.language,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          appLanguage.when(
            data:
                (lang) => Column(
                  children: [
                    RadioListTile<AppLocale>(
                      title: Text(t.settings.chinese),
                      value: AppLocale.zhCn,
                      groupValue: lang,
                      onChanged: (AppLocale? value) async {
                        if (value != null) {
                          await ref
                              .read(appLanguageProvider.notifier)
                              .setLanguage(value);
                        }
                      },
                    ),
                    RadioListTile<AppLocale>(
                      title: Text(t.settings.english),
                      value: AppLocale.en,
                      groupValue: lang,
                      onChanged: (AppLocale? value) async {
                        if (value != null) {
                          await ref
                              .read(appLanguageProvider.notifier)
                              .setLanguage(value);
                        }
                      },
                    ),
                  ],
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('无法加载语言设置'),
          ),
        ],
      ),
    );
  }
}
