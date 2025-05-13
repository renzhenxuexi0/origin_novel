import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_novel/app/router/router.dart';
import 'package:origin_novel/app/theme/app_theme.dart';

import 'app/i18n/strings.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(ProviderScope(child: TranslationProvider(child: const MyApp())));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return PlatformProvider(
      builder: (context) {
        return PlatformTheme(
          // 主题配置
          materialLightTheme: AppTheme.light,
          materialDarkTheme: AppTheme.dark,
          cupertinoLightTheme: MaterialBasedCupertinoThemeData(
            materialTheme: AppTheme.light,
          ),
          cupertinoDarkTheme: MaterialBasedCupertinoThemeData(
            materialTheme: AppTheme.dark,
          ),
          builder: (context) {
            return PlatformApp.router(
              // 本地化配置
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              title: 'Origin Novel',
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
