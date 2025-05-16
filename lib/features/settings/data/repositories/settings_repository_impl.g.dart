// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供SettingsRepository的Provider
@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryProvider._();

/// 提供SettingsRepository的Provider
final class SettingsRepositoryProvider
    extends $FunctionalProvider<ISettingsRepository, ISettingsRepository>
    with $Provider<ISettingsRepository> {
  /// 提供SettingsRepository的Provider
  const SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ISettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ISettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ISettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'eb6a30258692c70763588ad2a9f241d6d6c16c3d';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
