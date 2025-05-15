#!/bin/bash

generate_page() {
  local feature_name="$1"
  local capitalized_feature_name="$2"
  local provider_name="$3"

  create_file "lib/features/$feature_name/presentation/pages/${feature_name}_page.dart" \
    "import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/${feature_name}_notifier.dart';

class ${capitalized_feature_name}Page extends HookConsumerWidget {
  const ${capitalized_feature_name}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${provider_name}NotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('${capitalized_feature_name}'),
      ),
      body: state.when(
        data: (data) => Center(
          child: Text(data.toString()),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: \$error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}"
}
