import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplitPageUtil {
  const SplitPageUtil._();

  /// 将书的内容分页
  static List<String> splitContent({
    required String content,
    required TextStyle style,
    required double width,
    required double height,
    required double fontHeight,
  }) {
    List<String> pages = [];

    while (true) {
      // 去掉开头的换行符
      while (true) {
        if (content.isNotEmpty && content[0] == '\n') {
          content = content.substring(1);
        } else {
          break;
        }
      }
      final text = TextPainter(
        text: TextSpan(
          text: content,
          style: style,
        ),
        locale: Get.locale,
        textDirection: TextDirection.ltr,
      );
      text.layout(maxWidth: width);
      var end =
          text.getPositionForOffset(Offset(width, height - fontHeight)).offset;

      if (end == 0) {
        break;
      }

      // 将内容添加到分页列表中
      pages.add(content.substring(0, end));
      // 去掉已经分页的内容
      content = content.substring(end, content.length);
      text.dispose();
    }
    return pages;
  }
}
