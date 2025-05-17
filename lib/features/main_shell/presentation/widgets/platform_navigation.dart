import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/talker/global_talker.dart';
import '../../../../shared/presentation/widgets/platform_widget.dart';

/// 导航项配置
class NavigationItemInfo {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationItemInfo({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

/// 导航适配器配置
class NavigationConfig {
  final StatefulNavigationShell navigationShell;
  final List<NavigationItemInfo> items;
  final String? title;

  const NavigationConfig({
    required this.navigationShell,
    required this.items,
    this.title,
  });
}

/// 导航适配器
class PlatformNavigation extends StatefulWidget {
  final NavigationConfig config;

  const PlatformNavigation(this.config, {super.key});

  @override
  State<PlatformNavigation> createState() => _PlatformNavigationState();
}

class _PlatformNavigationState extends State<PlatformNavigation> {
  final SideMenuController _sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();
    // 确保初始选中项与当前导航索引一致
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sideMenuController.changePage(
        widget.config.navigationShell.currentIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      desktopBuilder: buildDesktop,
      mobileBuilder: buildMobile,
    );
  }

  Widget buildDesktop(BuildContext context) {
    final navigationShell = widget.config.navigationShell;
    final theme = context.theme;

    // 创建侧边菜单项
    final List<SideMenuItem> sideMenuItems = [];
    for (int i = 0; i < widget.config.items.length; i++) {
      final item = widget.config.items[i];
      sideMenuItems.add(
        SideMenuItem(
          title: item.label,
          icon: Icon(item.icon),
          onTap:
              (index, _) => {
                _onNavigate(navigationShell, index),
                _sideMenuController.changePage(index),
              },
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // 侧边菜单
          SideMenu(
            controller: _sideMenuController,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              decoration: BoxDecoration(),
              openSideMenuWidth: 160,
              compactSideMenuWidth: 60,
              // 使用主题颜色
              hoverColor: theme.colorScheme.primaryContainer.withValues(
                alpha: 0.7 * 255,
              ),
              selectedColor: theme.colorScheme.primary,
              selectedIconColor: theme.colorScheme.onPrimary,
              unselectedIconColor: theme.colorScheme.onSurfaceVariant,
              // 使用合适的背景色
              backgroundColor: theme.colorScheme.surfaceContainerLowest,
              // 使用主题文字样式
              selectedTitleTextStyle: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
              unselectedTitleTextStyle: TextStyle(
                color: theme.colorScheme.onSurface,
              ),
              iconSize: 20,
              itemBorderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ), // 使用主题默认圆角
              showTooltip: true,
              showHamburger: true,
              itemHeight: 40.0,
              itemInnerSpacing: 4.0,
              itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              toggleColor: theme.colorScheme.onSurfaceVariant,

              // 可展开项的样式也使用主题颜色
              selectedTitleTextStyleExpandable: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
              unselectedTitleTextStyleExpandable: TextStyle(
                color: theme.colorScheme.onSurface,
              ),
              selectedIconColorExpandable: theme.colorScheme.onPrimary,
              unselectedIconColorExpandable: theme.colorScheme.onSurfaceVariant,
              arrowCollapse: theme.colorScheme.primary.withValues(
                alpha: 0.7 * 255,
              ),
              arrowOpen: theme.colorScheme.secondary,
              iconSizeExpandable: 20.0,
            ),
            items: sideMenuItems,
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('© 2025 Origin Novel'),
            ),
          ),
          // 内容区域
          Expanded(child: navigationShell),
        ],
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    final navigationShell = widget.config.navigationShell;
    final int currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onNavigate(navigationShell, index),
        destinations:
            widget.config.items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: item.label,
                  ),
                )
                .toList(),
      ),
    );
  }

  void _onNavigate(StatefulNavigationShell navigationShell, int index) {
    GlobalTalker.instance.info('导航切换至: $index');
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
