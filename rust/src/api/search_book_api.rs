use std::collections::HashMap;
use std::error::Error;
use std::ops::Index;
use std::str::FromStr;

use flutter_rust_bridge::frb;
use log::{debug, error, info, trace};
use once_cell::sync::Lazy;
use reqwest::Client;
use reqwest::header::{CONTENT_TYPE, HeaderMap, HeaderName, HeaderValue};

use crate::api::model::rule::rule_search::{RuleSearch, RuleSearchField};
use crate::api::model::rule::rule_type::RuleType;
use crate::api::model::search_book::SearchBook;
use crate::api::parse_book_source_api::BookSource;
use crate::api::util::{jsoup_util, regex_util};

static REQUEST_CLIENT: Lazy<Client> = Lazy::new(Client::new);

/// 搜索书籍
pub async fn search_book(book_source: BookSource, keyword: String) -> Vec<SearchBook> {
    if let BookSource {
        book_source_url: Some(book_source_url),
        search_url: Some(search_url),
        rule_search: Some(rule_search),
        header,
        ..
    } = book_source
    {
        let result = search(book_source_url, &search_url, &keyword, header.as_ref())
            .await
            .map_err(|e| {
                error!("[搜索]: 请求搜索结果失败: {}", e.to_string());
            })
            .unwrap_or_default();

        create_search_books(&result, &rule_search)
            .map_err(|e| {
                error!("[搜索]: 解析搜索结果失败: {}", e.to_string());
            })
            .unwrap_or_default()
    } else {
        error!("[搜索]: 书源搜索规则错误");
        Vec::new()
    }
}

/// 处理字段
#[frb(ignore)]
fn process_field(
    html: &str,
    rule_search: &RuleSearch,
    field: &RuleSearchField,
    rule_type: RuleType,
) -> Result<Vec<String>, Box<dyn Error>> {
    let rule = match field {
        RuleSearchField::Author => rule_search.author.as_deref(),
        RuleSearchField::BookList => rule_search.book_list.as_deref(),
        RuleSearchField::BookUrl => rule_search.book_url.as_deref(),
        RuleSearchField::CoverUrl => rule_search.cover_url.as_deref(),
        RuleSearchField::Intro => rule_search.intro.as_deref(),
        RuleSearchField::Name => rule_search.name.as_deref(),
        RuleSearchField::WordCount => rule_search.word_count.as_deref(),
        RuleSearchField::Kind => rule_search.kind.as_deref(),
    };

    if let Some(rule) = rule {
        let result = match rule_type {
            RuleType::JsonPath => {
                // TODO: Implement JsonPath parsing
                Vec::new()
            }
            RuleType::Regex => {
                // TODO: Implement Regex parsing
                Vec::new()
            }
            RuleType::JsoupDefault => jsoup_util::parse_html_by_rule(html, rule)?,
            RuleType::JsoupCss => {
                // TODO: Implement JsoupCss parsing
                Vec::new()
            }
            RuleType::Js => {
                // TODO: Implement Js parsing
                Vec::new()
            }
            RuleType::XPath => {
                // TODO: Implement XPath parsing
                Vec::new()
            }
            RuleType::Unknown => {
                error!("[搜索]: 未知规则类型 for {:?}", field);
                Vec::new()
            }
        };

        info!(
            "[搜索]: 规则: {} 字段: {:?} 解析结果: {:?}",
            rule, field, result
        );

        Ok(result)
    } else {
        Ok(Vec::new())
    }
}

#[frb(ignore)]
fn create_search_books(
    html: &str,
    rule_search: &RuleSearch,
) -> Result<Vec<SearchBook>, Box<dyn Error>> {
    let mut field_results: HashMap<RuleSearchField, Vec<String>> = HashMap::new();

    for (field, rule_type) in rule_search.clone().rule_types.into_iter() {
        let result = process_field(html, rule_search, &field, rule_type)?;
        field_results.insert(field, result);
    }

    let len = field_results
        .get(&RuleSearchField::Name)
        .map_or(0, |v| v.len());
    let mut search_books = Vec::new();

    for i in 0..len {
        let search_book = SearchBook {
            author: field_results
                .get(&RuleSearchField::Author)
                .and_then(|v| v.get(i).cloned()),
            book_url: field_results
                .get(&RuleSearchField::BookUrl)
                .and_then(|v| v.get(i).cloned()),
            cover_url: field_results
                .get(&RuleSearchField::CoverUrl)
                .and_then(|v| v.get(i).cloned()),
            intro: field_results
                .get(&RuleSearchField::Intro)
                .and_then(|v| v.get(i).cloned()),
            name: field_results
                .get(&RuleSearchField::Name)
                .and_then(|v| v.get(i).cloned()),
            word_count: field_results
                .get(&RuleSearchField::WordCount)
                .and_then(|v| v.get(i).cloned()),
            kind: field_results
                .get(&RuleSearchField::Kind)
                .and_then(|v| v.get(i).cloned()),
        };
        search_books.push(search_book);
    }

    Ok(search_books)
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
            let url;
            if url_part.starts_with("http") || url_part.starts_with("https") {
                url = replace_keywords(url_part, keyword);
            } else {
                if book_source_url.index(book_source_url.len() - 1..) == "/" {
                    url = format!("{}{}", book_source_url, replace_keywords(url_part, keyword));
                } else {
                    url = format!(
                        "{}/{}",
                        book_source_url,
                        replace_keywords(url_part, keyword)
                    );
                }
            }
            debug!("[搜索]: 请求地址: {:?}", url);
            let headers = build_header(header)?;
            debug!("[搜索]: 请求头: {:?}", headers);
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
            debug!("[搜索]: 请求方法: {:?}", method);
            let body = options.get("body").map(|b| parse_body(b));
            debug!("[搜索]: 请求体: {:?}", body);

            send_request(&url, &headers, body.as_ref(), method).await
        }
        _ => Err("[搜索]: 搜索规则错误".into()),
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
        debug!("[搜索]: 请求头str: {:?}", header);
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
                HeaderName::from_str(&(header_name.to_ascii_lowercase()))
                    .map_err(|e| e.to_string())?,
                HeaderValue::from_str(&(header_value.to_ascii_lowercase()))
                    .map_err(|e| e.to_string())?,
            );
        }

        Ok(header_map)
    } else {
        let mut map = HeaderMap::new();
        map.insert(
            HeaderName::from_static("user-agent"),
            HeaderValue::from_static(
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36",
            ),
        );
        Ok(map)
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
        .headers(headers.clone())
        .timeout(std::time::Duration::from_secs(5));

    let response = if let Some(form_data) = body {
        request_builder.form(form_data).send().await?
    } else {
        request_builder.send().await?
    };

    let text = response.text().await?;
    trace!("[搜索]: 请求结果: {:?}", text);
    Ok(text)
}

#[cfg(test)]
mod tests {
    use log::{debug, info};

    use crate::api::parse_book_source_api::BookSource;

    fn init() {
        let _ = env_logger::builder()
            .filter_level(log::LevelFilter::Info)
            .is_test(true)
            .try_init();
    }
    #[tokio::test]
    async fn test_search_book() -> Result<(), Box<dyn std::error::Error>> {
        init();
        // 从文件读取 src/assets/book_source.json
        let json = std::fs::read_to_string("src/assets/book_source.json").unwrap();
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
        // 遍历搜索 搜到正确的书籍
        let book_source = vec.get(0).unwrap();
        debug!("[搜索]: 书源: {:?}", book_source.search_url);
        let result = super::search_book(book_source.clone(), "圣墟".to_string()).await;
        info!("{:?}", result);
        Ok(())
    }
}
