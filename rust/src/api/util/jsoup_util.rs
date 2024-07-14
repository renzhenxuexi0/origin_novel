use std::error::Error;

use dom_query::{Document, Selection};
use flutter_rust_bridge::frb;

/// 解析 HTML 并根据给定的规则提取信息
///
/// # 参数
/// * `html` - 要解析的 HTML 字符串
/// * `rule` - 解析规则，由 '@' 分隔的多个子规则组成
///
/// # 返回值
/// 返回解析结果的字符串列表，或者错误
#[frb(ignore)]
pub fn parse_html_by_rule(html: &str, rule: &str) -> Result<Vec<String>, Box<dyn Error>> {
    // 从HTML字符串创建Document对象
    let document = Document::from(html);
    // 构建选择器和结果类型
    let (selector, result_type) = build_selector(rule);

    // 使用选择器在文档中选择元素
    let selection = document.select(&selector);
    // 从选择结果中提取数据
    Ok(extract_result(&selection, result_type))
}

/// 构建选择器和确定结果类型
///
/// # 参数
/// * `rule` - 解析规则字符串
///
/// # 返回值
/// 返回一个元组，包含构建的选择器字符串和结果类型（可能为空）
#[frb(ignore)]
fn build_selector(rule: &str) -> (String, String) {
    let parts: Vec<&str> = rule.split('@').collect();

    if parts.len() == 1 {
        // 如果只有一个部分，那么它就是选择器，没有特定的结果类型
        return (parse_selector_part(parts[0]), String::from("text"));
    }

    let result_type = parts.last().unwrap_or(&"html").to_string();
    let selector = parts
        .iter()
        .take(parts.len() - 1)
        .map(|&part| parse_selector_part(part))
        .collect::<Vec<_>>()
        .join(" ");

    (selector, result_type)
}

/// 解析单个选择器部分
///
/// # 参数
/// * `part` - 选择器部分字符串
///
/// # 返回值
/// 返回解析后的选择器字符串
#[frb(ignore)]
fn parse_selector_part(part: &str) -> String {
    let mut split = part.splitn(2, '.');
    match (split.next(), split.next()) {
        (Some("class"), Some(class)) => format!(".{}", class.replace(' ', ".")), // 处理类选择器
        (Some("id"), Some(id)) => format!("#{}", id),                            // 处理ID选择器
        (Some("tag"), Some(tag)) => tag.to_string(),                             // 处理标签选择器
        _ => part.to_string(), // 处理其他情况，包括直接的标签选择器
    }
}

/// 从选择结果中提取数据
///
/// # 参数
/// * `selection` - DOM查询的选择结果
/// * `result_type` - 结果类型（text、html或属性名）
///
/// # 返回值
/// 返回提取的字符串列表
#[frb(ignore)]
fn extract_result(selection: &Selection, result_type: String) -> Vec<String> {
    selection
        .iter()
        .map(|node| match result_type.as_str() {
            "text" => node.text().to_string(), // 提取文本内容
            "html" => node.html().to_string(), // 提取HTML内容
            attr => node.attr(attr).unwrap_or_default().to_string(), // 提取指定属性
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use std::fs::read_to_string;

    use log::info;

    use super::*;

    fn init() {
        let _ = env_logger::builder().is_test(true).try_init();
    }

    #[test]
    fn test_parse_html_by_rule() {
        // 初始化日志记录器
        init();

        // 读取测试用的HTML文件
        let html = read_to_string("src/assets/search.html").unwrap();

        // 测试用例：提取所有作者信息
        let result = parse_html_by_rule(&html, "class.top clearfix@class.s2@text").unwrap();
        info!("author: {:?}", result);

        // 可以添加更多的测试用例，如：
        // let names = parse_html_by_rule(&html, "class.top clearfix@tag.h1@tag.a@text").unwrap();
        // info!("names: {:?}", names);
        //
        // let intro = parse_html_by_rule(&html, "class.c@html").unwrap();
        // info!("intro: {:?}", intro);
        //
        // 等等...
    }
}
