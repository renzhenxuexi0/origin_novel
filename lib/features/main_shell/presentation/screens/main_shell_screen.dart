import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/translations.g.dart';
import '../widgets/platform_navigation.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  @override
  Widget build(BuildContext context) {
    final t = context.t;
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
            label: t.settings.title,
            icon: Icons.settings,
            selectedIcon: Icons.settings_outlined,
          ),
        ],
      ),
    );
  }
}
