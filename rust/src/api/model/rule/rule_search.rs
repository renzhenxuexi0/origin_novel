use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule::rule_type::RuleType;

/// 搜索规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
#[serde(rename_all = "camelCase")]
pub struct RuleSearch {
    pub author: Option<String>,
    pub book_list: Option<String>,
    pub book_url: Option<String>,
    pub cover_url: Option<String>,
    pub intro: Option<String>,
    pub name: Option<String>,
    pub word_count: Option<String>,
    pub kind: Option<String>,
    #[serde(skip)]
    pub rule_types: HashMap<RuleSearchField, RuleType>,
}

#[derive(Debug, Clone, Eq, Serialize, Deserialize, PartialEq, Hash)]
pub enum RuleSearchField {
    Author,
    BookList,
    BookUrl,
    CoverUrl,
    Intro,
    Name,
    WordCount,
    Kind,
}

#[frb(ignore)]
impl RuleSearch {
    /// set_rule_types方法 用于设置rule_types字段
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<RuleSearchField, Option<&String>> = HashMap::from_iter(vec![
            (RuleSearchField::Author, self.author.as_ref()),
            (RuleSearchField::BookList, self.book_list.as_ref()),
            (RuleSearchField::BookUrl, self.book_url.as_ref()),
            (RuleSearchField::CoverUrl, self.cover_url.as_ref()),
            (RuleSearchField::Intro, self.intro.as_ref()),
            (RuleSearchField::Name, self.name.as_ref()),
            (RuleSearchField::WordCount, self.word_count.as_ref()),
            (RuleSearchField::Kind, self.kind.as_ref()),
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
