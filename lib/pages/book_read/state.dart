import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../app/database/model/models.dart';

class BookReadState {
  /// 拖动开始位置
  double startDrag = 0.0;

  /// 拖动总量
  double totalDrag = 0.0;

  /// 当前章节的小说内容
  String currentChapterContent = '';

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

  /// 小说字体配置
  late TextStyle contentStyle;
  late BookReadSetting bookReadSetting;

  /// 每页多少行
  int lineCount = -1;

  /// 每行多少个字符
  int charCount = -1;

  /// 字符宽度
  double charWidth = 0.0;

  /// 字符高度
  double charHeight = 0.0;

  /// 内容宽度
  double contentWidth = 0.0;

  /// 内容高度
  double contentHeight = 0.0;

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
