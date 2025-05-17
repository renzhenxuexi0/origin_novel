# 生成model代码 (使用freezed)

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
] {
    let content = $"import 'package:realm/realm.dart';
    
part '($feature_name)_model.realm.dart';

@RealmModel\(\)
class _($capitalized_feature_name)Model {
  @PrimaryKey\(\)
  late int id;

  // TODO: Add more Model properties
}"
    
    create_file $"lib/features/($feature_name)/data/models/($feature_name)_model.dart" $content

}
