pub use std::borrow::BorrowMut;

pub use flutter_rust_bridge::frb;
pub use serde::{Deserialize, Serialize};

use crate::api::model::rule_book_info::RuleBookInfo;
use crate::api::model::rule_content::RuleContent;
use crate::api::model::rule_explore::RuleExplore;
use crate::api::model::rule_search::RuleSearch;
use crate::api::model::rule_toc::RuleToc;
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
    #[frb(ignore)]
    pub fn set_rule_type(&mut self) {
        if let Some(rule) = &mut self.rule_book_info {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_toc {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_search {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_explore {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_book_info {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_content {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
        if let Some(rule) = &mut self.rule_review {
            let rule = rule.borrow_mut();
            rule.set_rule_type();
        }
    }
}