# 生成Provider代码

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
] {
    let content = $"import '../../domain/entities/($feature_name)_entity.dart';

/// ($capitalized_feature_name)Provider的状态
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
}"
    
    create_file $"lib/features/($feature_name)/presentation/states/($feature_name)_state.dart" $content
}
