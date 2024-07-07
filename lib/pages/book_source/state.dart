import 'package:flutter/cupertino.dart';

import '../../app/database/model/models.dart';

class BookSourceState {
  List<String> sourceOfBookSource = [
    'https://mirror.ghproxy.com/https://raw.githubusercontent.com/shidahuilang/shuyuan/shuyuan/good.json',
  ];

  List<BookSource> bookSources = [];

  List<BookSource> showBookSources = [];

  late TextEditingController searchController;

  BookSourceGroup bookSourceGroup = BookSourceGroup.all;

  BookSourceState() {
    showBookSources = bookSources;
  }
}

enum BookSourceGroup {
  all,
  enabled,
  disabled,
}
