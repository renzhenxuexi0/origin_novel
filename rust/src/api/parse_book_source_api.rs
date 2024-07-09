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
            let enabled = book_source.filter_book_source();
            book_source.enabled = Some(enabled);
            book_source.can_enable = Some(enabled);
            book_source
        })
        .collect();

    Ok(processed_vec)
}

#[cfg(test)]
mod tests {
    use log::debug;
    use simple_logger::SimpleLogger;

    #[tokio::test]
    async fn test_parse_json() -> Result<(), reqwest::Error> {
        SimpleLogger::new().init().unwrap();
        // 测试解析速度
        let vec = super::parse_book_source_from_url("https://mirror.ghproxy.com/https://raw.githubusercontent.com/shidahuilang/shuyuan/shuyuan/good.json").await?;
        debug!("{:?}", vec[0]);
        Ok(())
    }
}