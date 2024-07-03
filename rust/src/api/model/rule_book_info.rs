use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::model::rule_type::{RuleType, set_rule_type_for_field};

/// 书籍信息页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleBookInfo {
    pub author: Option<String>,
    pub cover_url: Option<String>,
    pub init: Option<String>,
    pub intro: Option<String>,
    pub kind: Option<String>,
    pub last_chapter: Option<String>,
    pub name: Option<String>,
    pub toc_url: Option<String>,
    pub word_count: Option<String>,
    pub download_url: Option<String>,
    pub can_re_name: Option<String>,
    pub rule_type: Option<RuleType>,
}

impl RuleBookInfo {
    #[frb(ignore)]
    pub fn set_rule_type(&mut self) {
        if let Some(str) = &self.name {
            set_rule_type_for_field(&mut self.rule_type, str.clone());
        }
    }
}