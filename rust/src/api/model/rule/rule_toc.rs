use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule::rule_type::RuleType;

/// 目录页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
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
    pub rule_types: HashMap<RuleTocField, RuleType>,
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
pub enum RuleTocField {
    ChapterList,
    ChapterName,
    ChapterUrl,
    IsVolume,
    PreUpdateJson,
    FormatJs,
    IsVip,
    IsPay,
    NextTocUrl,
    UpdateTime,
}

#[frb(ignore)]
impl RuleToc {
    /// set_rule_types方法 用于设置rule_types字段
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<RuleTocField, Option<&String>> = HashMap::from_iter(vec![
            (RuleTocField::ChapterList, self.chapter_list.as_ref()),
            (RuleTocField::ChapterName, self.chapter_name.as_ref()),
            (RuleTocField::ChapterUrl, self.chapter_url.as_ref()),
            (RuleTocField::IsVolume, self.is_volume.as_ref()),
            (RuleTocField::PreUpdateJson, self.pre_update_json.as_ref()),
            (RuleTocField::FormatJs, self.format_js.as_ref()),
            (RuleTocField::IsVip, self.is_vip.as_ref()),
            (RuleTocField::IsPay, self.is_pay.as_ref()),
            (RuleTocField::NextTocUrl, self.next_toc_url.as_ref()),
            (RuleTocField::UpdateTime, self.update_time.as_ref()),
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
