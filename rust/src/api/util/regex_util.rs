use flutter_rust_bridge::frb;
use once_cell::sync::Lazy;
use regex::Regex;

/// 从字符串中提取 {{xxx}} 的 xxx内容
#[frb(ignore)]
pub fn keys_regex(s: &str) -> Vec<String> {
    static RE: Lazy<Regex> = Lazy::new(|| Regex::new(r"\{\{([^}]*)}}").unwrap());
    let mut keys = vec![];
    for cap in RE.captures_iter(s) {
        keys.push(cap[1].to_string());
    }
    keys
}