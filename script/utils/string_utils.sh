#!/bin/bash

# Function to convert feature name to PascalCase
convert_to_pascal_case() {
    local feature_name="$1"
    # Split by underscore and capitalize each word
    local words=($( echo "$feature_name" | tr '_' ' '))
    local result=""
    
    for word in "${words[@]}"; do
        # Capitalize first letter of each word
        local capitalized=$(echo "$word" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
        result="$result$capitalized"
    done
    
    echo "$result"
} 

# Function to convert feature name to lowerCamelCase
convert_to_lower_camel_case() {
    local feature_name="$1"
    # Split by underscore and capitalize each word
    local words=($( echo "$feature_name" | tr '_' ' '))
    local result=""
    
    # Handle first word - should be lowercase
    if [ ${#words[@]} -gt 0 ]; then
        result=$(echo "${words[0]}" | awk '{print tolower($0)}')
    fi
    
    # Handle remaining words - capitalize first letter
    for ((i=1; i<${#words[@]}; i++)); do
        local capitalized=$(echo "${words[$i]}" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
        result="$result$capitalized"
    done
    
    echo "$result"
}
