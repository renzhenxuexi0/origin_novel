use flutter_rust_bridge::frb;
pub use once_cell::sync::Lazy;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
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
#[frb(ignore)]
pub struct RuleCharacteristic {
    pub prefix: String,
    pub rule_type: RuleType,
}

#[frb(ignore)]
pub fn set_rule_type_for_field(rule_type_field: &mut Option<RuleType>, value: String) {
    for characteristic in RULE_CHARACTERISTICS.iter() {
        if value.starts_with(characteristic.prefix.as_str()) {
            *rule_type_field = characteristic.rule_type.clone().into();
            break; // Exit the loop once a match is found
        }
    }
}

/// 创建一个惰性静态变量，用于存储所有的规则特征
#[frb(ignore)]
pub static RULE_CHARACTERISTICS: Lazy<Vec<RuleCharacteristic>> = Lazy::new(|| {
    vec![
        RuleCharacteristic { prefix: "$.".to_string(), rule_type: RuleType::JsonPath },
        RuleCharacteristic { prefix: "@json:".to_string(), rule_type: RuleType::JsonPath },
        RuleCharacteristic { prefix: "@js".to_string(), rule_type: RuleType::Js },
        RuleCharacteristic { prefix: "<js>".to_string(), rule_type: RuleType::Js },
        RuleCharacteristic { prefix: "class.".to_string(), rule_type: RuleType::JsoupDefault },
        RuleCharacteristic { prefix: "id.".to_string(), rule_type: RuleType::JsoupDefault },
        // Add other characteristics here...
        RuleCharacteristic { prefix: "@css:".to_string(), rule_type: RuleType::JsoupCss },
        RuleCharacteristic { prefix: "@XPath:".to_string(), rule_type: RuleType::XPath },
        RuleCharacteristic { prefix: "//".to_string(), rule_type: RuleType::XPath },
        RuleCharacteristic { prefix: ":".to_string(), rule_type: RuleType::Regex },
    ]
});