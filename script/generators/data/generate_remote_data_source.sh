#!/bin/bash

generate_remote_data_source() {
  local feature_name="$1"
  local capitalized_feature_name="$2"

  create_file "lib/features/$feature_name/data/sources/remote/${feature_name}_remote_data_source_impl.dart" \
    "import 'package:riverpod_annotation/riverpod_annotation.dart';
import '${feature_name}_remote_data_source.dart';
    
part '${feature_name}_remote_data_source_impl.g.dart';

@riverpod
${capitalized_feature_name}RemoteDataSource ${feature_name}RemoteDataSource(
  Ref ref,
) {
  return ${capitalized_feature_name}RemoteDataSourceImpl();
}"

}
