import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/localization/strings.g.dart';
import 'src/orgin_novel.dart';
import 'src/preference/app_preference.dart';

Future<void> main() async {
  // 初始化Flutter引擎
  // WidgetsFlutterBinding是Flutter的一个绑定类，用于连接Flutter框架和底层的渲染引擎。
  WidgetsFlutterBinding.ensureInitialized();
  // 本地化设置
  LocaleSettings.useDeviceLocale();
  // 初始化应用偏好设置
  await AppPreferences.init();
  runApp(ProviderScope(child: TranslationProvider(child: const OrginNovel())));
}


