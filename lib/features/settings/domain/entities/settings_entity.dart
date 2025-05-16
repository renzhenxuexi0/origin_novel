import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

@freezed
sealed class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required String id,
    // TODO: Add more entity properties
  }) = _SettingsEntity;
}
