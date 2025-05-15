#!/bin/bash

generate_dto() {
    local feature_name="$1"
    local capitalized_feature_name="$2"

    create_file "lib/features/$feature_name/data/dto/${feature_name}_dto.dart" \
    "class ${capitalized_feature_name}Dto {
  final String id;
  // TODO: Add more DTO properties

  const ${capitalized_feature_name}Dto({
    required this.id,
  });

  factory ${capitalized_feature_name}Dto.fromJson(Map<String, dynamic> json) {
    return ${capitalized_feature_name}Dto(
      id: json['id'] as String,
      // TODO: Map other properties from json
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // TODO: Map other properties to json
    };
  }

  @override
  String toString() {
    return '${capitalized_feature_name}Dto(id: \$id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ${capitalized_feature_name}Dto && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}"
} 