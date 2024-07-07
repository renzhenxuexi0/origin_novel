import 'package:get/get.dart';

import '../../app/database/model/models.dart';

class BookDetailState {
  late BookInfo bookInfo;

  BookDetailState() {
    bookInfo = Get.arguments as BookInfo;
  }
}
