import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bookshelf_entity.dart';
import '../../domain/use_cases/bookshelf_use_case.dart';
import '../states/bookshelf_state.dart';

part 'bookshelf_provider.g.dart';

/// 管理Bookshelf状态的Provider
@riverpod
class Bookshelf extends _$Bookshelf {
  late final _useCase = ref.read(bookshelfUseCaseProvider);

  @override
  BookshelfState build() {
    // 初始状态
    return const BookshelfState();
  }

  /// 加载Bookshelf
  Future<void> load({bool forceRefresh = false}) async {
    state = BookshelfState.loading();

    try {
      final data = await _useCase.get(forceRefresh: forceRefresh);
      state = BookshelfState(data: data);
    } catch (e) {
      state = BookshelfState.error('加载失败: ${e.toString()}');
    }
  }

  /// 创建新的Bookshelf
  Future<void> create(BookshelfEntity entity) async {
    state = state.copyWith(isLoading: true);

    try {
      final created = await _useCase.create(entity);
      state = BookshelfState(data: created);
    } catch (e) {
      state = BookshelfState.error('创建失败: ${e.toString}');
    }
  }

  /// 更新Bookshelf
  Future<void> update(BookshelfEntity entity) async {
    state = state.copyWith(isLoading: true);

    try {
      final updated = await _useCase.update(entity);
      state = BookshelfState(data: updated);
    } catch (e) {
      state = BookshelfState.error('更新失败: ${e.toString}');
    }
  }

  /// 删除Bookshelf
  Future<void> delete(String id) async {
    state = state.copyWith(isLoading: true);

    try {
      await _useCase.delete(id);
      state = const BookshelfState();
    } catch (e) {
      state = BookshelfState.error('删除失败: ${e.toString()}');
    }
  }
}
