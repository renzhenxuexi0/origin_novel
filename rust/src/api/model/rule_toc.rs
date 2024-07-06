use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule_type::RuleType;

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
    #[serde(skip)]
    pub rule_types: HashMap<String, RuleType>,
}

impl RuleToc {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<&str, Option<&String>> = HashMap::from_iter(vec![
            ("chapter_list", self.chapter_list.as_ref()),
            ("chapter_name", self.chapter_name.as_ref()),
            ("chapter_url", self.chapter_url.as_ref()),
            ("is_volume", self.is_volume.as_ref()),
            ("pre_update_json", self.pre_update_json.as_ref()),
            ("format_js", self.format_js.as_ref()),
            ("is_vip", self.is_vip.as_ref()),
            ("is_pay", self.is_pay.as_ref()),
            ("next_toc_url", self.next_toc_url.as_ref()),
            ("update_time", self.update_time.as_ref()),
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