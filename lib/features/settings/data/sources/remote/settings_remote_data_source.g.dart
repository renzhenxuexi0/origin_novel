// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供Settings远程数据源的Provider
@ProviderFor(settingsRemoteDataSource)
const settingsRemoteDataSourceProvider = SettingsRemoteDataSourceProvider._();

/// 提供Settings远程数据源的Provider
final class SettingsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ISettingsRemoteDataSource,
          ISettingsRemoteDataSource
        >
    with $Provider<ISettingsRemoteDataSource> {
  /// 提供Settings远程数据源的Provider
  const SettingsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ISettingsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ISettingsRemoteDataSource create(Ref ref) {
    return settingsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISettingsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ISettingsRemoteDataSource>(value),
    );
  }
}

String _$settingsRemoteDataSourceHash() =>
    r'4adee5d42ad8fe62f8485df7be72a6099fe8168c';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
