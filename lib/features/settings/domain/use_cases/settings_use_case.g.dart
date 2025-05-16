// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 获取SettingsUseCase的Provider
@ProviderFor(settingsUseCase)
const settingsUseCaseProvider = SettingsUseCaseProvider._();

/// 获取SettingsUseCase的Provider
final class SettingsUseCaseProvider
    extends $FunctionalProvider<SettingsUseCase, SettingsUseCase>
    with $Provider<SettingsUseCase> {
  /// 获取SettingsUseCase的Provider
  const SettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SettingsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsUseCase create(Ref ref) {
    return settingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<SettingsUseCase>(value),
    );
  }
}

String _$settingsUseCaseHash() => r'8d1d43473e5f277425b652874e2383f0d8a96bad';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
