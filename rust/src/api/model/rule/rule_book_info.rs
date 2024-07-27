use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule::rule_type::RuleType;

/// 书籍信息页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
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
    pub rule_types: HashMap<RuleBookInfoField, RuleType>,
}

#[derive(Debug, Clone, Eq, Serialize, Deserialize, PartialEq, Hash)]
pub enum RuleBookInfoField {
    Author,
    CoverUrl,
    Init,
    Intro,
    Kind,
    LastChapter,
    Name,
    TocUrl,
    WordCount,
    DownloadUrl,
    CanReName,
}

#[frb(ignore)]
impl RuleBookInfo {
    /// set_rule_types方法 用于设置rule_types字段
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<RuleBookInfoField, Option<&String>> = HashMap::from_iter(vec![
            (RuleBookInfoField::Author, self.author.as_ref()),
            (RuleBookInfoField::CoverUrl, self.cover_url.as_ref()),
            (RuleBookInfoField::Init, self.init.as_ref()),
            (RuleBookInfoField::Intro, self.intro.as_ref()),
            (RuleBookInfoField::Kind, self.kind.as_ref()),
            (RuleBookInfoField::LastChapter, self.last_chapter.as_ref()),
            (RuleBookInfoField::Name, self.name.as_ref()),
            (RuleBookInfoField::TocUrl, self.toc_url.as_ref()),
            (RuleBookInfoField::WordCount, self.word_count.as_ref()),
            (RuleBookInfoField::DownloadUrl, self.download_url.as_ref()),
            (RuleBookInfoField::CanReName, self.can_re_name.as_ref()),
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
