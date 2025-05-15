#!/bin/bash

generate_local_data_source() {
  local feature_name="$1"
  local capitalized_feature_name="$2"

  create_file "lib/features/$feature_name/data/sources/local/${feature_name}_local_data_source_impl.dart" \
    "import '${feature_name}_local_data_source.dart';

class ${capitalized_feature_name}LocalDataSourceImpl implements ${capitalized_feature_name}LocalDataSource {
  // TODO: Implement local data source methods
}"
}
