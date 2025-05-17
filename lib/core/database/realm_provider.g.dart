// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供 Realm 实例的 Provider
@ProviderFor(realm)
const realmProvider = RealmProvider._();

/// 提供 Realm 实例的 Provider
final class RealmProvider
    extends $FunctionalProvider<AsyncValue<Realm>, FutureOr<Realm>>
    with $FutureModifier<Realm>, $FutureProvider<Realm> {
  /// 提供 Realm 实例的 Provider
  const RealmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'realmProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$realmHash();

  @$internal
  @override
  $FutureProviderElement<Realm> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Realm> create(Ref ref) {
    return realm(ref);
  }
}

String _$realmHash() => r'f7dcda48a5ec215fb8aba24cf551655edd97fb3d';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
