import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../app/constants/assets.dart';
import '../../app/database/model/models.dart';
import '../../app/l10n/generated/l10n.dart';
import '../../app/routes/app_routes.dart';
import '../../widget/gap.dart';
import 'logic.dart';
import 'state.dart';

part 'widget/bookshelf.dart';
part 'widget/menu_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          // 开启或关闭抽屉菜单
          onPressed: () => state.zoomDrawerController.toggle!(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed(AppRoutes.bookSearch),
          ),
        ],
      ),
      body: GetBuilder<HomeLogic>(builder: (logic) {
        return ZoomDrawer(
          controller: state.zoomDrawerController,
          menuScreen: const MenuScreen(),
          mainScreen: Bookshelf(logic: logic, state: state),
          borderRadius: 24.0,
          angle: 0.0,
          mainScreenTapClose: true,
        );
      }),
    );
  }
}
