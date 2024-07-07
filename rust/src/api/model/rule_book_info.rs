use std::collections::HashMap;

use serde::{Deserialize, Deserializer, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule_type::RuleType;

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
    #[serde(skip)]
    pub rule_types: HashMap<String, RuleType>,
}

impl Default for RuleBookInfo {
    fn default() -> Self {
        RuleBookInfo {
            author: None,
            cover_url: None,
            init: None,
            intro: None,
            kind: None,
            last_chapter: None,
            name: None,
            toc_url: None,
            word_count: None,
            download_url: None,
            can_re_name: None,
            rule_types: HashMap::new(),
        }
    }
}

impl RuleBookInfo {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<&str, Option<&String>> = HashMap::from_iter(vec![
            ("author", self.author.as_ref()),
            ("cover_url", self.cover_url.as_ref()),
            ("init", self.init.as_ref()),
            ("intro", self.intro.as_ref()),
            ("kind", self.kind.as_ref()),
            ("last_chapter", self.last_chapter.as_ref()),
            ("name", self.name.as_ref()),
            ("toc_url", self.toc_url.as_ref()),
            ("word_count", self.word_count.as_ref()),
            ("download_url", self.download_url.as_ref()),
            ("can_re_name", self.can_re_name.as_ref()),
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