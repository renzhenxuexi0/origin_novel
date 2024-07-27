use crate::api::model::book_source::BookSource;
use crate::api::model::book_source::BookSourceData;

/// 从URL解析书源
pub async fn parse_book_source_from_url(url: &str) -> Result<Vec<BookSourceData>, reqwest::Error> {
    let vec = reqwest::get(url).await?.json::<Vec<BookSource>>().await?;

    // 使用map来处理每个BookSource，然后使用filter来过滤掉不需要的元素
    let processed_vec: Vec<BookSourceData> = vec
        .into_iter()
        .map(|mut book_source| {
            book_source.set_rule_types();
            let enabled = book_source.filter_book_source();
            book_source.enabled = Some(enabled);
            book_source.can_enable = Some(enabled);
            BookSourceData {
                book_source_json: serde_json::to_string(&book_source).unwrap(),
                book_source,
            }
        })
        .collect();

    Ok(processed_vec)
}

#[cfg(test)]
mod tests {
    use log::debug;

    fn init() {
        let _ = env_logger::builder().is_test(true).try_init();
    }

    #[tokio::test]
    async fn test_parse_json() -> Result<(), reqwest::Error> {
        init();
        // 测试解析速度
        let vec = super::parse_book_source_from_url("https://mirror.ghproxy.com/https://raw.githubusercontent.com/shidahuilang/shuyuan/shuyuan/good.json").await?;
        debug!("{:?}", vec[0]);
        Ok(())
    }
}
