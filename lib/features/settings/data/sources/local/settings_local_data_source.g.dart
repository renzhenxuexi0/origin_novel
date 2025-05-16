// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供Settings本地数据源的Provider
@ProviderFor(settingsLocalDataSource)
const settingsLocalDataSourceProvider = SettingsLocalDataSourceProvider._();

/// 提供Settings本地数据源的Provider
final class SettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<ISettingsLocalDataSource, ISettingsLocalDataSource>
    with $Provider<ISettingsLocalDataSource> {
  /// 提供Settings本地数据源的Provider
  const SettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ISettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ISettingsLocalDataSource create(Ref ref) {
    return settingsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISettingsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ISettingsLocalDataSource>(value),
    );
  }
}

String _$settingsLocalDataSourceHash() =>
    r'6f0344f08e30bd44bff96dccd3bf013bb4ac365d';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
