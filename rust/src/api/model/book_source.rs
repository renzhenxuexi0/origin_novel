pub use std::borrow::BorrowMut;

pub use flutter_rust_bridge::frb;
use log::debug;
pub use serde::{Deserialize, Serialize};
use serde::Deserializer;
use serde_json::Value;

use crate::api::model::rule::rule_book_info::RuleBookInfo;
use crate::api::model::rule::rule_content::RuleContent;
use crate::api::model::rule::rule_explore::RuleExplore;
use crate::api::model::rule::rule_review::RuleReview;
use crate::api::model::rule::rule_search::RuleSearch;
use crate::api::model::rule::rule_toc::RuleToc;
use crate::api::model::rule::rule_type::is_supported_rule;

/// 书源结构定义
#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct BookSource {
    /// 书源备注
    pub book_source_comment: Option<String>,
    /// 书源分组
    pub book_source_group: Option<String>,
    /// 书源名称
    pub book_source_name: Option<String>,
    /// 书源类型，0 文本，1 音频, 2 图片, 3 文件（指的是类似知轩藏书只提供下载的网站）
    pub book_source_type: Option<i64>,
    /// 书源地址，包括 http/https
    pub book_source_url: Option<String>,
    // 详情页url正则
    pub book_url_pattern: Option<String>,
    // 请求头
    pub header: Option<String>,
    // 登录地址
    pub login_url: Option<String>,
    /// 手动排序编号
    pub custom_order: Option<i64>,
    /// 是否启用
    pub enabled: Option<bool>,
    /// 是否可以启用
    pub can_enable: Option<bool>,
    /// 每次请求的cookie
    pub enabled_cookie_jar: Option<bool>,
    /// 启用发现
    pub enabled_explore: Option<bool>,
    /// 发现url
    pub explore_url: Option<String>,
    /// 最后更新时间，用于排序
    pub last_update_time: Option<i64>,
    /// 响应时间，用于排序
    pub respond_time: Option<i64>,
    /// 书籍信息页规则
    #[serde[default]]
    pub rule_book_info: Option<RuleBookInfo>,
    /// 正文页规则
    #[serde[default]]
    pub rule_content: Option<RuleContent>,
    /// 发现规则
    #[serde[default]]
    pub rule_explore: Option<RuleExplore>,
    /// 段评规则
    #[serde[default]]
    pub rule_review: Option<RuleReview>,
    /// 搜索规则
    #[serde[default]]
    pub rule_search: Option<RuleSearch>,
    /// 目录页规则
    #[serde[default]]
    pub rule_toc: Option<RuleToc>,
    /// 搜索url
    pub search_url: Option<String>,
    /// 智能排序的权重
    pub weight: Option<i64>,
}

impl<'de> Deserialize<'de> for BookSource {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: Deserializer<'de>,
    {
        let value = Value::deserialize(deserializer)?;

        if let Value::Object(map) = value {
            Ok(BookSource {
                book_source_name: parse_field(&map, "bookSourceName"),
                book_source_type: parse_field(&map, "bookSourceType"),
                book_source_url: parse_field(&map, "bookSourceUrl"),
                custom_order: parse_field(&map, "customOrder"),
                enabled: parse_field(&map, "enabled"),
                enabled_cookie_jar: parse_field(&map, "enabledCookieJar"),
                enabled_explore: parse_field(&map, "enabledExplore"),
                explore_url: parse_field(&map, "exploreUrl"),
                last_update_time: parse_field(&map, "lastUpdateTime"),
                respond_time: parse_field(&map, "respondTime"),
                book_source_comment: parse_field(&map, "bookSourceComment"),
                can_enable: parse_field(&map, "canEnable"),
                book_source_group: parse_field(&map, "bookSourceGroup"),
                book_url_pattern: parse_field(&map, "bookUrlPattern"),
                header: parse_field(&map, "header"),
                login_url: parse_field(&map, "loginUrl"),
                rule_book_info: parse_complex_field(&map, "ruleBookInfo"),
                rule_content: parse_complex_field(&map, "ruleContent"),
                rule_explore: parse_complex_field(&map, "ruleExplore"),
                rule_review: parse_complex_field(&map, "ruleReview"),
                rule_search: parse_complex_field(&map, "ruleSearch"),
                rule_toc: parse_complex_field(&map, "ruleToc"),
                search_url: parse_field(&map, "searchUrl"),
                weight: parse_field(&map, "weight"),
            })
        } else {
            Err(serde::de::Error::custom("无法解析书源数据"))
        }
    }
}

