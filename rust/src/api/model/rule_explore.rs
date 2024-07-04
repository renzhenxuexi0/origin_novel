use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::model::rule_type::{RuleType, set_rule_type_for_field};

/// 发现规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleExplore {
    pub author: Option<String>,
    pub book_list: Option<String>,
    pub book_url: Option<String>,
    pub cover_url: Option<String>,
    pub last_chapter: Option<String>,
    pub intro: Option<String>,
    pub name: Option<String>,
    pub word_count: Option<String>,
    pub kind: Option<String>,
    #[serde(skip)]
    pub rule_type: Option<RuleType>,
}

impl RuleExplore {
    #[frb(ignore)]
    pub fn set_rule_type(&mut self) {
        if let Some(str) = &self.book_url {
            set_rule_type_for_field(&mut self.rule_type, str.to_string());
        }
    }
}