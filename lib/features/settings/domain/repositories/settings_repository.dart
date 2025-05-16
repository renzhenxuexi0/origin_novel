import '../entities/settings_entity.dart';

/// 抽象仓库接口，定义Settings相关的业务操作
abstract interface class ISettingsRepository {
  /// 获取Settings，可选是否强制刷新
  Future<SettingsEntity> getSettings({bool forceRefresh = false});

  /// 创建新的Settings
  Future<SettingsEntity> createSettings(SettingsEntity entity);

  /// 更新Settings
  Future<SettingsEntity> updateSettings(SettingsEntity entity);

  /// 删除Settings
  Future<void> deleteSettings(String id);
}
