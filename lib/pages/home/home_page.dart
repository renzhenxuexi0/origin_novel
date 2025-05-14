import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:origin_novel/widget/platform/platform_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformNavigation(
      NavigationConfig(
        navigationShell: widget.navigationShell,
        items: [
          NavigationItemInfo(
            label: 'Bookshelf',
            icon: Icons.book,
            selectedIcon: Icons.book_outlined,
          ),
          NavigationItemInfo(
            label: 'Settings',
            icon: Icons.settings,
            selectedIcon: Icons.settings_outlined,
          ),
        ],
      ),
    );
  }
}
