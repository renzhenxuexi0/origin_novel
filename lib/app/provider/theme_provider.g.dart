// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AppThemeMode)
const appThemeModeProvider = AppThemeModeProvider._();

final class AppThemeModeProvider
    extends $AsyncNotifierProvider<AppThemeMode, ThemeMode> {
  const AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  AppThemeMode create() => AppThemeMode();

  @$internal
  @override
  $AsyncNotifierProviderElement<AppThemeMode, ThemeMode> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);
}

String _$appThemeModeHash() => r'968696ed9ebc719416b1be609ec30e9324b4a51d';

abstract class _$AppThemeMode extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeMode>>,
              AsyncValue<ThemeMode>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
