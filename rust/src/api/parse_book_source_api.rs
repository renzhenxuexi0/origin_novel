pub use crate::api::model::book_source::BookSource;

/// 从URL解析书源
pub async fn parse_book_source_from_url(url: &str) -> Result<Vec<BookSource>, reqwest::Error> {
    let vec = reqwest::get(url)
        .await?
        .json::<Vec<BookSource>>()
        .await?;
    // 使用map来处理每个BookSource，然后使用filter来过滤掉不需要的元素
    let processed_vec: Vec<BookSource> = vec
        .into_iter()
        .map(|mut book_source| {
            book_source.set_rule_types();
            book_source
        })
        .filter(BookSource::filter_book_source)
        .collect();

    Ok(processed_vec)
}

#[cfg(test)]
mod tests {
    use log::debug;
    use reqwest::header::MAX_FORWARDS;
    use simple_logger::SimpleLogger;

    use crate::api::util::regex_util::keys_regex;

    #[tokio::test]
    async fn test_parse_json() -> Result<(), reqwest::Error> {
        SimpleLogger::new().init().unwrap();
        // 测试解析速度
        let vec = super::parse_book_source_from_url("https://github.moeyy.xyz/https://raw.githubusercontent.com/XIU2/Yuedu/master/shuyuan").await?;
        let book = vec.get(0).unwrap();
        // 模拟搜索 匹配search_url的 {{xxx}} 将其提取出数组
        if let Some(search_url) = &book.search_url {
            let search_urls = search_url.split(",").collect::<Vec<&str>>();
            let keys = keys_regex(search_urls[0]);
            let mut url = String::new();
            for key in keys {
                if key.contains("key") {
                    // 将 {{ + key + }} 替换为 test
                    url = search_url.replace(&format!("{{{{{key}}}}}"), "元").to_string();
                }
            }
            // 发起搜索请求
            let mut header_map = reqwest::header::HeaderMap::new();
            let value = serde_json::from_str::<serde_json::Value>(book.header.clone().unwrap().replace("'", "\"").as_str()).unwrap_or_else(|_e| {
                serde_json::Value::Null
            });
            if value.is_object() {
                for (key, value) in value.as_object().unwrap() {
                    let key = key.to_ascii_lowercase().parse::<reqwest::header::HeaderName>().unwrap();
                    let value = value.as_str().unwrap().parse().unwrap();
                    header_map.insert(
                        key,
                        value,
                    );
                }
            }
            let client = reqwest::Client::builder().default_headers(header_map).build().unwrap();
            let search_url = book.book_source_url.clone().unwrap() + &*url;
            let response = client.get(search_url).send().await.unwrap();
            debug!("测试请求结果 {:?}", response);
        }
        Ok(())
    }
}