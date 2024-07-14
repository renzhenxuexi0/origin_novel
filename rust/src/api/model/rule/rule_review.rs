use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use crate::api::model::book_source::frb;
use crate::api::model::rule::rule_type::RuleType;

/// 段评规则结构定义
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
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
    pub rule_types: HashMap<RuleReviewField, RuleType>,
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
pub enum RuleReviewField {
    ReviewUrl,
    AvatarRule,
    ContentRule,
    PostTimeRule,
    ReviewQuoteUrl,
    VoteUpUrl,
    VoteDownUrl,
    PostReviewUrl,
    PostQuoteUrl,
    DeleteUrl,
}

#[frb(ignore)]
impl RuleReview {
    /// set_rule_types方法 用于设置rule_types字段
    pub fn set_rule_types(&mut self) {
        // 创建一个包含所有可选字段的map
        let fields: HashMap<RuleReviewField, Option<&String>> = HashMap::from_iter(vec![
            (RuleReviewField::ReviewUrl, self.review_url.as_ref()),
            (RuleReviewField::AvatarRule, self.avatar_rule.as_ref()),
            (RuleReviewField::ContentRule, self.content_rule.as_ref()),
            (RuleReviewField::PostTimeRule, self.post_time_rule.as_ref()),
            (RuleReviewField::ReviewQuoteUrl, self.review_quote_url.as_ref()),
            (RuleReviewField::VoteUpUrl, self.vote_up_url.as_ref()),
            (RuleReviewField::VoteDownUrl, self.vote_down_url.as_ref()),
            (RuleReviewField::PostReviewUrl, self.post_review_url.as_ref()),
            (RuleReviewField::PostQuoteUrl, self.post_quote_url.as_ref()),
            (RuleReviewField::DeleteUrl, self.delete_url.as_ref()),
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
