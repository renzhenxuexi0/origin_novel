use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule_type::RuleType;

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
    pub rule_types: HashMap<String, RuleType>,
}

impl RuleExplore {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<&str, Option<&String>> = HashMap::from_iter(vec![
            ("author", self.author.as_ref()),
            ("book_list", self.book_list.as_ref()),
            ("book_url", self.book_url.as_ref()),
            ("cover_url", self.cover_url.as_ref()),
            ("last_chapter", self.last_chapter.as_ref()),
            ("intro", self.intro.as_ref()),
            ("name", self.name.as_ref()),
            ("word_count", self.word_count.as_ref()),
            ("kind", self.kind.as_ref()),
        ]);

        // 初始化rule_types字段
        self.rule_types = HashMap::new();
        for (name, rule) in fields {
            if let Some(rule) = rule {
                self.rule_types.insert(name.to_string(), RuleType::new(rule));
            }
        }
    }
}