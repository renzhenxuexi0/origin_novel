import 'package:flutter/widgets.dart';
import 'package:origin_novel/util/platform_util.dart';

/// 统一平台组件基类
abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({super.key});

  /// 构建移动端界面
  Widget buildMobile(BuildContext context);

  /// 构建桌面端界面
  Widget buildDesktop(BuildContext context);

  /// 是否为桌面端
  bool get isDesktop => PlatformUtil().isDesktop;

  /// 自动选择并构建适合当前平台的界面
  @override
  Widget build(BuildContext context) {
    return PlatformUtil().isDesktop
        ? buildDesktop(context)
        : buildMobile(context);
  }
}
