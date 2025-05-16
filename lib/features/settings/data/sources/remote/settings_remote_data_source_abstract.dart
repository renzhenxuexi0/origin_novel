import '../../dto/settings_dto.dart';

/// 抽象远程数据源接口，处理Settings相关的远程操作
abstract interface class ISettingsRemoteDataSource {
  /// 获取Settings
  Future<SettingsDto> getSettings();

  /// 创建新的Settings
  Future<SettingsDto> createSettings(SettingsDto dto);

  /// 更新Settings
  Future<SettingsDto> updateSettings(SettingsDto dto);

  /// 删除Settings
  Future<void> deleteSettings(String id);
}
