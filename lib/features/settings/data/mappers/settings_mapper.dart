import '../../domain/entities/settings_entity.dart';
import '../dto/settings_dto.dart';

/// 将SettingsDto与SettingsEntity相互转换的映射器
class SettingsMapper {
  /// 将DTO转换为实体
  static SettingsEntity toEntity(SettingsDto dto) {
    return SettingsEntity(
      id: dto.id,
      // TODO: Map other properties
    );
  }

  /// 将实体转换为DTO
  static SettingsDto toDto(SettingsEntity entity) {
    return SettingsDto(
      id: entity.id,
      // TODO: Map other properties
    );
  }
}
