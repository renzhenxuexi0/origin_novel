use serde::{Deserialize, Serialize};

/// 目录页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleToc {
    pub chapter_list: Option<String>,
    pub chapter_name: Option<String>,
    pub chapter_url: Option<String>,
    pub is_volume: Option<String>,
    pub pre_update_json: Option<String>,
    pub format_js: Option<String>,
    pub is_vip: Option<String>,
    pub is_pay: Option<String>,
    pub next_toc_url: Option<String>,
    pub update_time: Option<String>,
}