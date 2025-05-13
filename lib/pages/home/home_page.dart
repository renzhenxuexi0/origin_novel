import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:origin_novel/app/talker/global_talker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // 获取当前选中的导航索引
    final int currentIndex = widget.navigationShell.currentIndex;
    GlobalTalker.instance.debug('当前导航索引: $currentIndex');

    return Scaffold(
      // 显示当前分支路由对应的内容
      body: widget.navigationShell,

      // 底部导航栏
      bottomNavigationBar: NavigationBar(
        // 设置当前选中的索引
        selectedIndex: currentIndex,

        // 处理导航项点击
        onDestinationSelected: (int index) {
          GlobalTalker.instance.info('导航切换至: $index');
          // 使用 goBranch 方法切换到对应的分支
          widget.navigationShell.goBranch(
            index,
            // 使用initialLocation确保回到分支的初始位置
            initialLocation: index == currentIndex,
          );
        },

        // 导航项
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: '书架',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
