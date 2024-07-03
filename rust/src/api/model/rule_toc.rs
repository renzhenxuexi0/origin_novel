use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::model::rule_type::{RuleType, set_rule_type_for_field};

/// 目录页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleToc {
    pub chapter_list: Option<String>,
    pub chapter_name: Option<String>,
    pub chapter_url: Option<String>,
    pub is_volume: Option<String>,
    pub pre_update_json: Option<String>,
    pub format_js: Option<String>,
    pub is_vip: Option<String>,
    pub is_pay: Option<String>,
    pub next_toc_url: Option<String>,
    pub update_time: Option<String>,
    pub rule_type: Option<RuleType>,
}

impl RuleToc {
    #[frb(ignore)]
    pub fn set_rule_type(&mut self) {
        if let Some(str) = &self.chapter_name {
            set_rule_type_for_field(&mut self.rule_type, str.to_string());
        }
    }
}