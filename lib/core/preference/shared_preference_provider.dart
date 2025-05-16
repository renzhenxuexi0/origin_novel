import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_provider.g.dart';

@riverpod
Future<SharedPreferences> sharedPreference(Ref ref) async {
  SharedPreferences.setPrefix('orgin_novel.');
  return SharedPreferences.getInstance();
}
