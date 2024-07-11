use std::collections::HashMap;
use std::error::Error;
use std::str::FromStr;

use flutter_rust_bridge::frb;
use log::{debug, error};
use once_cell::sync::Lazy;
use reqwest::Client;
use reqwest::header::{CONTENT_TYPE, HeaderMap, HeaderName, HeaderValue};

use crate::api::model::search_book::SearchBook;
use crate::api::parse_book_source_api::BookSource;
use crate::api::util::regex_util;

static REQUEST_CLIENT: Lazy<reqwest::Client> = Lazy::new(Client::new);

/// 搜索书籍
pub async fn search_book(
    book_source: BookSource,
    keyword: String,
) -> Result<Vec<SearchBook>, reqwest::Error> {
    if let BookSource {
        book_source_url: Some(book_source_url),
        search_url: Some(search_url),
        header,
        ..
    } = book_source
    {
        let result = search(book_source_url, &search_url, &keyword, header.as_ref()).await;
        debug!("请求结果: {:?}", result);

        // TODO: 解析返回值
    }
    Ok(())
}

/// 搜索
#[frb(ignore)]
async fn search(
    book_source_url: String,
    search_url: &str,
    keyword: &str,
    header: Option<&String>,
) -> Result<String, Box<dyn Error>> {
    let parts: Vec<&str> = search_url.splitn(2, ',').collect();

    match parts.as_slice() {
        [url_part] => {
            let url = format!("{}{}", book_source_url, replace_keywords(url_part, keyword));
            let headers = build_header(header)?;
            send_request(&url, &headers, None, "GET").await
        }
        [url_part, options_part] => {
            let url = format!("{}{}", book_source_url, replace_keywords(url_part, keyword));
            let options = parse_options(replace_keywords(options_part, keyword))?;

            let mut headers = build_header(header)?;
            if let Some(charset) = options.get("charset") {
                headers.insert(
                    CONTENT_TYPE,
                    HeaderValue::from_str(&format!("charset={}", charset))?,
                );
            }

            let method = options.get("method").map(String::as_str).unwrap_or("GET");
            let body = options.get("body").map(|b| parse_body(b));

            send_request(&url, &headers, body.as_ref(), method).await
        }
        _ => Err("搜索规则错误".into()),
    }
}

/// 解析选项
#[frb(ignore)]
fn parse_options(options_str: String) -> Result<HashMap<String, String>, Box<dyn Error>> {
    Ok(serde_json::from_str(&options_str)?)
}

/// 解析请求体
#[frb(ignore)]
fn parse_body(body: &str) -> HashMap<String, String> {
    body.split('&')
        .filter_map(|item| {
            let mut parts = item.splitn(2, '=');
            Some((
                parts.next()?.to_string(),
                parts.next().unwrap_or("").to_string(),
            ))
        })
        .collect()
}

/// 替换关键字
#[frb(ignore)]
fn replace_keywords(text: &str, keyword: &str) -> String {
    regex_util::keys_regex(text)
        .iter()
        .filter(|&k| k.contains("key"))
        .fold(String::from(text), |acc, k| {
            acc.replace(&format!("{{{{{}}}}}", k), keyword)
        })
}

/// 构建请求头
#[frb(ignore)]
pub fn build_header(header_str: Option<&String>) -> Result<HeaderMap, Box<dyn Error>> {
    if let Some(header) = header_str {
        debug!("请求头str: {:?}", header);
        let mut headers_str = header.replace("'", "\"");
        if headers_str.starts_with("Mozilla/5.0") {
            headers_str.insert_str(0, "{\"User-Agent\": \"");
            headers_str.push_str("\"}");
        }
        let headers: HashMap<String, String> = serde_json::from_str(&headers_str).map_err(|e| {
            error!("[搜索]: 请求头格式错误: {}", e.to_string());
            e
        })?;
        let mut header_map = HeaderMap::new();

        for (header_name, header_value) in headers.into_iter() {
            header_map.insert(
                HeaderName::from_str(&header_name).map_err(|e| e.to_string())?,
                HeaderValue::from_str(&header_value).map_err(|e| e.to_string())?,
            );
        }

        Ok(header_map)
    } else {
        Ok(HeaderMap::new())
    }
}

/// 发送请求
#[frb(ignore)]
async fn send_request(
    url: &str,
    headers: &HeaderMap,
    body: Option<&HashMap<String, String>>,
    method: &str,
) -> Result<String, Box<dyn Error>> {
    let request_builder = match method.to_ascii_lowercase().as_str() {
        "post" => REQUEST_CLIENT.post(url),
        _ => REQUEST_CLIENT.get(url),
    }
    .headers(headers.clone());

    let response = if let Some(form_data) = body {
        request_builder.form(form_data).send().await?
    } else {
        request_builder.send().await?
    };

    let text = response.text().await?;
    debug!("[搜索]: 请求结果: {:?}", text);
    Ok(text)
}

#[cfg(test)]
mod tests {
    use log::debug;
    use simple_logger::SimpleLogger;

    use crate::api::parse_book_source_api::BookSource;

    #[tokio::test]
    async fn test_search_book() -> Result<(), Box<dyn std::error::Error>> {
        SimpleLogger::new().init().unwrap();
        // 从文件读取"D:\document\test-document\test-document-txt\book_soruce.txt"
        let json =
            std::fs::read_to_string("D:\\document\\test-document\\test-document-txt\\good.json")
                .unwrap();
        let vec = serde_json::from_str::<Vec<BookSource>>(&json).unwrap();
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
        let vec = processed_vec
            .into_iter()
            .filter(|book_source| book_source.enabled.unwrap_or_else(|| false))
            .collect::<Vec<_>>();
        let book_source = vec.get(0).unwrap();
        debug!("{:?}", book_source);
        super::search_book(book_source.clone(), "test".to_string()).await?;
        Ok(())
    }
}
