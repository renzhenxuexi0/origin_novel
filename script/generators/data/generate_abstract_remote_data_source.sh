#!/bin/bash

generate_abstract_remote_data_source() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/data/sources/remote/${feature_name}_remote_data_source.dart" \
    "import 'package:riverpod_annotation/riverpod_annotation.dart';
import '${feature_name}_remote_data_source_impl.dart';

part '${feature_name}_remote_data_source.g.dart';

abstract class ${capitalized_feature_name}RemoteDataSource {
  // TODO: Add remote data source methods
}

@riverpod
${capitalized_feature_name}RemoteDataSource ${feature_name}RemoteDataSource(
  Ref ref,
) {
  return ${capitalized_feature_name}RemoteDataSourceImpl();
}"
}
