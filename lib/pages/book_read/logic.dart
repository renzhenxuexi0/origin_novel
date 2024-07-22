import 'dart:async';
import 'dart:collection';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:origin_novel/app/constants/default_setting.dart';
import 'package:origin_novel/backend/rust/api/helper/content_helper.dart';
import 'package:origin_novel/util/split_page_util.dart';

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
    // 初始化TextPainter
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
    // 计算字符宽高 和 内容宽高
    state.fontWidth = _textPainter.width;
    state.fontHeight = _textPainter.height;
    state.contentWidth = Get.width - 2 * state.fontWidth;
    state.contentHeight = Get.height - 2 * state.fontHeight;
    LogUtils.d(
        'contentHeight: ${state.contentHeight}, contentWidth: ${state.contentWidth}');
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
        state.pageController.jumpToPage(0);
        // 加载章节内容
        state.currentChapterContent =
            (await rootBundle.loadString(state.directory[chapter]!));
        state.currentChapterContent =
            handleContent(content: state.currentChapterContent);
        // 计算分页
        state.pages = SplitPageUtil.splitContent(
          content: state.currentChapterContent,
          style: state.contentStyle,
          width: state.contentWidth,
          height: state.contentHeight,
          fontHeight: state.fontHeight,
        );
        state.pageSize = state.pages.length;
        update();
        LogUtils.d('加载第 $chapter 章节完成, 总页数: ${state.pages.length}');
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
}
