import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// 支持多平台自适应的 Widget 基类
class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    super.key,
    required this.desktopBuilder,
    required this.mobileBuilder,
    this.windowsBuilder,
    this.linuxBuilder,
    this.macOSBuilder,
    this.androidBuilder,
    this.iOSBuilder,
    this.fuchsiaBuilder,
  });
  final WidgetBuilder desktopBuilder;
  final WidgetBuilder mobileBuilder;
  final WidgetBuilder? windowsBuilder;
  final WidgetBuilder? linuxBuilder;
  final WidgetBuilder? macOSBuilder;
  final WidgetBuilder? androidBuilder;
  final WidgetBuilder? iOSBuilder;
  final WidgetBuilder? fuchsiaBuilder;

  @override
  Widget build(BuildContext context) {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => iOSBuilder?.call(context) ?? mobileBuilder(context),
      TargetPlatform.android =>
        androidBuilder?.call(context) ?? mobileBuilder(context),
      TargetPlatform.windows =>
        windowsBuilder?.call(context) ?? desktopBuilder(context),

      TargetPlatform.linux =>
        linuxBuilder?.call(context) ?? desktopBuilder(context),
      TargetPlatform.macOS =>
        macOSBuilder?.call(context) ?? desktopBuilder(context),
      TargetPlatform.fuchsia =>
        fuchsiaBuilder?.call(context) ?? desktopBuilder(context),
    };
  }
}
