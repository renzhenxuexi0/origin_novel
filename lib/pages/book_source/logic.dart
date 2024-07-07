import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:origin_novel/app/database/app_database.dart';
import 'package:origin_novel/app/database/model/models.dart';
import 'package:origin_novel/util/dialog/dialog_utils.dart';
import 'package:origin_novel/util/log_utils.dart';

import '../../backend/rust/api/model/book_source.dart' as rust_book_source;
import '../../backend/rust/api/parse_book_source_api.dart';
import 'state.dart';

class BookSourceLogic extends GetxController {
  final BookSourceState state = BookSourceState();
  final Isar _isar = AppDatabase.isarInstance;

  @override
  void onInit() {
    super.onInit();
    // 初始化搜索框控制器
    state.searchController = TextEditingController();

    // 如果数据库中没有书源，则从网络获取
    if (_isar.bookSources.count() == 0) {
      initBookSourcesFormNet();
    } else {
      _initBookSourcesFormIsar();
    }
  }

  /// 展示所有书源
  void showAllBookSources() {
    state.showBookSources = state.bookSources;
    state.showBookSources.sort();
    state.bookSourceGroup = BookSourceGroup.all;
    update();
  }

  /// 展示启用的书源
  void showEnabledBookSources() {
    state.showBookSources =
        state.bookSources.where((element) => element.enabled).toList();
    state.showBookSources.sort();
    state.bookSourceGroup = BookSourceGroup.enabled;
    update();
  }

  /// 展示禁用的书源
  void showDisabledBookSources() {
    state.showBookSources =
        state.bookSources.where((element) => !element.enabled).toList();
    state.showBookSources.sort();
    state.bookSourceGroup = BookSourceGroup.disabled;
    update();
  }

  /// 置顶书源
  Future<void> topBookSource(BookSource bookSource) async {
    try {
      DialogUtils.loading();
      // 获取权重最大的书源
      final maxWeight = state.bookSources.map((e) => e.weight).reduce((a, b) {
        a ??= 0;
        b ??= 0;
        return a > b ? a : b;
      });
      // 把权重设置为最大的书源权重+1
      bookSource = bookSource.copyWith(weight: (maxWeight ?? 0) + 1);
      _isar.write((isar) {
        isar.bookSources.put(bookSource);
      });
      _initBookSourcesFormIsar();
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 启用/禁用书源
  Future<void> enableOrDisableBookSource(BookSource bookSource) async {
    try {
      DialogUtils.loading();
      bookSource = bookSource.copyWith(enabled: !bookSource.enabled);
      _isar.write((isar) {
        isar.bookSources.put(bookSource);
      });
      _initBookSourcesFormIsar();
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 删除书源
  Future<void> deleteBookSource(BookSource bookSource) async {
    try {
      DialogUtils.loading();
      _isar.write((isar) {
        isar.bookSources.delete(bookSource.id);
      });
      _initBookSourcesFormIsar();
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 从网络获取书源
  Future<void> initBookSourcesFormNet() async {
    try {
      DialogUtils.loading();
      // 记录开始时间
      final DateTime now = DateTime.now();
      // 获取书源
      final bookSources =
          await parseBookSourceFromUrl(url: state.sourceOfBookSource[0]);
      LogUtils.d('获取书源成功 bookSources.length: ${bookSources.length}');
      state.bookSources = [];
      if (bookSources.isNotEmpty) {
        for (final element in bookSources) {
          final bookSource = _convertBookSource(element);

          if (bookSource != null) {
            state.bookSources.add(bookSource);
          }
        }
        _isar.write((isar) {
          isar.bookSources.clear();
          isar.bookSources.putAll(state.bookSources);
        });
      }
      _switchBookSource();
      LogUtils.d(
          '获取书源成功 耗时: ${DateTime.now().difference(now).inMilliseconds}ms');
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 搜索框内容改变
  void onSearchChanged(String value) {
    state.showBookSources = state.bookSources
        .where((element) => element.bookSourceName.contains(value))
        .toList();
    update();
  }

  /// 从数据库中初始化书源
  Future<void> _initBookSourcesFormIsar() async {
    try {
      DialogUtils.loading();
      state.bookSources = _isar.bookSources.where().findAll().toList();
      LogUtils.d(
          "initBookSourcesFormIsar state.bookSources.length: ${_isar.bookSources.count()}");
      _switchBookSource();
    } finally {
      await DialogUtils.dismiss();
    }
  }

  /// 筛选书源
  void _switchBookSource() {
    switch (state.bookSourceGroup) {
      case BookSourceGroup.all:
        showAllBookSources();
        break;
      case BookSourceGroup.enabled:
        showEnabledBookSources();
        break;
      case BookSourceGroup.disabled:
        showDisabledBookSources();
        break;
    }
  }

  BookSource? _convertBookSource(rust_book_source.BookSource bookSource) {
    try {
      return BookSource(
        id: _isar.bookSources.autoIncrement(),
        bookSourceName: bookSource.bookSourceName!,
        bookSourceUrl: bookSource.bookSourceUrl!,
        enabled: bookSource.enabled ?? true,
        canEnable: bookSource.canEnable ?? true,
        exploreUrl: bookSource.exploreUrl,
        header: bookSource.header,
        loginUrl: bookSource.loginUrl,
        lastUpdateTime: bookSource.lastUpdateTime,
        respondTime: bookSource.respondTime,
        bookSourceComment: bookSource.bookSourceComment,
        bookSourceGroup: bookSource.bookSourceGroup,
        bookSourceType: bookSource.bookSourceType,
        customOrder: bookSource.customOrder,
        bookUrlPattern: bookSource.bookUrlPattern,
        enabledCookieJar: bookSource.enabledCookieJar,
        enabledExplore: bookSource.enabledExplore,
        searchUrl: bookSource.searchUrl,
        weight: bookSource.weight,
        ruleBookInfo: RuleBookInfo.fromRustModel(bookSource.ruleBookInfo),
        ruleContent: RuleContent.fromRustModel(bookSource.ruleContent),
        ruleExplore: RuleExplore.fromRustModel(bookSource.ruleExplore),
        ruleReview: RuleReview.fromRustModel(bookSource.ruleReview),
        ruleSearch: RuleSearch.fromRustModel(bookSource.ruleSearch),
        ruleToc: RuleToc.fromRustModel(bookSource.ruleToc),
      );
    } catch (e) {
      LogUtils.e('转化书源失败 error: $e');
      return null;
    }
  }
}
