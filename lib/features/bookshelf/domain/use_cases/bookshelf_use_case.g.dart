// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 获取BookshelfUseCase的Provider
@ProviderFor(bookshelfUseCase)
const bookshelfUseCaseProvider = BookshelfUseCaseProvider._();

/// 获取BookshelfUseCase的Provider
final class BookshelfUseCaseProvider
    extends $FunctionalProvider<BookshelfUseCase, BookshelfUseCase>
    with $Provider<BookshelfUseCase> {
  /// 获取BookshelfUseCase的Provider
  const BookshelfUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookshelfUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookshelfUseCaseHash();

  @$internal
  @override
  $ProviderElement<BookshelfUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookshelfUseCase create(Ref ref) {
    return bookshelfUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookshelfUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<BookshelfUseCase>(value),
    );
  }
}

String _$bookshelfUseCaseHash() => r'207f889d79b693ac3f7c1366dfa0c5052d12a269';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
