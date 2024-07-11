/// 搜索规则结构定义
#[derive(Debug, Clone, Default)]
pub struct SearchBook {
    pub author: Option<String>,
    pub book_list: Option<String>,
    pub book_url: Option<String>,
    pub cover_url: Option<String>,
    pub intro: Option<String>,
    pub name: Option<String>,
    pub word_count: Option<String>,
    pub kind: Option<String>,
}
