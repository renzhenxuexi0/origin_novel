import 'package:realm/realm.dart';

part 'settings_model.realm.dart';

@RealmModel()
class _SettingsModel {
  @PrimaryKey()
  late int id;
}
