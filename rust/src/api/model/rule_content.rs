use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::model::rule_type::{RuleType, set_rule_type_for_field};

/// 正文页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleContent {
    pub content: Option<String>,
    // 替换规则
    pub replace_regex: Option<String>,
    // 有些网站只能在正文中获取标题
    pub title: Option<String>,
    pub next_content_url: Option<String>,
    pub web_js: Option<String>,
    pub source_regex: Option<String>,
    // 默认大小居中，FULL 最大宽度
    pub image_style: Option<String>,
    // 购买操作, js 或者包含 {{js}} 的 url
    pub pay_action: Option<String>,
    #[serde(skip)]
    pub rule_type: Option<RuleType>,
}

impl RuleContent {
    #[frb(ignore)]
    pub fn set_rule_type(&mut self) {
        if let Some(str) = &self.content {
            set_rule_type_for_field(&mut self.rule_type, str.to_string());
        }
    }
}