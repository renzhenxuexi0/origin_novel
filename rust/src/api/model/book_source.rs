pub use std::borrow::BorrowMut;

pub use flutter_rust_bridge::frb;
use log::debug;
pub use serde::{Deserialize, Serialize};

use crate::api::model::rule_book_info::RuleBookInfo;
use crate::api::model::rule_content::RuleContent;
use crate::api::model::rule_explore::RuleExplore;
use crate::api::model::rule_search::RuleSearch;
use crate::api::model::rule_toc::RuleToc;
use crate::api::model::rule_type::is_supported_rule;
use crate::api::model::rule_view::RuleReview;

/// 书源结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
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
    pub rule_book_info: Option<RuleBookInfo>,
    /// 正文页规则
    pub rule_content: Option<RuleContent>,
    /// 发现规则
    pub rule_explore: Option<RuleExplore>,
    /// 段评规则
    pub rule_review: Option<RuleReview>,
    /// 搜索规则
    pub rule_search: Option<RuleSearch>,
    /// 目录页规则
    pub rule_toc: Option<RuleToc>,
    /// 搜索url
    pub search_url: Option<String>,
    /// 智能排序的权重
    pub weight: Option<i64>,
}

impl BookSource {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        debug!("设置书源规则类型 书名 {:?}", self.book_source_name);
        if let Some(rule_book_info) = self.rule_book_info.borrow_mut() {
            rule_book_info.set_rule_types();
            debug!("书信息规则的规则类型: {:?}", rule_book_info.rule_types);
        }
        if let Some(rule_content) = self.rule_content.borrow_mut() {
            rule_content.set_rule_types();
            debug!("正文规则的规则类型: {:?}", rule_content.rule_types);
        }
        if let Some(rule_explore) = self.rule_explore.borrow_mut() {
            rule_explore.set_rule_types();
            debug!("发现规则的规则类型: {:?}", rule_explore.rule_types);
        }
        if let Some(rule_review) = self.rule_review.borrow_mut() {
            rule_review.set_rule_types();
            debug!("段评规则的规则类型: {:?}", rule_review.rule_types);
        }
        if let Some(rule_search) = self.rule_search.borrow_mut() {
            rule_search.set_rule_types();
            debug!("搜索规则的规则类型: {:?}", rule_search.rule_types);
        }
        if let Some(rule_toc) = self.rule_toc.borrow_mut() {
            rule_toc.set_rule_types();
            debug!("目录规则的规则类型: {:?}", rule_toc.rule_types);
        }
    }

    /// 过滤书源
    #[frb(ignore)]
    pub fn filter_book_source(&self) -> bool {
        debug!("过滤书源 书名: {:?}", self.book_source_name);
        let mut result = true;
        match self.book_source_url.as_ref() {
            Some(url) => {
                result = result && !url.is_empty();
                debug!("书源地址是否为空: {:?}", result);
            }
            None => {
                result = false;
                debug!("书源地址为空");
            }
        }
        match self.search_url.as_ref() {
            Some(url) => {
                result = result && !url.is_empty();
                debug!("搜索地址是否为空: {:?}", result);
            }
            None => {
                result = false;
                debug!("搜索地址为空");
            }
        }
        if let Some(rule_book_info) = self.rule_book_info.as_ref() {
            let support = rule_book_info.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("书籍信息规则是否支持: {:?}", support);
            result = result && support;
        }
        if let Some(rule_content) = self.rule_content.as_ref() {
            let support = rule_content.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("正文规则是否支持: {:?}", support);
            result = result && support;
        }
        // if let Some(rule_explore) = self.rule_explore.as_ref() {
        //     result = result && rule_explore.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        // if let Some(rule_review) = self.rule_review.as_ref() {
        //     result = result && rule_review.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        if let Some(rule_search) = self.rule_search.as_ref() {
            let support = rule_search.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
            debug!("搜索规则是否支持: {:?}", support);
            result = result && support;
        }
        // if let Some(rule_toc) = self.rule_toc.as_ref() {
        //     result = result && rule_toc.rule_types.iter().all(|(_, rule)| is_supported_rule(rule.clone()));
        // }
        debug!("过滤书源最终结果: {:?}", result);
        result
    }
}