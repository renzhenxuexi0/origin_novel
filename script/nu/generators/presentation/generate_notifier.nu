# 生成Notifier/Provider代码

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
    provider_name: string           # 驼峰式命名的特性名
] {
    let content = $"import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/($feature_name)_entity.dart';
import '../../domain/usecases/($feature_name)_use_case.dart';

part '($feature_name)_notifier.g.dart';

/// ($capitalized_feature_name)Notifier的状态
class ($capitalized_feature_name)State {
  final ($capitalized_feature_name)Entity? data;
  final bool isLoading;
  final String? errorMessage;

  const ($capitalized_feature_name)State\({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  }\);

  // 用于显示加载状态的工厂方法
  factory ($capitalized_feature_name)State.loading\(\) => const ($capitalized_feature_name)State\(isLoading: true\);

  // 用于显示错误状态的工厂方法
  factory ($capitalized_feature_name)State.error\(String message\) => 
      ($capitalized_feature_name)State\(errorMessage: message\);

  // 创建状态副本的方法
  ($capitalized_feature_name)State copyWith\({
    ($capitalized_feature_name)Entity? data,
    bool? isLoading,
    String? errorMessage,
  }\) {
    return ($capitalized_feature_name)State\(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    \);
  }
}

/// 管理($capitalized_feature_name)状态的Notifier
@riverpod
class ($capitalized_feature_name)Notifier extends _\$($capitalized_feature_name)Notifier {
  late final _useCase = ref.read\(($provider_name)UseCaseProvider\);

  @override
  ($capitalized_feature_name)State build\(\) {
    // 初始状态
    return const ($capitalized_feature_name)State\(\);
  }

  /// 加载($capitalized_feature_name)
  Future<void> load\({bool forceRefresh = false}\) async {
    state = ($capitalized_feature_name)State.loading\(\);
    
    try {
      final data = await _useCase.get\(forceRefresh: forceRefresh\);
      state = ($capitalized_feature_name)State\(data: data\);
    } catch \(e\) {
      state = ($capitalized_feature_name)State.error\('加载失败: ${e.toString\(\)}'\);
    }
  }

  /// 创建新的($capitalized_feature_name)
  Future<void> create\(($capitalized_feature_name)Entity entity\) async {
    state = state.copyWith\(isLoading: true\);
    
    try {
      final created = await _useCase.create\(entity\);
      state = ($capitalized_feature_name)State\(data: created\);
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
  Future<void> delete\(String id\) async {
    state = state.copyWith\(isLoading: true\);
    
    try {
      await _useCase.delete\(id\);
      state = const ($capitalized_feature_name)State\(\);
    } catch \(e\) {
      state = ($capitalized_feature_name)State.error\('删除失败: ${e.toString\(\)}'\);
    }
  }
}"
    
    create_file $"lib/features/($feature_name)/presentation/providers/($feature_name)_notifier.dart" $content
}
