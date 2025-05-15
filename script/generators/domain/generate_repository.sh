#!/bin/bash

generate_repository() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/domain/repositories/${feature_name}_repository.dart" \
    "import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/${feature_name}_repository_impl.dart';
import '../../data/sources/remote/${feature_name}_remote_data_source.dart';

part '${feature_name}_repository.g.dart';

abstract class ${capitalized_feature_name}Repository {
  // TODO: Add repository methods
}

@riverpod
${capitalized_feature_name}Repository ${feature_name}Repository(
  Ref ref,
) {
  return ${capitalized_feature_name}RepositoryImpl(
    remoteDataSource: ref.watch(${feature_name}RemoteDataSourceProvider),
  );
}"
}
