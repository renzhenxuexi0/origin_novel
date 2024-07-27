use flutter_rust_bridge::frb;
pub use once_cell::sync::Lazy;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum RuleType {
    /// JSONPATH
    JsonPath,
    /// 正则
    Regex,
    /// Jsoup default
    JsoupDefault,
    /// Jsoup css
    JsoupCss,
    /// js
    Js,
    /// xPath
    XPath,
    /// Unknown
    Unknown,
}

/// 规则特征
struct RuleCharacteristic {
    prefix: String,
    match_method: MatchingMethod,
    rule_type: RuleType,
}

enum MatchingMethod {
    StartsWith,
    Contains,
}

/// 规则特征获取
#[frb(ignore)]
impl RuleType {
    pub fn new(rule: &str) -> Self {
        let rule = rule.trim();
        for characteristic in RULE_CHARACTERISTICS.iter() {
            match characteristic.match_method {
                MatchingMethod::StartsWith => {
                    if rule.starts_with(&characteristic.prefix) {
                        return characteristic.rule_type.clone();
                    }
                }
                MatchingMethod::Contains => {
                    if rule.contains(&characteristic.prefix) {
                        return characteristic.rule_type.clone();
                    }
                }
            }
        }
        RuleType::Unknown
    }
}

/// 创建一个惰性静态变量，用于存储所有的规则特征
#[frb(ignore)]
static RULE_CHARACTERISTICS: Lazy<Vec<RuleCharacteristic>> = Lazy::new(|| {
    vec![
        RuleCharacteristic {
            prefix: "$.".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::JsonPath,
        },
        RuleCharacteristic {
            prefix: "@json:".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::JsonPath,
        },
        RuleCharacteristic {
            prefix: "@js".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::Js,
        },
        RuleCharacteristic {
            prefix: "<js>".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::Js,
        },
        RuleCharacteristic {
            prefix: "class".to_string(),
            match_method: MatchingMethod::Contains,
            rule_type: RuleType::JsoupDefault,
        },
        RuleCharacteristic {
            prefix: "tag".to_string(),
            match_method: MatchingMethod::Contains,
            rule_type: RuleType::JsoupDefault,
        },
        RuleCharacteristic {
            prefix: "id".to_string(),
            match_method: MatchingMethod::Contains,
            rule_type: RuleType::JsoupDefault,
        },
        RuleCharacteristic {
            prefix: "a[".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::JsoupDefault,
        },
        RuleCharacteristic {
            prefix: "@css:".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::JsoupCss,
        },
        RuleCharacteristic {
            prefix: "@XPath:".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::XPath,
        },
        RuleCharacteristic {
            prefix: "//".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::XPath,
        },
        RuleCharacteristic {
            prefix: ":".to_string(),
            match_method: MatchingMethod::StartsWith,
            rule_type: RuleType::Regex,
        },
        RuleCharacteristic {
            prefix: "java".to_string(),
            match_method: MatchingMethod::Contains,
            rule_type: RuleType::Unknown,
        },
    ]
});

/// 创建一个目前可支持的规则配置
#[frb(ignore)]
pub fn is_supported_rule(rule: RuleType) -> bool {
    match rule {
        RuleType::JsonPath | RuleType::JsoupDefault | RuleType::JsoupCss | RuleType::XPath => true,
        _ => false,
    }
}
