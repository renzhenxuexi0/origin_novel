// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preference_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供Bookshelf本地数据源的Provider
@ProviderFor(appPreferenceRepository)
const appPreferenceRepositoryProvider = AppPreferenceRepositoryProvider._();

/// 提供Bookshelf本地数据源的Provider
final class AppPreferenceRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IAppPreferenceRepository>,
          FutureOr<IAppPreferenceRepository>
        >
    with
        $FutureModifier<IAppPreferenceRepository>,
        $FutureProvider<IAppPreferenceRepository> {
  /// 提供Bookshelf本地数据源的Provider
  const AppPreferenceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPreferenceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPreferenceRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<IAppPreferenceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IAppPreferenceRepository> create(Ref ref) {
    return appPreferenceRepository(ref);
  }
}

String _$appPreferenceRepositoryHash() =>
    r'dc01b755ec83e2901e36196bd1d4a9df9400f8d4';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
