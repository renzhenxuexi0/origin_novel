use serde::{Deserialize, Serialize};


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
}