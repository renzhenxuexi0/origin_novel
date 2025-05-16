#!/usr/bin/env nu

# 验证特性名称
export def validate_feature_name [
    feature_name: string # 要验证的特性名称
] {
    # 检查特性名称是否符合规则（以小写字母开头，只包含小写字母、数字或下划线）
    let pattern = '^[a-z][a-z0-9_]*$'
    let is_valid = ($feature_name | find -r $pattern | str length) > 0
    
    if not $is_valid {
        print $"Error: Invalid feature name '($feature_name)'"
        print "Feature name must:"
        print "  - Start with a lowercase letter"
        print "  - Contain only lowercase letters, numbers, or underscores"
        print "  - Example valid names: user, user_profile, auth2fa"
        false
    } else {
        true
    }
}
