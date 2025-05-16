import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_dto.freezed.dart';
part 'settings_dto.g.dart';

@freezed
sealed class SettingsDto with _$SettingsDto {
  const factory SettingsDto({
    required String id,
    // TODO: Add more DTO properties
  }) = _SettingsDto;

  factory SettingsDto.fromJson(Map<String, Object?> json) =>
      _$SettingsDtoFromJson(json);
}
