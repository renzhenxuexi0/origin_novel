import 'dart:async';
import 'dart:collection';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:origin_novel/app/constants/default_setting.dart';

import '../../app/constants/assets.dart';
import '../../app/database/app_database.dart';
import '../../app/database/model/models.dart';
import '../../app/l10n/generated/l10n.dart';
import '../../util/dialog/dialog_utils.dart';
import '../../util/log_utils.dart';
import 'state.dart';

class BookReadLogic extends GetxController {
  final BookReadState state = BookReadState();
  late TextPainter _textPainter;

  final _isar = AppDatabase.isarInstance;

  @override
  void onInit() {
    super.onInit();
    // 读取默认设置
    _isar.write(
      (isar) => isar.bookReadSettings.clear(),
    );
    state.bookReadSetting = _isar.bookReadSettings
            .where()
            .idEqualTo(DefaultSetting.defaultBookReadSettingId)
            .findFirst() ??
        _isar.write(
          (isar) {
            final bookReadSetting = BookReadSetting(
              id: DefaultSetting.defaultBookReadSettingId,
              updateTime: DateTime.now(),
              pageFlipType: PageFlipType.slideLeftOrRight,
              fontSize: DefaultSetting.defaultBookReadSettingFontSize,
              fontHeight: DefaultSetting.defaultBookReadSettingFontHeight,
              wordSpacing: DefaultSetting.defaultBookReadSettingWordSpacing,
              letterSpacing: DefaultSetting.defaultBookReadSettingLetterSpacing,
              fontFamily: SystemChineseFont.systemFont,
            );
            // 保存默认设置
            isar.bookReadSettings.put(bookReadSetting);
            return bookReadSetting;
          },
        );
    LogUtils.d('看书配置: ${state.bookReadSetting}');
    // 创建TextStyle
    state.contentStyle = TextStyle(
      fontSize: state.bookReadSetting.fontSize,
      height: state.bookReadSetting.fontHeight,
      wordSpacing: state.bookReadSetting.wordSpacing,
      letterSpacing: state.bookReadSetting.letterSpacing,
      fontFamily: state.bookReadSetting.fontFamily,
    );
    // 创建TextPainter
    _textPainter = TextPainter(
      text: TextSpan(
        text: "测",
        style: state.contentStyle,
      ),
      locale: Get.locale,
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: (state.contentStyle.fontSize ??
                DefaultSetting.defaultBookReadSettingFontSize) *
            2);
    // 创建PageController
    state.pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1,
    );
    // 初始化章节
    state.directory = HashMap();
    state.directory.addAll({
      1: Assets.contentChapterI,
      2: Assets.contentChapterIi,
    });
    state.currentChapter = 1;
    state.totalChapter = state.directory.length;
  }

  @override
  void onReady() {
    super.onReady();
    loadChapter(chapter: state.currentChapter);
  }

  @override
  void onClose() {
    _textPainter.dispose();
    super.onClose();
  }

  void sliderOnPageProcessChange(double value) {
    state.currentPage = value.toInt();
    state.pageController.jumpToPage(state.currentPage);
    update();
  }

  void pageOnPageProcessChange(int value) {
    state.currentPage = value;
    update();
  }

  /// 切换 AppBar 显示隐藏
  void toggleAppBarVisibility() {
    state.isAppBarVisible = !state.isAppBarVisible;
    update();
  }

  /// 加载章节
  Future<void> loadChapter({required int chapter}) async {
    if (state.directory.containsKey(chapter)) {
      try {
        DialogUtils.loading();
        // 重置
        state.currentPage = 0;
        state.currentBookContentPage = [];
        state.pageController.jumpToPage(0);
        // 加载章节内容
        state.currentChapterContent =
            await rootBundle.loadString(state.directory[chapter]!);
        // 计算分页
        _splitBookContent();
        update();
        LogUtils.d('加载第 $chapter 章节完成');
      } finally {
        await DialogUtils.dismiss();
      }
    } else {
      DialogUtils.danger(S.current.chapterDoesNotExist);
    }
  }

  /// 上一章
  Future<void> previousChapter() async {
    try {
      DialogUtils.loading();

      if (state.currentChapter < 2) {
        DialogUtils.danger(S.current.thereAreNoChaptersAhead);
        return;
      }
      state.currentChapter -= 1;
      loadChapter(chapter: state.currentChapter);
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 下一章
  Future<void> nextChapter() async {
    try {
      DialogUtils.loading();

      if (state.currentChapter > state.totalChapter + 1) {
        DialogUtils.danger(S.current.thereAreNoMoreChaptersToCome);
        return;
      }
      state.currentChapter += 1;
      loadChapter(chapter: state.currentChapter);
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 上一页
  Future<void> previousPage() async {
    if (state.currentPage > 0) {
      try {
        DialogUtils.loading();
        state.currentPage--;
        state.pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        update();
      } finally {
        await DialogUtils.dismiss();
      }
    } else {
      previousChapter();
    }
  }

  /// 下一页
  Future<void> nextPage() async {
    if (state.currentPage < state.pageSize - 1) {
      try {
        DialogUtils.loading();
        state.currentPage++;
        state.pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        update();
      } finally {
        await DialogUtils.dismiss();
      }
    } else {
      nextChapter();
    }
  }

  /// 将书的内容分页
  void _splitBookContent() {
    _calculate();
    // 1.去除多余的换行和空格
    state.currentChapterContent = state.currentChapterContent
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll('\n\n', '\n')
        .replaceAll('\n\n', '\n');
    // 2.根据中文习惯分段
    _splitBookContentByChinese();
    // 首先对内容分割 分成一段一段
    final List<String> partList = state.currentChapterContent.split('\n');
    int partLength = partList.length;
    // 当前段
    int currentPart = 0;
    // 当前页的每段内容
    List<String> currentPageContent = [];
    // 当前页的总行数
    int currentPageLineCount = 0;
    LogUtils.d('partLength: $partLength');
    // 遍历每一段
    while (currentPart < partLength) {
      // 获取当前段的字符长度
      String part = partList[currentPart].trim();
      final strLength = part.length;

      // 计算当前段有多少行
      final lineCount = (strLength.toDouble() / state.charCount).ceil();
      currentPageLineCount += lineCount;

      LogUtils.d(
          'part: $part, strLength: $strLength, lineCount: $lineCount, currentPageLineCount: $currentPageLineCount');

      // 如果长度大于最大长度
      if (currentPageLineCount > state.lineCount) {
        // 超过长度对line进行分割 根据超过的行数
        final splitCharCount =
            (lineCount - (currentPageLineCount - state.lineCount)) *
                state.charCount;
        final splitLine = part.substring(0, splitCharCount);
        currentPageContent.add(splitLine);
        currentPageLineCount = state.lineCount;
        // 多余部分添加到下一页
        final excessContent = part.substring(splitCharCount);
        partList.insert(currentPart + 1, excessContent);
        partLength++;
      } else {
        currentPageContent.add(part);
      }

      // 当前页放满后 添加到当前页的文本内容
      if (currentPageLineCount == state.lineCount) {
        // 如果当前页的行数等于最大行数
        // 添加到当前页的文本内容
        state.currentBookContentPage.add(currentPageContent.join('\n'));
        LogUtils.d(
            'currentBookContentPage: ${state.currentBookContentPage}, currentPageLineCount: $currentPageLineCount');
        // 清空当前页的内容
        currentPageContent.clear();
        // 重置当前页的行数
        currentPageLineCount = 0;
      }
      currentPart++;
    }

    state.pageSize = state.currentBookContentPage.length;
    LogUtils.d('pageSize: ${state.pageSize}');
  }

  /// 计算页面最多放多少行文字和每行多少个字
  void _calculate() {
    // 一个文字大小
    state.charHeight = _textPainter.height;
    state.charWidth = _textPainter.width;
    LogUtils.d(
        'charHeight: ${state.charHeight}, charWidth: ${state.charWidth}');
    // 计算每行多少个字
    state.contentWidth = Get.width - 2 * state.charWidth;
    state.contentHeight = Get.height - 2 * state.charHeight;
    LogUtils.d(
        '减去间距前： contentHeight: ${state.contentHeight}, contentWidth: ${state.contentWidth}');
    // 向下取整
    final lineCount = (state.contentHeight / state.charHeight).ceil();
    final charCount = (state.contentWidth / state.charWidth).ceil();
    LogUtils.d('减去间距前： lineCount: $lineCount, charCount: $charCount');
    // 减去行间距再计算
    state.contentHeight = state.contentHeight -
        ((state.bookReadSetting.letterSpacing ?? 0) * (lineCount - 2));
    state.contentWidth = state.contentWidth -
        ((state.bookReadSetting.wordSpacing ?? 0) * (charCount - 2));
    LogUtils.d(
        '减去间距后： contentHeight: ${state.contentHeight}, contentWidth: ${state.contentWidth}');
    state.lineCount = (state.contentHeight / state.charHeight).ceil();
    state.charCount = (state.contentWidth / state.charWidth).ceil();
    LogUtils.d(
        '减去间距后： lineCount: ${state.lineCount}, charCount: ${state.charCount}');
  }

  /// 根据中文习惯分段 例如 。！？” 等 理论上需要后面的符号不是中文符号时才分段
  void _splitBookContentByChinese() {}
}
