pub use crate::api::model::book_source::BookSource;

/// 从URL解析书源
pub async fn parse_book_source_from_url(url: &str) -> Result<Vec<BookSource>, reqwest::Error> {
    reqwest::get(url).await?.json::<Vec<BookSource>>().await.map(|mut book_source_list| {
        book_source_list.iter_mut().for_each(|book_source| {
            book_source.set_rule_type();
        });
        book_source_list
    })
}

#[cfg(test)]
mod tests {
    use crate::api::parse_book_source_api::parse_book_source_from_url;
    use crate::api::regex_helper::keys_regex;

    #[tokio::test]
    async fn test_parse_json() -> Result<(), reqwest::Error> {
        // 测试解析速度
        let vec = parse_book_source_from_url("https://github.moeyy.xyz/https://raw.githubusercontent.com/XIU2/Yuedu/master/shuyuan")
            .await?;
        let book = vec.get(0).unwrap();
        println!("{:?}", book);
        // 模拟搜索 匹配search_url的 {{xxx}} 将其提取出数组
        if let Some(search_url) = &book.search_url {
            let keys = keys_regex(search_url);
            let mut url = String::new();
            for key in keys {
                if key.contains("key") {
                    // 将 {{ + key + }} 替换为 test
                    url = search_url.replace(&format!("{{{{{key}}}}}"), "元").to_string();
                }
            }
            // 发起搜索请求
            let book = book.book_source_url.as_ref().unwrap();
            let search_url = format!("{}/{}", book, url);
            println!("{:?}", search_url);
        }
        Ok(())
    }
}