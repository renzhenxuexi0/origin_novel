part of 'routes.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<BookshelfRoute>(path: '/bookshelf'),
      ],
    ),
    TypedStatefulShellBranch<SettingShellBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(path: '/settings'),
      ],
    ),
  ],
)
@immutable
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey =
      Instances.shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => HomePage(navigationShell: navigationShell);
}

@immutable
class HomeShellBranch extends StatefulShellBranchData {
  const HomeShellBranch();
}

@immutable
class SettingShellBranch extends StatefulShellBranchData {
  const SettingShellBranch();
}

/// 书架的页面
@immutable
class BookshelfRoute extends GoRouteData {
  const BookshelfRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BookshelfPage();
}

/// 设置的页面
@immutable
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}
