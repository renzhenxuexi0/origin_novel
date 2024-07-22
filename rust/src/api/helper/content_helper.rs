use flutter_rust_bridge::frb;

#[frb(sync)]
pub fn handle_content(content: &str) -> String {
    content
        .lines()
        .map(str::trim)
        .filter(|line| !line.is_empty())
        .map(|line| {
            // 如果行以4个空格开头，则保持原样，否则添加4个空格
            if line.starts_with("    ") {
                line.to_string()
            } else {
                format!("    {}", line)
            }
        })
        .collect::<Vec<String>>()
        .join("\n")
}
