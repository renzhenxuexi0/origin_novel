import '../../domain/entities/settings_entity.dart';
import '../models/settings_model.dart';

/// 将Settings的不同数据表示形式(DTO、Model、Entity)相互转换的映射器
class SettingsMapper {
  /// 将Model转换为实体
  static SettingsEntity modelToEntity(SettingsModel model) {
    return SettingsEntity(
      id: model.id,
      // TODO: Map other properties
    );
  }

  /// 将实体转换为Model
  static SettingsModel entityToModel(SettingsEntity entity) {
    return SettingsModel(
      entity.id,
      // TODO: Map other properties
    );
  }
}
