import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../common_widgets/platform/platform_navigation.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
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
