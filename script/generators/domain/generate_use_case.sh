#!/bin/bash

generate_use_case() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/domain/usecases/get_${feature_name}_use_case.dart" \
    "import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/${feature_name}_repository.dart';

part 'get_${feature_name}_use_case.g.dart';

class Get${capitalized_feature_name}UseCase {
  final ${capitalized_feature_name}Repository repository;

  Get${capitalized_feature_name}UseCase(this.repository);

  // TODO: Implement use case methods
}

@riverpod
Get${capitalized_feature_name}UseCase get${capitalized_feature_name}UseCase(
  Ref ref,
) {
  return Get${capitalized_feature_name}UseCase(
    ref.watch(${provider_name}RepositoryProvider),
  );
}"
}
