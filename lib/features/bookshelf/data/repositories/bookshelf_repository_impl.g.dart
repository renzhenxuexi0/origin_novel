// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供BookshelfRepository的Provider
@ProviderFor(bookshelfRepository)
const bookshelfRepositoryProvider = BookshelfRepositoryProvider._();

/// 提供BookshelfRepository的Provider
final class BookshelfRepositoryProvider
    extends $FunctionalProvider<IBookshelfRepository, IBookshelfRepository>
    with $Provider<IBookshelfRepository> {
  /// 提供BookshelfRepository的Provider
  const BookshelfRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookshelfRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookshelfRepositoryHash();

  @$internal
  @override
  $ProviderElement<IBookshelfRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IBookshelfRepository create(Ref ref) {
    return bookshelfRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IBookshelfRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<IBookshelfRepository>(value),
    );
  }
}

String _$bookshelfRepositoryHash() =>
    r'17d4af3d4a86a69e3e069bbd5153234c0061868b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
