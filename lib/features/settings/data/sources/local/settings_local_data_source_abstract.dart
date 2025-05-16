import '../../dto/settings_dto.dart';

/// 抽象本地数据源接口，处理Settings相关的本地存储操作
abstract interface class ISettingsLocalDataSource {
  /// 获取本地存储的Settings
  Future<SettingsDto?> getLocalSettings();

  /// 保存Settings到本地
  Future<void> saveLocalSettings(SettingsDto dto);

  /// 从本地删除Settings
  Future<void> deleteLocalSettings();

  /// 检查本地是否有缓存的Settings
  Future<bool> hasLocalSettingsCache();
}
