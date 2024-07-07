import 'package:isar/isar.dart';

import '../../app/database/app_database.dart';
import '../../app/database/model/models.dart';

class BookSearchState {
  late Map<String, List<BookInfo>> searchBookInfoMap;
  late List<BookSearchInfo> bookSearchInfos;
  final Isar _isar = AppDatabase.isarInstance;
  late List<BookInfo> bookInfoList;

  BookSearchState() {
    bookInfoList = [];
    bookSearchInfos = _isar.bookSearchInfos.where().findAll();
    searchBookInfoMap = {};
  }
}
