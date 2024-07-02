pub use serde::{Deserialize, Serialize};

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

/// 正文页规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleContent {
    pub content: Option<String>,
    // 替换规则
    pub replace_regex: Option<String>,
    // 有些网站只能在正文中获取标题
    pub title: Option<String>,
    pub next_content_url: Option<String>,
    pub web_js: Option<String>,
    pub source_regex: Option<String>,
    // 默认大小居中，FULL 最大宽度
    pub image_style: Option<String>,
    // 购买操作, js 或者包含 {{js}} 的 url
    pub pay_action: Option<String>,
}

/// 搜索规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleSearch {
    pub author: Option<String>,
    pub book_list: Option<String>,
    pub book_url: Option<String>,
    pub cover_url: Option<String>,
    pub intro: Option<String>,
    pub name: Option<String>,
    pub word_count: Option<String>,
    pub kind: Option<String>,
}

/// 发现规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleExplore {
    pub author: Option<String>,
    pub book_list: Option<String>,
    pub book_url: Option<String>,
    pub cover_url: Option<String>,
    pub last_chapter: Option<String>,
    pub intro: Option<String>,
    pub name: Option<String>,
    pub word_count: Option<String>,
    pub kind: Option<String>,
}

/// 段评规则结构定义
#[derive(Debug, Clone, Serialize, Deserialize)]
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