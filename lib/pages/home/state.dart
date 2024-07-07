import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../app/constants/assets.dart';
import '../../app/database/model/models.dart';

class HomeState {
  late ZoomDrawerController zoomDrawerController;
  late List<BookInfo> myBooks;

  HomeState() {
    myBooks = [
      const BookInfo(
        id: 1,
        name: '万相之王',
        author: '天蚕土豆',
        cover: Assets.imageWxzw,
        bookSourceId: 1,
      ),
    ];
  }
}
