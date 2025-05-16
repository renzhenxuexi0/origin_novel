// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookshelf_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookshelfDto {

 String get id;
/// Create a copy of BookshelfDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookshelfDtoCopyWith<BookshelfDto> get copyWith => _$BookshelfDtoCopyWithImpl<BookshelfDto>(this as BookshelfDto, _$identity);

  /// Serializes this BookshelfDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookshelfDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'BookshelfDto(id: $id)';
}


}

/// @nodoc
abstract mixin class $BookshelfDtoCopyWith<$Res>  {
  factory $BookshelfDtoCopyWith(BookshelfDto value, $Res Function(BookshelfDto) _then) = _$BookshelfDtoCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$BookshelfDtoCopyWithImpl<$Res>
    implements $BookshelfDtoCopyWith<$Res> {
  _$BookshelfDtoCopyWithImpl(this._self, this._then);

  final BookshelfDto _self;
  final $Res Function(BookshelfDto) _then;

/// Create a copy of BookshelfDto
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

class _BookshelfDto implements BookshelfDto {
  const _BookshelfDto({required this.id});
  factory _BookshelfDto.fromJson(Map<String, dynamic> json) => _$BookshelfDtoFromJson(json);

@override final  String id;

/// Create a copy of BookshelfDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookshelfDtoCopyWith<_BookshelfDto> get copyWith => __$BookshelfDtoCopyWithImpl<_BookshelfDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookshelfDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookshelfDto&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'BookshelfDto(id: $id)';
}


}

/// @nodoc
abstract mixin class _$BookshelfDtoCopyWith<$Res> implements $BookshelfDtoCopyWith<$Res> {
  factory _$BookshelfDtoCopyWith(_BookshelfDto value, $Res Function(_BookshelfDto) _then) = __$BookshelfDtoCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$BookshelfDtoCopyWithImpl<$Res>
    implements _$BookshelfDtoCopyWith<$Res> {
  __$BookshelfDtoCopyWithImpl(this._self, this._then);

  final _BookshelfDto _self;
  final $Res Function(_BookshelfDto) _then;

/// Create a copy of BookshelfDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_BookshelfDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
