#!/bin/bash

generate_mapper() {
  local feature_name="$1"
  local capitalized_feature_name="$2"

  create_file "lib/features/$feature_name/data/mappers/${feature_name}_mapper.dart" \
    "import '../../domain/entities/${feature_name}_entity.dart';
import '../dto/${feature_name}_dto.dart';

class ${capitalized_feature_name}Mapper {
  static ${capitalized_feature_name}Entity fromJson(Map<String, dynamic> json) {
    final dto = ${capitalized_feature_name}Dto.fromJson(json);
    return fromDto(dto);
  }

  static Map<String, dynamic> toJson(${capitalized_feature_name}Entity entity) {
    final dto = toDto(entity);
    return dto.toJson();
  }

  static ${capitalized_feature_name}Entity fromDto(${capitalized_feature_name}Dto dto) {
    return ${capitalized_feature_name}Entity(
      id: dto.id,
      // TODO: Add other mapping from DTO to entity
    );
  }

  static ${capitalized_feature_name}Dto toDto(${capitalized_feature_name}Entity entity) {
    return ${capitalized_feature_name}Dto(
      id: entity.id,
      // TODO: Add other mapping from entity to DTO
    );
  }
}"
}
