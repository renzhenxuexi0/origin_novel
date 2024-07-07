import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../app/database/model/models.dart';

class BookReadState {
  /// 拖动开始位置
  double startDrag = 0.0;

  /// 拖动总量
  double totalDrag = 0.0;

  /// 小说内容
  String bookContent = '';

  /// 是否显示 AppBar
  bool isAppBarVisible = true;

  /// textPainter
  late TextPainter textPainter;

  /// 对内容分页
  int pageSize = 1;
  int currentPage = 0;
  List<String> currentBookContentPage = [''];

  /// 章节
  late int currentChapter;
  late int totalChapter;

  /// 目录
  late HashMap<int, String> directory;

  /// 每章节的分页内容
  late HashMap<ChapterType, List<String>> bookContentMap;

  /// 当前屏幕大小
  double screenWidth = 0;
  double screenHeight = 0;

  /// 小说字体配置
  late TextStyle contentStyle;
  late BookReadSetting bookReadSetting;

  /// 是否修改了字体大小
  bool isFontSizeChanged = false;

  /// 每页最多多少行
  int lineCount = -1;

  /// 每页最多多少列
  int charCount = -1;

  /// PageController
  late PageController pageController;

  /// 焦点
  FocusNode keyboardListenerFocusNode = FocusNode();
}

enum ChapterType {
  previous,
  next,
  current,
}
