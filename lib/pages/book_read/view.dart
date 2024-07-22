import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/database/model/models.dart';
import '../../app/l10n/generated/l10n.dart';
import '../../widget/gap.dart';
import 'logic.dart';
import 'widget/book_read_page_bottom_button.dart';

const double _bottomBarHeight = 150.0;
const double _opacity = 0.8;

class BookReadPage extends StatelessWidget {
  BookReadPage({super.key});

  final logic = Get.find<BookReadLogic>();
  final state = Get.find<BookReadLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              // 文本内容
              _buildContent(),
              // 可隐藏的 AppBar
              _buildAppBar(context),
              // 可隐藏的 BottomNavigationBar
              _buildBottomNavigationBar(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 顶部栏
  Widget _buildAppBar(BuildContext context) {
    return GetBuilder<BookReadLogic>(builder: (logic) {
      return AnimatedPositioned(
        top: state.isAppBarVisible ? 0 : -kToolbarHeight,
        // kToolbarHeight是底部栏的推荐高度
        left: 0,
        right: 0,
        duration: const Duration(milliseconds: 200),
        child: AppBar(
          title: const Text('小说标题'),
          backgroundColor:
              context.theme.appBarTheme.backgroundColor?.withOpacity(_opacity),
        ),
      );
    });
  }

  /// 内容
  Widget _buildContent() {
    return GetBuilder<BookReadLogic>(
      builder: (logic) {
        return GestureDetector(
          onTap: logic.toggleAppBarVisibility,
          child: PageView.builder(
            controller: state.pageController,
            itemCount: state.pageSize,
            scrollDirection: switch (state.bookReadSetting.pageFlipType) {
              PageFlipType.slideLeftOrRight => Axis.horizontal,
              PageFlipType.slideUpAndDown => Axis.vertical,
            },
            onPageChanged: logic.pageOnPageProcessChange,
            itemBuilder: (context, index) {
              return Container(
                width: state.contentWidth,
                height: state.contentHeight,
                // 间隔1个字符的宽度和高度
                padding: EdgeInsets.symmetric(
                  horizontal: state.charWidth,
                  vertical: state.charHeight,
                ),
                child: Text(
                  state.pages[index],
                  style: state.contentStyle,
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// 底部栏
  Widget _buildBottomNavigationBar(BuildContext context) {
    return GetBuilder<BookReadLogic>(builder: (logic) {
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        bottom: state.isAppBarVisible ? 0 : -_bottomBarHeight,
        // kToolbarHeight是底部栏的推荐高度
        left: 0,
        right: 0,
        // 底部菜单栏
        child: Container(
          height: _bottomBarHeight,
          width: double.infinity,
          // 半透明
          color: context.theme.colorScheme.surface.withOpacity(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // 上一章 下一章 页进度
              _buildChangeChaptersButtonsAndProcess(context),
              const Gap.vn(),
              // 功能栏
              _buildFunctionBar(context),
            ],
          ),
        ),
      );
    });
  }

  /// 上一章 下一章
  Widget _buildChangeChaptersButtonsAndProcess(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.surface.withOpacity(0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 上一章
          TextButton(
            onPressed: () async {
              // TODO: 上一章
              await logic.previousChapter();
            },
            child: Text(S.of(context).previousChapter),
          ),
          // 进度条
          Expanded(
            child: GetBuilder<BookReadLogic>(builder: (logic) {
              return Slider(
                value: state.currentPage.toDouble(),
                min: 0.0,
                max: state.pageSize.toDouble() - 1,
                divisions:
                    state.pageSize == 1 ? state.pageSize : (state.pageSize - 1),
                label: S.of(context).pageN(state.currentPage + 1),
                onChanged: logic.sliderOnPageProcessChange,
              );
            }),
          ),
          // 下一章
          TextButton(
            onPressed: () async {
              // TODO: 下一章
              await logic.nextChapter();
            },
            child: Text(S.of(context).nextChapter),
          ),
        ],
      ),
    );
  }

  /// 功能栏按钮
  Widget _buildFunctionBar(BuildContext context) {
    return Expanded(
      child: Container(
        color: context.theme.colorScheme.surface.withOpacity(_opacity),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 目录
            BookReadPageBottomButton(
              text: S.of(context).directory,
              icon: Icons.menu_book,
              onPressed: () {
                // TODO: 目录
              },
            ),
            // 缓存书内容
            BookReadPageBottomButton(
              text: S.of(context).cache,
              icon: Icons.download,
              onPressed: () {
                // TODO: 缓存书内容
              },
            ),
            // 翻页设置
            BookReadPageBottomButton(
              text: S.of(context).flip,
              icon: Icons.flip_to_back,
              onPressed: () {
                // TODO: 翻页设置
              },
            ),
            // 阅读设置
            BookReadPageBottomButton(
              text: S.of(context).setting,
              icon: Icons.settings,
              onPressed: () {
                // TODO: 阅读设置
              },
            ),
          ],
        ),
      ),
    );
  }
}
