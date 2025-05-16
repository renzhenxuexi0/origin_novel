// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsDto {

 String get id;
/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDtoCopyWith<SettingsDto> get copyWith => _$SettingsDtoCopyWithImpl<SettingsDto>(this as SettingsDto, _$identity);

  /// Serializes this SettingsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SettingsDto(id: $id)';
}


}

/// @nodoc
abstract mixin class $SettingsDtoCopyWith<$Res>  {
  factory $SettingsDtoCopyWith(SettingsDto value, $Res Function(SettingsDto) _then) = _$SettingsDtoCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SettingsDtoCopyWithImpl<$Res>
    implements $SettingsDtoCopyWith<$Res> {
  _$SettingsDtoCopyWithImpl(this._self, this._then);

  final SettingsDto _self;
  final $Res Function(SettingsDto) _then;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SettingsDto implements SettingsDto {
  const _SettingsDto({required this.id});
  factory _SettingsDto.fromJson(Map<String, dynamic> json) => _$SettingsDtoFromJson(json);

@override final  String id;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDtoCopyWith<_SettingsDto> get copyWith => __$SettingsDtoCopyWithImpl<_SettingsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SettingsDto(id: $id)';
}


}

/// @nodoc
abstract mixin class _$SettingsDtoCopyWith<$Res> implements $SettingsDtoCopyWith<$Res> {
  factory _$SettingsDtoCopyWith(_SettingsDto value, $Res Function(_SettingsDto) _then) = __$SettingsDtoCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$SettingsDtoCopyWithImpl<$Res>
    implements _$SettingsDtoCopyWith<$Res> {
  __$SettingsDtoCopyWithImpl(this._self, this._then);

  final _SettingsDto _self;
  final $Res Function(_SettingsDto) _then;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_SettingsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
