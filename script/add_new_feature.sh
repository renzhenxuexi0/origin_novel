#!/bin/bash

# Import helper scripts
source "$(dirname "$0")/utils/validators.sh"      # Provides feature name validation
source "$(dirname "$0")/utils/string_utils.sh"    # Provides string case conversion utilities
source "$(dirname "$0")/utils/file_utils.sh"      # Provides file and directory creation utilities

# Import all generator scripts for different layers
source "$(dirname "$0")/generators/data/generate_dto.sh"
source "$(dirname "$0")/generators/data/generate_mapper.sh"
source "$(dirname "$0")/generators/data/generate_remote_data_source.sh"
source "$(dirname "$0")/generators/data/generate_abstract_remote_data_source.sh"
source "$(dirname "$0")/generators/data/generate_abstract_local_data_source.sh"
source "$(dirname "$0")/generators/data/generate_local_data_source.sh"
source "$(dirname "$0")/generators/data/generate_repository_impl.sh"
source "$(dirname "$0")/generators/domain/generate_entity.sh"
source "$(dirname "$0")/generators/domain/generate_repository.sh"
source "$(dirname "$0")/generators/domain/generate_use_case.sh"
source "$(dirname "$0")/generators/presentation/generate_notifier.sh"
source "$(dirname "$0")/generators/presentation/generate_page.sh"
source "$(dirname "$0")/generators/generate_barrel_files.sh"

# Function to create directories and files for a feature
create_feature() {
    local feature_name="$1"

    echo "🔍 Validating feature name: $feature_name"
    validate_feature_name "$feature_name" || exit 1
    echo "✅ Feature name validation passed"

    echo "🔄 Converting naming conventions..."
    local capitalized_feature_name
    capitalized_feature_name=$(convert_to_pascal_case "$feature_name")
    echo "  - PascalCase: $capitalized_feature_name"

    local provider_name
    provider_name=$(convert_to_lower_camel_case "$feature_name")
    echo "  - camelCase: $provider_name"

    echo "📁 Creating base directory structure..."
    create_base_directories "$feature_name"
    echo "✅ Base directories created"

    echo "🏗️ Generating feature files..."
    
    echo "  📝 Generating Data Layer..."
    generate_repository "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_repository_impl "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_abstract_remote_data_source "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_abstract_local_data_source "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_remote_data_source "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_local_data_source "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_dto "$feature_name" "$capitalized_feature_name"
    generate_mapper "$feature_name" "$capitalized_feature_name"
    echo "  ✅ Data Layer complete"

    echo "  📝 Generating Domain Layer..."
    generate_entity "$feature_name" "$capitalized_feature_name"
    generate_use_case "$feature_name" "$capitalized_feature_name" "$provider_name"
    echo "  ✅ Domain Layer complete"

    echo "  📝 Generating Presentation Layer..."
    generate_notifier "$feature_name" "$capitalized_feature_name" "$provider_name"
    generate_page "$feature_name" "$capitalized_feature_name" "$provider_name"
    echo "  ✅ Presentation Layer complete"

    echo "  📝 Generating Barrel Files..."
    generate_barrel_files "$feature_name"
    echo "  ✅ Barrel Files complete"
}

# Main script execution
main() {
    if [ $# -eq 0 ]; then
        echo "❌ Error: Please provide a feature name."
        exit 1
    fi

    echo "🚀 Starting feature generation for: $1"
    create_feature "$1"
    echo "✨ Clean architecture structure for feature '$1' created successfully!"
    
    echo "
📁 Generated structure:
lib/features/$1/
├── data/
│   ├── dto/
│   ├── mappers/
│   ├── repositories/
│   └── sources/
│       ├── local/
│       └── remote/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
"
}

# Call main function with all script arguments
main "$@" 