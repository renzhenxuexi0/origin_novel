import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/bookshelf_repository_impl.dart';
import '../entities/bookshelf_entity.dart';
import '../repositories/bookshelf_repository.dart';

part 'bookshelf_use_case.g.dart';

/// 获取BookshelfUseCase的Provider
@riverpod
BookshelfUseCase bookshelfUseCase(Ref ref) {
  final repository = ref.watch(bookshelfRepositoryProvider);
  return BookshelfUseCase(repository);
}

/// Bookshelf相关的用例
class BookshelfUseCase {
  final IBookshelfRepository _repository;

  const BookshelfUseCase(this._repository);

  /// 获取Bookshelf
  Future<BookshelfEntity> get({bool forceRefresh = false}) async {
    return _repository.getBookshelf(forceRefresh: forceRefresh);
  }

  /// 创建新的Bookshelf
  Future<BookshelfEntity> create(BookshelfEntity entity) async {
    return _repository.createBookshelf(entity);
  }

  /// 更新Bookshelf
  Future<BookshelfEntity> update(BookshelfEntity entity) async {
    return _repository.updateBookshelf(entity);
  }

  /// 删除Bookshelf
  Future<void> delete(String id) async {
    return _repository.deleteBookshelf(id);
  }
}
