import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'app/database/app_database.dart';
import 'app/l10n/generated/l10n.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'backend/rust/frb_generated.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized()是一个静态方法，
  // 它会初始化Flutter的Widgets库。这个方法通常在你的应用程序的main()函数中调用，
  // 特别是在你的应用程序需要在runApp()之前执行异步操作时。
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化窗口管理器
  await windowManager.ensureInitialized();
  // 初始化isar
  await AppDatabase.init();
  // 初始化rust
  await RustLib.init();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    minimumSize: Size(800, 600),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '起源小说',
      // 未知路由
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('404'),
          ),
        ),
      ),
      builder: FlutterSmartDialog.init(),
      navigatorObservers: <NavigatorObserver>[FlutterSmartDialog.observer],
      navigatorKey: Get.key,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      defaultTransition: Transition.rightToLeftWithFade,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        // 指定本地化的字符串和一些其他的值
        GlobalMaterialLocalizations.delegate,
        // 对应的Cupertino风格
        GlobalCupertinoLocalizations.delegate,
        // 指定默认的文本排列方向, 由左到右或由右到左
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
