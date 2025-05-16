import '../../domain/entities/settings_entity.dart';

/// SettingsProvider的状态
class SettingsState {
  final SettingsEntity? data;
  final bool isLoading;
  final String? errorMessage;

  const SettingsState({this.data, this.isLoading = false, this.errorMessage});

  // 用于显示加载状态的工厂方法
  factory SettingsState.loading() => const SettingsState(isLoading: true);

  // 用于显示错误状态的工厂方法
  factory SettingsState.error(String message) =>
      SettingsState(errorMessage: message);

  // 创建状态副本的方法
  SettingsState copyWith({
    SettingsEntity? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SettingsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
