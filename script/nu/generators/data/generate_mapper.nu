# 生成Mapper代码

export def main [
    feature_name: string          # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
] {    let content = $"import '../../domain/entities/($feature_name)_entity.dart';
import '../dtos/($feature_name)_dto.dart';
import '../models/($feature_name)_model.dart';

/// 将($capitalized_feature_name)的不同数据表示形式\(DTO、Model、Entity\)相互转换的映射器
class ($capitalized_feature_name)Mapper {
  /// 将DTO转换为实体
  static ($capitalized_feature_name)Entity dtoToEntity\(($capitalized_feature_name)Dto dto\) {
    return ($capitalized_feature_name)Entity\(
      id: dto.id,
      // TODO: Map other properties
    \);
  }

  /// 将实体转换为DTO
  static ($capitalized_feature_name)Dto entityToDto\(($capitalized_feature_name)Entity entity\) {
    return ($capitalized_feature_name)Dto\(
      id: entity.id,
      // TODO: Map other properties
    \);
  }
  
  /// 将Model转换为实体
  static ($capitalized_feature_name)Entity modelToEntity\(($capitalized_feature_name)Model model\) {
    return ($capitalized_feature_name)Entity\(
      id: model.id,
      // TODO: Map other properties
    \);
  }
  
  /// 将实体转换为Model
  static ($capitalized_feature_name)Model entityToModel\(($capitalized_feature_name)Entity entity\) {
    return ($capitalized_feature_name)Model\(
      entity.id,
      // TODO: Map other properties
    \);
  }
  
  /// 将DTO转换为Model
  static ($capitalized_feature_name)Model dtoToModel\(($capitalized_feature_name)Dto dto\) {
    return ($capitalized_feature_name)Model\(
      dto.id,
      // TODO: Map other properties
    \);
  }
  
  /// 将Model转换为DTO
  static ($capitalized_feature_name)Dto modelToDto\(($capitalized_feature_name)Model model\) {
    return ($capitalized_feature_name)Dto\(
      id: model.id,
      // TODO: Map other properties
    \);
  }
}"
    
    create_file $"lib/features/($feature_name)/data/mappers/($feature_name)_mapper.dart" $content
}
