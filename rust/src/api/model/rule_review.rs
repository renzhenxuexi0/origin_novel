use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule_type::RuleType;

/// 段评规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleReview {
    /// 段评URL
    pub review_url: Option<String>,
    /// 段评发布者头像规则
    pub avatar_rule: Option<String>,
    /// 段评内容规则
    pub content_rule: Option<String>,
    /// 段评发布时间规则
    pub post_time_rule: Option<String>,
    /// 获取段评回复URL
    pub review_quote_url: Option<String>,
    // 以下功能将在以上功能完成以后实现
    /// 点赞URL
    pub vote_up_url: Option<String>,
    /// 点踩URL
    pub vote_down_url: Option<String>,
    /// 发送回复URL
    pub post_review_url: Option<String>,
    /// 发送回复段评URL
    pub post_quote_url: Option<String>,
    /// 删除段评URL
    pub delete_url: Option<String>,
    #[serde(skip)]
    pub rule_types: HashMap<String, RuleType>,
}


impl Default for RuleReview {
    fn default() -> Self {
        RuleReview {
            review_url: None,
            avatar_rule: None,
            content_rule: None,
            post_time_rule: None,
            review_quote_url: None,
            vote_up_url: None,
            vote_down_url: None,
            post_review_url: None,
            post_quote_url: None,
            delete_url: None,
            rule_types: HashMap::new(),
        }
    }
}

impl RuleReview {
    /// set_rule_types方法 用于设置rule_types字段
    #[frb(ignore)]
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<&str, Option<&String>> = HashMap::from_iter(vec![
            ("avatar_rule", self.avatar_rule.as_ref()),
            ("content_rule", self.content_rule.as_ref()),
            ("post_time_rule", self.post_time_rule.as_ref()),
            ("review_quote_url", self.review_quote_url.as_ref()),
            ("vote_up_url", self.vote_up_url.as_ref()),
            ("vote_down_url", self.vote_down_url.as_ref()),
            ("post_review_url", self.post_review_url.as_ref()),
            ("post_quote_url", self.post_quote_url.as_ref()),
            ("delete_url", self.delete_url.as_ref()),
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