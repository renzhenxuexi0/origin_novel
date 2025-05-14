import 'package:shared_preferences/shared_preferences.dart';

/// 偏好设置值类型枚举
enum PreferenceType { bool, int, double, string, stringList, enumType }

/// 枚举值存储辅助类
class EnumPreference<T> {
  final List<T> values;
  final T Function(int index) converter;

  const EnumPreference({required this.values, required this.converter});
}

/// 应用偏好设置管理类
class AppPreferences {
  static late SharedPreferences _prefs;

  /// 初始化SharedPreferences实例
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 获取所有存储的键
  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// 清除所有偏好设置
  static Future<bool> clear() {
    return _prefs.clear();
  }

  /// 读取值，提供类型安全的API
  static T? getValue<T>(PreferenceKey<T> key) {
    final type = key.type;

    if (!_prefs.containsKey(key.name)) return key.defaultValue;

    return switch (type) {
      PreferenceType.bool => _prefs.getBool(key.name) as T?,
      PreferenceType.int => _prefs.getInt(key.name) as T?,
      PreferenceType.double => _prefs.getDouble(key.name) as T?,
      PreferenceType.string => _prefs.getString(key.name) as T?,
      PreferenceType.stringList => _prefs.getStringList(key.name) as T?,
      PreferenceType.enumType => key.converter != null
          ? key.converter!(_prefs.getInt(key.name) ?? 0) as T?
          : key.defaultValue,
    };
  }

  /// 保存值，提供类型安全的API
  static Future<bool> setValue<T>(PreferenceKey<T> key, T value) {
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

/// 偏好设置键定义类
class PreferenceKey<T> {
  final String name;
  final PreferenceType type;
  final T? defaultValue;
  final T Function(int)? converter;

  const PreferenceKey._({
    required this.name,
    required this.type,
    this.defaultValue,
    this.converter,
  });

  /// 创建布尔类型的偏好设置键
  factory PreferenceKey.bool(String name, {bool defaultValue = false}) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.bool,
      defaultValue: defaultValue as T,
    );
  }

  /// 创建整数类型的偏好设置键
  factory PreferenceKey.int(String name, {int defaultValue = 0}) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.int,
      defaultValue: defaultValue as T,
    );
  }

  /// 创建双精度类型的偏好设置键
  factory PreferenceKey.double(String name, {double defaultValue = 0.0}) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.double,
      defaultValue: defaultValue as T,
    );
  }

  /// 创建字符串类型的偏好设置键
  factory PreferenceKey.string(String name, {String? defaultValue}) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.string,
      defaultValue: defaultValue as T,
    );
  }

  /// 创建字符串列表类型的偏好设置键
  factory PreferenceKey.stringList(String name, {List<String>? defaultValue}) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.stringList,
      defaultValue: defaultValue as T,
    );
  }

  /// 创建枚举类型的偏好设置键
  factory PreferenceKey.enum_(
    String name, {
    required T defaultValue,
    required T Function(int) converter,
  }) {
    return PreferenceKey._(
      name: name,
      type: PreferenceType.enumType,
      defaultValue: defaultValue,
      converter: converter,
    );
  }
}
