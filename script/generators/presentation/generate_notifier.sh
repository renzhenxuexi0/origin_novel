#!/bin/bash

generate_notifier() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/presentation/providers/${feature_name}_notifier.dart" \
    "import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/get_${feature_name}_use_case.dart';

final ${provider_name}NotifierProvider = AsyncNotifierProvider<${capitalized_feature_name}Notifier, ${capitalized_feature_name}Entity>(
  () => ${capitalized_feature_name}Notifier(),
);

class ${capitalized_feature_name}Notifier extends AsyncNotifier<${capitalized_feature_name}Entity> {
  late final Get${capitalized_feature_name}UseCase _useCase;

  @override
  Future<${capitalized_feature_name}Entity> build() async {
    _useCase = ref.read(get${capitalized_feature_name}UseCaseProvider);
    
    // TODO: Implement initial state
    throw UnimplementedError();
  }

  // TODO: Add notifier methods
}"
}
