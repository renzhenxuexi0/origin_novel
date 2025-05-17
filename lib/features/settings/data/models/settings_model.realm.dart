// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class SettingsModel extends _SettingsModel
    with RealmEntity, RealmObjectBase, RealmObject {
  SettingsModel(int id) {
    RealmObjectBase.set(this, 'id', id);
  }

  SettingsModel._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  Stream<RealmObjectChanges<SettingsModel>> get changes =>
      RealmObjectBase.getChanges<SettingsModel>(this);

  @override
  Stream<RealmObjectChanges<SettingsModel>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<SettingsModel>(this, keyPaths);

  @override
  SettingsModel freeze() => RealmObjectBase.freezeObject<SettingsModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{'id': id.toEJson()};
  }

  static EJsonValue _toEJson(SettingsModel value) => value.toEJson();
  static SettingsModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id} => SettingsModel(fromEJson(id)),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SettingsModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      SettingsModel,
      'SettingsModel',
      [SchemaProperty('id', RealmPropertyType.int, primaryKey: true)],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
