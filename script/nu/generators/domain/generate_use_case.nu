# 生成用例代码

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
    provider_name: string           # 驼峰式命名的特性名
] {
    let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/($feature_name)_repository_impl.dart';
import '../entities/($feature_name)_entity.dart';
import '../repositories/($feature_name)_repository.dart';

part '($feature_name)_use_case.g.dart';

/// 获取($capitalized_feature_name)UseCase的Provider
@riverpod
($capitalized_feature_name)UseCase ($provider_name)UseCase\(Ref ref\) {
  final repository = ref.watch\(($provider_name)RepositoryProvider\);
  return ($capitalized_feature_name)UseCase\(repository\);
}

/// ($capitalized_feature_name)相关的用例
class ($capitalized_feature_name)UseCase {
  final I($capitalized_feature_name)Repository _repository;

  const ($capitalized_feature_name)UseCase\(this._repository\);

  /// 获取($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> get\({bool forceRefresh = false}\) async {
    return _repository.get($capitalized_feature_name)\(forceRefresh: forceRefresh\);
  }

  /// 创建新的($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> create\(($capitalized_feature_name)Entity entity\) async {
    return _repository.create($capitalized_feature_name)\(entity\);
  }

  /// 更新($capitalized_feature_name)
  Future<($capitalized_feature_name)Entity> update\(($capitalized_feature_name)Entity entity\) async {
    return _repository.update($capitalized_feature_name)\(entity\);
  }

  /// 删除($capitalized_feature_name)
  Future<void> delete\(String id\) async {
    return _repository.delete($capitalized_feature_name)\(id\);
  }
}"
    
    create_file $"lib/features/($feature_name)/domain/usecases/($feature_name)_use_case.dart" $content
}
