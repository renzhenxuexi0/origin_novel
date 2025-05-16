// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookshelf_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookshelfEntity {

 String get id;
/// Create a copy of BookshelfEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookshelfEntityCopyWith<BookshelfEntity> get copyWith => _$BookshelfEntityCopyWithImpl<BookshelfEntity>(this as BookshelfEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookshelfEntity&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'BookshelfEntity(id: $id)';
}


}

/// @nodoc
abstract mixin class $BookshelfEntityCopyWith<$Res>  {
  factory $BookshelfEntityCopyWith(BookshelfEntity value, $Res Function(BookshelfEntity) _then) = _$BookshelfEntityCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$BookshelfEntityCopyWithImpl<$Res>
    implements $BookshelfEntityCopyWith<$Res> {
  _$BookshelfEntityCopyWithImpl(this._self, this._then);

  final BookshelfEntity _self;
  final $Res Function(BookshelfEntity) _then;

/// Create a copy of BookshelfEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _BookshelfEntity implements BookshelfEntity {
  const _BookshelfEntity({required this.id});
  

@override final  String id;

/// Create a copy of BookshelfEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookshelfEntityCopyWith<_BookshelfEntity> get copyWith => __$BookshelfEntityCopyWithImpl<_BookshelfEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookshelfEntity&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'BookshelfEntity(id: $id)';
}


}

/// @nodoc
abstract mixin class _$BookshelfEntityCopyWith<$Res> implements $BookshelfEntityCopyWith<$Res> {
  factory _$BookshelfEntityCopyWith(_BookshelfEntity value, $Res Function(_BookshelfEntity) _then) = __$BookshelfEntityCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$BookshelfEntityCopyWithImpl<$Res>
    implements _$BookshelfEntityCopyWith<$Res> {
  __$BookshelfEntityCopyWithImpl(this._self, this._then);

  final _BookshelfEntity _self;
  final $Res Function(_BookshelfEntity) _then;

/// Create a copy of BookshelfEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_BookshelfEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
