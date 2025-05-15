#!/bin/bash

generate_barrel_files() {
    local feature_name="$1"

    # Create data barrel files
    create_file "lib/features/$feature_name/data/data.dart" \
    "export 'sources/remote/remote.dart';
export 'dto/dto.dart';
export 'mappers/mappers.dart';
export 'repositories/repositories.dart';"

    create_file "lib/features/$feature_name/data/sources/remote/remote.dart" \
    "export '${feature_name}_remote_data_source.dart';
    export '${feature_name}_remote_data_source_impl.dart';

    "

   create_file "lib/features/$feature_name/data/sources/local/local.dart" \
    "export '${feature_name}_local_data_source.dart';
    export '${feature_name}_local_data_source_impl.dart';
    
    "

    create_file "lib/features/$feature_name/data/dto/dto.dart" \
    "export '${feature_name}_dto.dart';"

    create_file "lib/features/$feature_name/data/mappers/mappers.dart" \
    "export '${feature_name}_mapper.dart';"

    create_file "lib/features/$feature_name/data/repositories/repositories.dart" \
    "export '${feature_name}_repository_impl.dart';"

    # Create domain barrel files
    create_file "lib/features/$feature_name/domain/domain.dart" \
    "export 'entities/entities.dart';
export 'repositories/repositories.dart';
export 'usecases/usecases.dart';"

    create_file "lib/features/$feature_name/domain/entities/entities.dart" \
    "export '${feature_name}_entity.dart';"

    create_file "lib/features/$feature_name/domain/repositories/repositories.dart" \
    "export '${feature_name}_repository.dart';"

    create_file "lib/features/$feature_name/domain/usecases/usecases.dart" \
    "export 'get_${feature_name}_use_case.dart';"

    # Create presentation barrel files
    create_file "lib/features/$feature_name/presentation/presentation.dart" \
    "export 'pages/pages.dart';
export 'providers/providers.dart';
export 'widgets/widgets.dart';"

    create_file "lib/features/$feature_name/presentation/pages/pages.dart" \
    "export '${feature_name}_page.dart';"

    create_file "lib/features/$feature_name/presentation/providers/providers.dart" \
    "export '${feature_name}_notifier.dart';"

    create_file "lib/features/$feature_name/presentation/widgets/widgets.dart" \
    "// TODO: Export widget files here
// Example:
// export 'some_widget.dart';"

    # Create main feature barrel file
    create_file "lib/features/$feature_name/${feature_name}.dart" \
    "export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';"
} 