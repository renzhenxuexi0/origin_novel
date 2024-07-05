use serde::{Deserialize, Serialize};

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
}