# 生成基于Realm的本地数据源实现

export def main [
    feature_name: string            # 特性名称
    capitalized_feature_name: string  # 首字母大写的特性名称
    provider_name: string            # 驼峰式命名的特性名
] {    
    let content = $"import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/database/realm_provider.dart';
import '../../models/($feature_name)_model.dart';
import '($feature_name)_local_data_source_abstract.dart';

part '($feature_name)_local_data_source.g.dart';

/// 提供($capitalized_feature_name)本地数据源的Provider
@riverpod
I($capitalized_feature_name)LocalDataSource ($provider_name)LocalDataSource\(Ref ref\) {
  final realm = ref.watch\(realmProvider\);
  return ($capitalized_feature_name)LocalDataSource\(realm.requireValue\);
}

/// Realm 本地数据源实现，处理($capitalized_feature_name)相关的本地存储操作
class ($capitalized_feature_name)LocalDataSource implements I($capitalized_feature_name)LocalDataSource {
  final Realm _realm;

  ($capitalized_feature_name)LocalDataSource\(this._realm\);
  
  @override
  Future<List<($capitalized_feature_name)Model>> getAll\(\) async {
    return _realm.all<($capitalized_feature_name)Model>\(\).toList\(\);
  }
  
  @override
  Future<($capitalized_feature_name)Model?> getById\(int id\) async {
    return _realm.find<($capitalized_feature_name)Model>\(id\);
  }
  
  @override
  Future<void> save\(($capitalized_feature_name)Model model\) async {
    _realm.write\(\(\) {
      _realm.add\(model, update: true\);
    }\);
  }
  
  @override
  Future<void> saveAll\(List<($capitalized_feature_name)Model> models\) async {
    _realm.write\(\(\) {
      for \(final model in models\) {
        _realm.add\(model, update: true\);
      }
    }\);
  }
  
  @override
  Future<void> delete\(int id\) async {
    _realm.write\(\(\) {
      final model = _realm.find<($capitalized_feature_name)Model>\(id\);
      if \(model != null\) {
        _realm.delete\(model\);
      }
    }\);
  }

  @override
  Future<void> deleteAll\(\) async {
    _realm.write\(\(\) {
      final models = _realm.all<($capitalized_feature_name)Model>\(\);
      _realm.deleteMany\(models\);
    }\);
  }

  @override
  Future<bool> exists\(int id\) async {
    return _realm.find<($capitalized_feature_name)Model>\(id\) != null;
  }
}"
    
    create_file $"lib/features/($feature_name)/data/sources/local/($feature_name)_local_data_source.dart" $content
}