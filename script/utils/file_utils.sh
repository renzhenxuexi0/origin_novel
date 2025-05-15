#!/bin/bash

# Function to create a file with given content
create_file() {
    local file_path="$1"
    local content="$2"
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$file_path")"
    
    # Write content to file
    echo "$content" > "$file_path"
}

# Function to create base directories
create_base_directories() {
    local feature_name="$1"
    
    local base_dirs=(
        "lib/features/$feature_name/data/mappers"
        "lib/features/$feature_name/data/repositories"
        "lib/features/$feature_name/data/dto"
        "lib/features/$feature_name/data/sources/remote"
        "lib/features/$feature_name/domain/entities"
        "lib/features/$feature_name/domain/repositories"
        "lib/features/$feature_name/domain/usecases"
        "lib/features/$feature_name/presentation/providers"
        "lib/features/$feature_name/presentation/pages"
        "lib/features/$feature_name/presentation/widgets"
    )

    # Create each base directory
    for dir in "${base_dirs[@]}"; do
        mkdir -p "$dir"
    done
} 