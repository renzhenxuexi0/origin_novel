#!/bin/bash

generate_remote_data_source() {
  local feature_name="$1"
  local capitalized_feature_name="$2"

  create_file "lib/features/$feature_name/data/sources/remote/${feature_name}_remote_data_source_impl.dart" \
    "import '${feature_name}_remote_data_source.dart';

    class ${capitalized_feature_name}RemoteDataSourceImpl implements ${capitalized_feature_name}RemoteDataSource {
  // TODO: Implement remote data source methods
}"
}
