#!/bin/bash

generate_abstract_local_data_source() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/data/sources/local/${feature_name}_local_data_source.dart" \
    "import 'package:riverpod_annotation/riverpod_annotation.dart';
import '${feature_name}_local_data_source_impl.dart';

part '${feature_name}_local_data_source.g.dart';

abstract class ${capitalized_feature_name}LocalDataSource {  
  // TODO: Add local data source methods  
}

@riverpod
${capitalized_feature_name}LocalDataSource ${feature_name}LocalDataSource(
  Ref ref,
) {
  return ${capitalized_feature_name}LocalDataSourceImpl();
}"
}
