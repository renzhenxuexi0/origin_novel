import 'dart:async';

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:origin_novel/app/database/app_database.dart';
import 'package:origin_novel/backend/rust/api/model/search_book.dart';

import '../../app/database/model/models.dart';
import '../../backend/rust/api/search_book_api.dart';
import 'state.dart';

class BookSearchLogic extends GetxController {
  final BookSearchState state = BookSearchState();
  final Isar _isar = AppDatabase.isarInstance;

  @override
  void onInit() {
    super.onInit();
    state.bookSources = _isar.bookSources
        .where()
        .canEnableEqualTo(true)
        .and()
        .enabledEqualTo(true)
        .findAll();
  }

  /// 关键词搜索
  Future<void> bookSearch(String keyword) async {
    final bookSource = state.bookSources.first;
    searchBook(keyword: keyword, bookSourceJson: bookSource.bookSourceJson)
        .then((value) {
      state.bookSearchInfos = value
          .map(
            (searchBook) => toBookSearchInfo(
              searchBook,
              bookSource.id,
            ),
          )
          .toList();
    });
    update();
  }

  BookSearchInfo toBookSearchInfo(SearchBook searchBook, int bookSourceId) {
    return BookSearchInfo(
      id: _isar.bookSearchInfos.autoIncrement(),
      bookSourceId: bookSourceId,
      author: searchBook.author,
      bookUrl: searchBook.bookUrl,
      coverUrl: searchBook.coverUrl,
      intro: searchBook.intro,
      kind: searchBook.kind,
      wordCount: searchBook.wordCount,
      name: searchBook.name,
    );
  }
}
