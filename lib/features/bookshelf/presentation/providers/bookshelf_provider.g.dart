// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// 管理Bookshelf状态的Provider
@ProviderFor(Bookshelf)
const bookshelfProvider = BookshelfProvider._();

/// 管理Bookshelf状态的Provider
final class BookshelfProvider
    extends $NotifierProvider<Bookshelf, BookshelfState> {
  /// 管理Bookshelf状态的Provider
  const BookshelfProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookshelfProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookshelfHash();

  @$internal
  @override
  Bookshelf create() => Bookshelf();

  @$internal
  @override
  $NotifierProviderElement<Bookshelf, BookshelfState> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookshelfState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<BookshelfState>(value),
    );
  }
}

String _$bookshelfHash() => r'e7a25a28496f1c471cf29fcb82eb84f14d147ab3';

abstract class _$Bookshelf extends $Notifier<BookshelfState> {
  BookshelfState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<BookshelfState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BookshelfState>,
              BookshelfState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
