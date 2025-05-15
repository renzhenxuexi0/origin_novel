import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtil {
  static final PlatformUtil _instance = PlatformUtil._internal();

  factory PlatformUtil() => _instance;

  PlatformUtil._internal();

  bool get isDesktop {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux || kIsWeb;
  }

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isMobile => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  bool get isWeb => kIsWeb;

  bool get isMacOS => !kIsWeb && Platform.isMacOS;

  bool get isWindows => !kIsWeb && Platform.isWindows;

  bool get isLinux => !kIsWeb && Platform.isLinux;
}
