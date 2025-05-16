import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/preference/shared_preference_provider.dart';
import '../../domain/repositories/app_preference_repository.dart';

part 'app_preference_repository_impl.g.dart';

/// 提供Bookshelf本地数据源的Provider
@riverpod
Future<IAppPreferenceRepository> appPreferenceRepository(Ref ref) async {
  final prefs = await ref.watch(sharedPreferenceProvider.future);
  return AppPreferenceRepository(prefs);
}

/// 本地数据源实现，处理Bookshelf相关的本地存储操作
class AppPreferenceRepository implements IAppPreferenceRepository {
  AppPreferenceRepository(this._prefs);
  final SharedPreferences _prefs;

  @override
  T? getValue<T>(PreferenceKey<T> key) {
    final type = key.type;

    if (!_prefs.containsKey(key.name)) return key.defaultValue;

    return switch (type) {
      PreferenceType.bool => _prefs.getBool(key.name) as T?,
      PreferenceType.int => _prefs.getInt(key.name) as T?,
      PreferenceType.double => _prefs.getDouble(key.name) as T?,
      PreferenceType.string => _prefs.getString(key.name) as T?,
      PreferenceType.stringList => _prefs.getStringList(key.name) as T?,
      PreferenceType.enumType =>
        key.converter != null
            ? key.converter!(_prefs.getInt(key.name) ?? 0) as T?
            : key.defaultValue,
    };
  }

  @override
  Future<bool> setValue<T>(PreferenceKey<T> key, T value) {
    final type = key.type;

    return switch (type) {
      PreferenceType.bool => _prefs.setBool(key.name, value as bool),
      PreferenceType.int => _prefs.setInt(key.name, value as int),
      PreferenceType.double => _prefs.setDouble(key.name, value as double),
      PreferenceType.string => _prefs.setString(key.name, value as String),
      PreferenceType.stringList => _prefs.setStringList(
        key.name,
        value as List<String>,
      ),
      PreferenceType.enumType => _prefs.setInt(
        key.name,
        (value as dynamic).index as int,
      ),
    };
  }
}
