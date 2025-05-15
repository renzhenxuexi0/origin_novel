#!/bin/bash

generate_repository_impl() {
  local feature_name="$1"
  local capitalized_feature_name="$2"

  create_file "lib/features/$feature_name/data/repositories/${feature_name}_repository_impl.dart" \
    "import '../../domain/repositories/${feature_name}_repository.dart';
import '../sources/remote/${feature_name}_remote_data_source.dart';

class ${capitalized_feature_name}RepositoryImpl implements ${capitalized_feature_name}Repository {
  final ${capitalized_feature_name}RemoteDataSource remoteDataSource;

  const ${capitalized_feature_name}RepositoryImpl({
    required this.remoteDataSource,
  });

  // TODO: Implement repository methods
}"
}
