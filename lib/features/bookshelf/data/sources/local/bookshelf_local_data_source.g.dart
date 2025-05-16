// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 提供Bookshelf本地数据源的Provider
@ProviderFor(bookshelfLocalDataSource)
const bookshelfLocalDataSourceProvider = BookshelfLocalDataSourceProvider._();

/// 提供Bookshelf本地数据源的Provider
final class BookshelfLocalDataSourceProvider
    extends
        $FunctionalProvider<
          IBookshelfLocalDataSource,
          IBookshelfLocalDataSource
        >
    with $Provider<IBookshelfLocalDataSource> {
  /// 提供Bookshelf本地数据源的Provider
  const BookshelfLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookshelfLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookshelfLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<IBookshelfLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IBookshelfLocalDataSource create(Ref ref) {
    return bookshelfLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IBookshelfLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<IBookshelfLocalDataSource>(value),
    );
  }
}

String _$bookshelfLocalDataSourceHash() =>
    r'86b7c7f0748e926a5859118196754cd33666ed04';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
