import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/localization/translations.g.dart';
import '../../data/repositories/app_preference_repository_impl.dart';
import '../../domain/repositories/app_preference_repository.dart';

part 'app_language_provider.g.dart';

@riverpod
class AppLanguage extends _$AppLanguage {
  static final _key = PreferenceKey.enum_(
    'app_language',
    defaultValue: AppLocale.zhCn,
    converter: (index) => AppLocale.values[index],
  );

  late IAppPreferenceRepository _appPreferenceRepository;

  @override
  Future<AppLocale> build() async {
    _appPreferenceRepository = await ref.watch(
      appPreferenceRepositoryProvider.future,
    );
    return _loadLanguage();
  }

  AppLocale _loadLanguage() {
    final language = _appPreferenceRepository.getValue(_key) ?? AppLocale.zhCn;
    LocaleSettings.setLocale(language);
    return language;
  }

  Future<void> setLanguage(AppLocale language) async {
    await _appPreferenceRepository.setValue(_key, language);
    LocaleSettings.setLocale(language);
    state = AsyncValue.data(language);
  }
}
