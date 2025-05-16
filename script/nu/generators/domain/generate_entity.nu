# 生成实体代码 (使用freezed)

export def main [
  feature_name: string           # 特性名称
  capitalized_feature_name: string # 首字母大写的特性名称
] {
  let content = $"import 'package:freezed_annotation/freezed_annotation.dart';

part '($feature_name)_entity.freezed.dart';

@freezed
sealed class ($capitalized_feature_name)Entity with _$($capitalized_feature_name)Entity {
  const factory ($capitalized_feature_name)Entity\({
  required String id,
  // TODO: Add more entity properties
  }\) = _($capitalized_feature_name)Entity;
}"
  
  create_file $"lib/features/($feature_name)/domain/entities/($feature_name)_entity.dart" $content
}
