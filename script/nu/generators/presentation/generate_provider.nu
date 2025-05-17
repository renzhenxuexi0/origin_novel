# 生成Provider代码

export def main [
  feature_name: string           # 特性名称
  capitalized_feature_name: string # 首字母大写的特性名称
  provider_name: string           # 驼峰式命名的特性名
] {
  let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/($feature_name)_entity.dart';
import '../../domain/use_cases/($feature_name)_use_case.dart';
import '../states/($feature_name)_state.dart';

part '($feature_name)_provider.g.dart';

/// 管理($capitalized_feature_name)状态的Provider
@riverpod
class ($capitalized_feature_name) extends _$($capitalized_feature_name) {
  late final _useCase = ref.read\(($provider_name)UseCaseProvider\);

  @override
  ($capitalized_feature_name)State build\(\) {
  // 初始状态
  return const ($capitalized_feature_name)State\(\);
  }

  /// 加载所有($capitalized_feature_name)
  Future<void> loadAll\({bool forceRefresh = false}\) async {
  state = ($capitalized_feature_name)State.loading\(\);
  
  try {
    final data = await _useCase.getAll\(forceRefresh: forceRefresh\);
    state = ($capitalized_feature_name)State\(items: data\);
  } catch \(e\) {
    state = ($capitalized_feature_name)State.error\('加载失败: ${e.toString\(\)}'\);
  }
  }
  
  /// 加载单个($capitalized_feature_name)
  Future<void> loadById\(int id, {bool forceRefresh = false}\) async {
  state = ($capitalized_feature_name)State.loading\(\);
  
  try {
    final data = await _useCase.getById\(id, forceRefresh: forceRefresh\);
    state = ($capitalized_feature_name)State\(selectedItem: data\);
  } catch \(e\) {
      state = ($capitalized_feature_name)State.error\('创建失败: ${e.toString()}'\);
    }
  }

  /// 更新($capitalized_feature_name)
  Future<void> update\(($capitalized_feature_name)Entity entity\) async {
    state = state.copyWith\(isLoading: true\);
    
    try {
      final updated = await _useCase.update\(entity\);
      state = ($capitalized_feature_name)State\(data: updated\);
    } catch \(e\) {
      state = ($capitalized_feature_name)State.error\('更新失败: ${e.toString()}'\);
    }
  }

  /// 删除($capitalized_feature_name)
  Future<void> delete\(int id\) async {
    state = state.copyWith\(isLoading: true\);
    
    try {
      await _useCase.delete\(id\);
      state = const ($capitalized_feature_name)State\(\);
    } catch \(e\) {
      state = ($capitalized_feature_name)State.error\('删除失败: ${e.toString\(\)}'\);
    }
  }
}"
    
    create_file $"lib/features/($feature_name)/presentation/providers/($feature_name)_provider.dart" $content
}
