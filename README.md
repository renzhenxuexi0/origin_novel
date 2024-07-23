# origin_novel

起源小说 (基于阅读规则3.0)

## 项目说明

项目基于 `flutter_rust_bridge` 和 `flutter` 开发.

flutter_rust_bridge 中文文档: (https://trdthg.github.io/flutter_rust_bindgen_book_zh).

## 测试环境

- windows 11
- Android 10.0

## 项目启动说明

1. 安装 `flutter` 开发环境 (https://flutter.dev/docs/get-started/install).
2. 安装需要运行的设备的环境, 例如 'Android' 需要安装 `Android Studio` .
   和 `Android SDK` (https://developer.android.com/studio).
3. 运行 `flutter doctor` 检查环境是否配置正确.
4. 安装 `rust` 开发环境 (https://www.rust-lang.org/tools/install).
5. 运行 `cargo install flutter_rust_bridge_codegen` 安装 `flutter_rust_bridge_codegen` .
6. 在项目根目录运行 `flutter_rust_bridge_codegen generate` 生成 `rust` 到 `dart` 的代码.
7. 运行 `flutter pub run build_runner build -d` 生成 `flutter` 模型代码.
8. 运行 `flutter pub run intl_utils:generate` 生成 `intl` 代码 或者安装 `Flutter intl` 插件.
9. 运行 `flutter run` 启动项目.

