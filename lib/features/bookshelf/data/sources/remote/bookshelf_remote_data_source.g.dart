// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供Bookshelf远程数据源的Provider
@ProviderFor(bookshelfRemoteDataSource)
const bookshelfRemoteDataSourceProvider = BookshelfRemoteDataSourceProvider._();

/// 提供Bookshelf远程数据源的Provider
final class BookshelfRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IBookshelfRemoteDataSource,
          IBookshelfRemoteDataSource
        >
    with $Provider<IBookshelfRemoteDataSource> {
  /// 提供Bookshelf远程数据源的Provider
  const BookshelfRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookshelfRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookshelfRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IBookshelfRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IBookshelfRemoteDataSource create(Ref ref) {
    return bookshelfRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IBookshelfRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<IBookshelfRemoteDataSource>(value),
    );
  }
}

String _$bookshelfRemoteDataSourceHash() =>
    r'910d99f32c2bf1d0d9ed6e290856b73afaae7ae5';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
