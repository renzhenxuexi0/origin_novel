import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realm_provider.g.dart';

/// 提供 Realm 实例的 Provider
@Riverpod(keepAlive: true)
Future<Realm> realm(Ref ref) async {
  // 配置 Realm，包含所有模型的 Schema
  final config = Configuration.local([]);

  // 初始化并返回 Realm 实例
  final realm = Realm(config);

  // 关闭 realm 当 provider 被处置时
  ref.onDispose(() {
    realm.close();
  });

  return realm;
}
