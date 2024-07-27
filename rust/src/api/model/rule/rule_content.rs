use std::collections::HashMap;

use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::model::rule::rule_type::RuleType;

/// 正文页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
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
    pub rule_types: HashMap<RuleContentField, RuleType>,
}

#[derive(Debug, Clone, Serialize, Deserialize, Eq, PartialEq, Hash)]
pub enum RuleContentField {
    Content,
    ReplaceRegex,
    Title,
    NextContentUrl,
    WebJs,
    SourceRegex,
    ImageStyle,
    PayAction,
}

#[frb(ignore)]
impl RuleContent {
    /// set_rule_types方法 用于设置rule_types字段
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<RuleContentField, Option<&String>> = HashMap::from_iter(vec![
            (RuleContentField::Content, self.content.as_ref()),
            (RuleContentField::ReplaceRegex, self.replace_regex.as_ref()),
            (RuleContentField::Title, self.title.as_ref()),
            (
                RuleContentField::NextContentUrl,
                self.next_content_url.as_ref(),
            ),
            (RuleContentField::WebJs, self.web_js.as_ref()),
            (RuleContentField::SourceRegex, self.source_regex.as_ref()),
            (RuleContentField::ImageStyle, self.image_style.as_ref()),
            (RuleContentField::PayAction, self.pay_action.as_ref()),
        ]);

        // 初始化rule_types字段
        self.rule_types = HashMap::new();
        for (name, rule) in fields {
            if let Some(rule) = rule {
                self.rule_types.insert(name, RuleType::new(rule));
            }
        }
    }
}
