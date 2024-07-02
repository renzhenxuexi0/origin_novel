import 'package:flutter/cupertino.dart';

import '../../app/database/models/models.dart';

class BookSourceState {
  List<String> sourceOfBookSource = [
    'https://github.moeyy.xyz/https://raw.githubusercontent.com/XIU2/Yuedu/master/shuyuan',
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
