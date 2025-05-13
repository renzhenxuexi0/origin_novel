import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:origin_novel/app/constant/instances.dart';
import 'package:origin_novel/app/router/routes/routes.dart';
import 'package:origin_novel/app/talker/global_talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final GoRouter router = GoRouter(
    navigatorKey: Instances.rootNavigatorKey,
    initialLocation: BookshelfRoute().location,
    // 开启日志
    debugLogDiagnostics: kDebugMode,
    // 重定向
    redirect: (BuildContext context, GoRouterState state) async {
      return null;
    },
    // 错误页面 404
    errorBuilder: null,
    // 路由导航监测 监听路由行为，例如 push、pop 或路由替换（replace）
    // 可以创建NavigatorObserver 的子类来实现自定义的路由导航监测
    observers: <NavigatorObserver>[
      TalkerRouteObserver(GlobalTalker.instance.talker),
    ],
    routes: $appRoutes,
  );

  ref.onDispose(router.dispose);

  return router;
}
