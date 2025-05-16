# 生成页面代码

export def main [
    feature_name: string           # 特性名称
    capitalized_feature_name: string # 首字母大写的特性名称
    provider_name: string           # 驼峰式命名的特性名
] {
    let content = $"import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/($feature_name)_provider.dart';
import '../states/($feature_name)_state.dart';

/// ($capitalized_feature_name)功能的主页面
class ($capitalized_feature_name)Page extends HookConsumerWidget {
  const ($capitalized_feature_name)Page\({super.key}\);

  @override
  Widget build\(BuildContext context, WidgetRef ref\) {
    // 监听($capitalized_feature_name)状态
    final ($provider_name)State = ref.watch\(($provider_name)Provider\);
    
    // 获取notifier以便调用方法
    final ($provider_name)Notifier = ref.read\(($provider_name)Provider.notifier\);
    
    // 在页面加载时获取数据
    useEffect\(\(\) {
      // 延迟执行以避免在构建过程中调用setState
      Future.microtask\(\(\) => ($provider_name)Notifier.load\(\)\);
      return null;
    }, const []\);
    
    return Scaffold\(
      appBar: AppBar\(
        title: const Text\('($capitalized_feature_name)'\),
        actions: [
          // 刷新按钮
          IconButton\(
            icon: const Icon\(Icons.refresh\),
            onPressed: \(\) => ($provider_name)Notifier.load\(forceRefresh: true\),
          \),
        ],
      ),
      body: _buildBody\(($provider_name)State\),
      floatingActionButton: FloatingActionButton\(
        onPressed: \(\) {
          // 添加新项目的操作
          // TODO: 实现添加逻辑
        },
        child: const Icon\(Icons.add\),
      \),
    \);
  }
  
  Widget _buildBody\(($capitalized_feature_name)State state\) {
    if \(state.isLoading\) {
      return const Center\(child: CircularProgressIndicator\(\)\);
    }
    
    if \(state.errorMessage != null\) {
      return Center\(
        child: Column\(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text\(
              '出错了!',
              style: const TextStyle\(fontSize: 20, fontWeight: FontWeight.bold\),
            \),
            const SizedBox\(height: 8\),
            Text\(state.errorMessage!\),
            const SizedBox\(height: 16\),
            ElevatedButton\(
              onPressed: \(\) {
                // TODO: 实现重试逻辑
              },
              child: const Text\('重试'\),
            \),
          ],
        \),
      \);
    }
    
    final data = state.data;
    if \(data == null\) {
      return const Center\(child: Text\('没有数据'\)\);
    }
    
    // TODO: 显示实际数据
    return Center\(
      child: Text\('ID: ${data.id}'\),
    \);
  }
}"
    
    create_file $"lib/features/($feature_name)/presentation/pages/($feature_name)_page.dart" $content
}
