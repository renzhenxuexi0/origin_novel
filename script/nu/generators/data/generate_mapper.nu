# 生成Mapper代码

export def main [
    feature_name: string          # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
] {
    let content = $"import '../../domain/entities/($feature_name)_entity.dart';
import '../dto/($feature_name)_dto.dart';

/// 将($capitalized_feature_name)Dto与($capitalized_feature_name)Entity相互转换的映射器
class ($capitalized_feature_name)Mapper {
  /// 将DTO转换为实体
  static ($capitalized_feature_name)Entity toEntity\(($capitalized_feature_name)Dto dto\) {
    return ($capitalized_feature_name)Entity\(
      id: dto.id,
      // TODO: Map other properties
    \);
  }

  /// 将实体转换为DTO
  static ($capitalized_feature_name)Dto toDto\(($capitalized_feature_name)Entity entity\) {
    return ($capitalized_feature_name)Dto\(
      id: entity.id,
      // TODO: Map other properties
    \);
  }
}"
    
    create_file $"lib/features/($feature_name)/data/mappers/($feature_name)_mapper.dart" $content
}
