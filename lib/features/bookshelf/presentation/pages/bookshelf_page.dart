import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/bookshelf_provider.dart';
import '../states/bookshelf_state.dart';

/// Bookshelf功能的主页面
class BookshelfPage extends HookConsumerWidget {
  const BookshelfPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听Bookshelf状态
    final bookshelfState = ref.watch(bookshelfProvider);

    // 获取notifier以便调用方法
    final bookshelfNotifier = ref.read(bookshelfProvider.notifier);

    // 在页面加载时获取数据
    useEffect(() {
      // 延迟执行以避免在构建过程中调用setState
      Future.microtask(() => bookshelfNotifier.load());
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookshelf'),
        actions: [
          // 刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => bookshelfNotifier.load(forceRefresh: true),
          ),
        ],
      ),
      body: _buildBody(bookshelfState),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 添加新项目的操作
          // TODO: 实现添加逻辑
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BookshelfState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '出错了!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(state.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: 实现重试逻辑
              },
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    final data = state.data;
    if (data == null) {
      return const Center(child: Text('没有数据'));
    }

    // TODO: 显示实际数据
    return Center(child: Text('ID: ${data.id}'));
  }
}
