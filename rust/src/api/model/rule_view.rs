use serde::{Deserialize, Serialize};

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
}