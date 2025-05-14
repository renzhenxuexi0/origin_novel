# 起源小说

## 项目介绍

起源小说是一款基于Flutter和Rust开发的小说阅读应用，采用阅读规则3.0标准。本项目受到 [legado](https://github.com/gedoor/legado) 项目的启发，在此特别感谢该开源项目的贡献。

## 技术栈

项目基于以下技术：
- Flutter (UI框架)
- Rust (后端逻辑)
- flutter_rust_bridge (Flutter和Rust的桥接)

flutter_rust_bridge 中文文档: [https://trdthg.github.io/flutter_rust_bindgen_book_zh](https://trdthg.github.io/flutter_rust_bindgen_book_zh)

## 测试环境

- Windows 11
- Android 10.0

## 开发环境设置

1. 安装 `Flutter` 开发环境 [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. 安装目标设备运行环境，例如 Android 需要安装 `Android Studio` 和 `Android SDK` [https://developer.android.com/studio](https://developer.android.com/studio)
3. 运行 `flutter doctor` 检查环境是否配置正确
4. 安装 `Rust` 开发环境 [https://www.rust-lang.org/tools/install](https://www.rust-lang.org/tools/install)
5. 安装 `flutter_rust_bridge_codegen`：
   ```bash
   cargo install flutter_rust_bridge_codegen
   ```

## 项目启动步骤

1. 在项目根目录运行 `flutter_rust_bridge_codegen generate` 生成 Rust 到 Dart 的桥接代码
2. 运行 `flutter pub run build_runner build -d` 生成 Flutter 模型代码
3. 运行 `flutter run` 启动项目

## 功能特点

- 基于阅读规则3.0标准
- 使用 Flutter 构建的现代化 UI
- Rust 后端提供高性能的数据处理
- 跨平台支持

## 许可证

本项目采用 MIT 许可证，详情请参见 LICENSE 文件。

## 鸣谢

特别感谢 [legado](https://github.com/gedoor/legado) 项目，本项目从中获得了宝贵的灵感和参考。