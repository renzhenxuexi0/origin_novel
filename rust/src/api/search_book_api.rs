use std::collections::HashMap;
use std::ops::Add;
use std::str::FromStr;

use flutter_rust_bridge::frb;
use log::{debug, error};
use reqwest::header::{HeaderMap, HeaderName, HeaderValue};

use crate::api::parse_book_source_api::BookSource;
use crate::api::util::regex_util;

/// 搜索书籍
pub async fn search_book(book_source: BookSource, keyword: String) -> Result<(), reqwest::Error> {
    // 模拟搜索 匹配search_url的 {{xxx}} 将其提取出数组
    if let (Some(search_url), Some(book_source_url)) = (book_source.search_url, book_source.book_source_url) {
        // 构建请求头
        let header_map = build_header(book_source.header).unwrap_or_else(|e| {
            error!("[搜索]: 构建请求头失败: {:?}", e);
            HeaderMap::new()
        });
        // 构建请求url
        let mut url = book_source_url.clone();
        let split: Vec<&str> = search_url.split(',').collect();
        // 判断长度
        match split.len() {
            1 => {
                let setting_keywords = regex_util::keys_regex(&search_url);
                for setting_keyword in setting_keywords {
                    // TODO 目前只做了get的请求
                    if setting_keyword.contains("key") {
                        // 将 {{ + key + }} 替换为 test
                        url = url.add(&search_url.replace(&format!("{{{{{setting_keyword}}}}}"), &keyword))
                    }
                }
            }
            // 说明有请求体 或者其他请求方式
            2 => {
                let setting_keywords = regex_util::keys_regex(&search_url);
                for setting_keyword in setting_keywords {
                    // TODO 目前只做了get的请求
                    if setting_keyword.contains("key") {
                        // 将 {{ + key + }} 替换为 test
                        url = url.add(&split[0].replace(&format!("{{{{{setting_keyword}}}}}"), &keyword))
                    }
                }
            }
            _ => {
                error!("[搜索]: search_url格式错误: {:?}", search_url);
            }
        }
        // 发起请求
        let response = reqwest::Client::new()
            .get(&url)
            .headers(header_map)
            .send()
            .await?;
        debug!("[搜索]: 请求结果: {:?}", response.bytes().await.unwrap());
        // TODO 解析返回值
    }
    Ok(())
}


/// 构建请求头
#[frb(ignore)]
fn build_header(headers_str: Option<String>) -> Result<HeaderMap, String> {
    if let Some(headers_str) = headers_str {
        let headers_str = headers_str.replace("'", "\"");
        let headers: HashMap<String, String> = serde_json::from_str(&headers_str).map_err(|e| e.to_string())?;
        let mut header_map = HeaderMap::new();

        for (header_name, header_value) in headers.into_iter() {
            header_map.insert(HeaderName::from_str(&header_name).map_err(|e| e.to_string())?,
                              HeaderValue::from_str(&header_value).map_err(|e| e.to_string())?);
        }

        Ok(header_map)
    } else {
        Err("请求头为空".to_string())
    }
}

#[cfg(test)]
mod tests {
    use simple_logger::SimpleLogger;

    use crate::api::parse_book_source_api::parse_book_source_from_url;

    #[tokio::test]
    async fn test_search_book() -> Result<(), Box<dyn std::error::Error>> {
        SimpleLogger::new().init().unwrap();
        // 测试解析速度
        let vec = parse_book_source_from_url("https://mirror.ghproxy.com/https://raw.githubusercontent.com/shidahuilang/shuyuan/shuyuan/good.json").await?;
        vec.into_iter().filter(|book_source| book_source.enabled.unwrap()).for_each(|book_source| {
            let _ = super::search_book(book_source, "神".to_string());
        });
        Ok(())
    }
}
