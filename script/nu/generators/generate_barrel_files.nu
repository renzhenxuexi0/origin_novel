# 生成Barrel文件

export def main [
    feature_name: string           # 特性名称
] {
    # Data层Barrel文件
    create_file $"lib/features/($feature_name)/data/data.dart" $"export 'dto/($feature_name)_dto.dart';
export 'mappers/($feature_name)_mapper.dart';
export 'repositories/($feature_name)_repository_impl.dart';
export 'sources/remote/($feature_name)_remote_data_source.dart';
export 'sources/remote/($feature_name)_remote_data_source_abstract.dart';
export 'sources/local/($feature_name)_local_data_source.dart';
export 'sources/local/($feature_name)_local_data_source_abstract.dart';
"
    
    # Domain层Barrel文件
    create_file $"lib/features/($feature_name)/domain/domain.dart" $"export 'entities/($feature_name)_entity.dart';
export 'repositories/($feature_name)_repository.dart';
export 'usecases/($feature_name)_use_case.dart';
"
    
    # Presentation层Barrel文件
    create_file $"lib/features/($feature_name)/presentation/presentation.dart" $"export 'providers/($feature_name)_notifier.dart';
export 'pages/($feature_name)_page.dart';
"
    
    # 根Barrel文件
    create_file $"lib/features/($feature_name)/($feature_name).dart" $"export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
"
}
