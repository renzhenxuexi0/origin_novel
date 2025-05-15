#!/bin/bash

# Function to validate feature name
validate_feature_name() {
    local feature_name="$1"
    if [[ ! "$feature_name" =~ ^[a-z][a-z0-9_]*$ ]]; then
        echo "Error: Invalid feature name '$feature_name'"
        echo "Feature name must:"
        echo "  - Start with a lowercase letter"
        echo "  - Contain only lowercase letters, numbers, or underscores"
        echo "  - Example valid names: user, user_profile, auth2fa"
        return 1
    fi
    return 0
} 