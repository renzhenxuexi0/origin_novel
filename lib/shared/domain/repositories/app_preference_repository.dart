/// 抽象本地数据源接口，处理应用偏好设置相关的本地存储操作
abstract interface class IAppPreferenceRepository {
  T? getValue<T>(PreferenceKey<T> key);
  Future<bool> setValue<T>(PreferenceKey<T> key, T value);
}

/// 偏好设置值类型枚举
enum PreferenceType { bool, int, double, string, stringList, enumType }

/// 枚举值存储辅助类
class EnumPreference<T> {
  final List<T> values;
  final T Function(int index) converter;

  const EnumPreference({required this.values, required this.converter});
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