fn parse_field<T: Deserialize<'static>>(
    map: &serde_json::Map<String, Value>,
    key: &str,
) -> Option<T> {
    map.get(key).and_then(|v| {
        if v.is_null() || (v.is_array() && v.as_array().unwrap().is_empty()) {
            None
        } else {
            T::deserialize(v.clone()).ok()
        }
    })
}

fn parse_complex_field<T: Deserialize<'static> + Default>(
    map: &serde_json::Map<String, Value>,
    key: &str,
) -> Option<T> {
    map.get(key).and_then(|v| {
        if v.is_null() || (v.is_array() && v.as_array().unwrap().is_empty()) {
            Some(T::default())
        } else if v.is_object() {
            T::deserialize(v.clone()).ok()
        } else {
            Some(T::default())
        }
    })
}

impl BookSource {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        debug!("[书源]: 设置书源规则类型 书名 {:?}", self.book_source_name);
        if let Some(rule_book_info) = self.rule_book_info.borrow_mut() {
            rule_book_info.set_rule_types();
            debug!(
                "[书源]: 书信息规则的规则类型: {:?}",
                rule_book_info.rule_types
            );
        }
        if let Some(rule_content) = self.rule_content.borrow_mut() {
            rule_content.set_rule_types();
            debug!("[书源]: 正文规则的规则类型: {:?}", rule_content.rule_types);
        }
        if let Some(rule_explore) = self.rule_explore.borrow_mut() {
            rule_explore.set_rule_types();
            debug!("[书源]: 发现规则的规则类型: {:?}", rule_explore.rule_types);
        }
        if let Some(rule_review) = self.rule_review.borrow_mut() {
            rule_review.set_rule_types();
            debug!("[书源]: 段评规则的规则类型: {:?}", rule_review.rule_types);
        }
        if let Some(rule_search) = self.rule_search.borrow_mut() {
            rule_search.set_rule_types();
            debug!("[书源]: 搜索规则的规则类型: {:?}", rule_search.rule_types);
        }
        if let Some(rule_toc) = self.rule_toc.borrow_mut() {
            rule_toc.set_rule_types();
            debug!("[书源]: 目录规则的规则类型: {:?}", rule_toc.rule_types);
        }
    }

    /// 过滤书源
    #[frb(ignore)]
    pub fn filter_book_source(&self) -> bool {
        debug!("[书源]: 过滤书源 书名: {:?}", self.book_source_name);
        let mut result = true;
        match self.book_source_url.as_ref() {
            Some(url) => {
                result = result && !url.is_empty();
                debug!("[书源]: 书源地址是否为空: {:?}", result);
            }
            None => {
                result = false;
                debug!("[书源]: 书源地址为空");
            }
        }
        match self.search_url.as_ref() {
            Some(url) => {
                result = result && !url.is_empty();
                debug!("[书源]: 搜索地址是否为空: {:?}", result);
                // 如果包含webview则过滤
                if url.to_ascii_lowercase().contains("webview")
                    || url.to_ascii_lowercase().contains("java")
                {
                    result = false;
                    debug!("[书源]: 搜索地址包含webview");
                }
            }
            None => {
                result = false;
                debug!("[书源]: 搜索地址为空");
            }
        }
        if let Some(rule_book_info) = self.rule_book_info.as_ref() {
            let support = rule_book_info
                .rule_types
                .iter()
                .all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("[书源]: 书籍信息规则是否支持: {:?}", support);
            result = result && support;
        }
        if let Some(rule_content) = self.rule_content.as_ref() {
            let support = rule_content
                .rule_types
                .iter()
                .all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("[书源]: 正文规则是否支持: {:?}", support);
            result = result && support;
        }
        // if let Some(rule_explore) = self.rule_explore.as_ref() {
        //     result = result && rule_explore.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        // if let Some(rule_review) = self.rule_review.as_ref() {
        //     result = result && rule_review.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        if let Some(rule_search) = self.rule_search.as_ref() {
            let support = rule_search
                .rule_types
                .iter()
                .all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("[书源]: 搜索规则是否支持: {:?}", support);
            result = result && support;
        }
        // if let Some(rule_toc) = self.rule_toc.as_ref() {
        //     result = result && rule_toc.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        debug!("[书源]: 过滤书源最终结果: {:?}", result);
        result
    }
}

#[derive(Debug, Clone)]
pub struct BookSourceData {
    /// 书源json数据
    pub book_source_json: String,
    /// 书源
    pub book_source: BookSource,
}
