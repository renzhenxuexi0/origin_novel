import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:origin_novel/app/talker/global_talker.dart';

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
class PlatformNavigation extends PlatformWidget {
  final NavigationConfig config;

  PlatformNavigation(this.config, {super.key});

  @override
  Widget buildDesktop(BuildContext context) {
    final navigationShell = config.navigationShell;
    final int currentIndex = navigationShell.currentIndex;

    return fluent.NavigationView(
      appBar: fluent.NavigationAppBar(
        title: Text(config.title ?? ''),
        automaticallyImplyLeading: false,
      ),
      pane: fluent.NavigationPane(
        selected: currentIndex,
        onChanged: (index) => _onNavigate(navigationShell, index),
        displayMode: fluent.PaneDisplayMode.compact,
        items:
            config.items.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return fluent.PaneItem(
                icon: Icon(
                  currentIndex == index ? item.selectedIcon : item.icon,
                ),
                title: Text(item.label),
              );
            }).toList(),
      ),
      content: fluent.NavigationBody(
        index: currentIndex,
        children: [navigationShell],
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final navigationShell = config.navigationShell;
    final int currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onNavigate(navigationShell, index),
        destinations:
            config.items
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
