// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AppLanguage)
const appLanguageProvider = AppLanguageProvider._();

final class AppLanguageProvider
    extends $AsyncNotifierProvider<AppLanguage, AppLocale> {
  const AppLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLanguageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLanguageHash();

  @$internal
  @override
  AppLanguage create() => AppLanguage();

  @$internal
  @override
  $AsyncNotifierProviderElement<AppLanguage, AppLocale> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);
}

String _$appLanguageHash() => r'bca6d99967ed84d272fe358c914751599c618fa1';

abstract class _$AppLanguage extends $AsyncNotifier<AppLocale> {
  FutureOr<AppLocale> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppLocale>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppLocale>>,
              AsyncValue<AppLocale>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
