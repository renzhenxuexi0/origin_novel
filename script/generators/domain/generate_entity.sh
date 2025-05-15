#!/bin/bash

generate_entity() {
    local feature_name="$1"
    local capitalized_feature_name="$2"

    create_file "lib/features/$feature_name/domain/entities/${feature_name}_entity.dart" \
    "class ${capitalized_feature_name}Entity {
  final String id;

  const ${capitalized_feature_name}Entity({
    required this.id,
  });
  // TODO: Add entity properties and methods
}"
} 