import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/localization/translations.g.dart';
import 'shared/presentation/pages/orgin_novel.dart';

Future<void> main() async {
  // 初始化Flutter引擎
  // WidgetsFlutterBinding是Flutter的一个绑定类，用于连接Flutter框架和底层的渲染引擎。
  WidgetsFlutterBinding.ensureInitialized();
  // 本地化设置
  LocaleSettings.useDeviceLocale();
  runApp(ProviderScope(child: TranslationProvider(child: const OrginNovel())));
}
