# 生成model代码 (使用freezed)

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
] {
    let content = $"import 'package:freezed_annotation/freezed_annotation.dart';

part '($feature_name)_dto.freezed.dart';
part '($feature_name)_dto.g.dart';

@freezed
sealed class ($capitalized_feature_name)Dto with _$($capitalized_feature_name)Dto {
  const factory ($capitalized_feature_name)Dto\({
    required int id,
    // TODO: Add more DTO properties
  }\) = _($capitalized_feature_name)Dto;

  factory ($capitalized_feature_name)Dto.fromJson\(Map<String, Object?> json\) =>
      _$($capitalized_feature_name)DtoFromJson\(json\);
}"
    
    create_file $"lib/features/($feature_name)/data/dtos/($feature_name)_dto.dart" $content

}
