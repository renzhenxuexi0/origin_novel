import '../entities/bookshelf_entity.dart';

/// 抽象仓库接口，定义Bookshelf相关的业务操作
abstract interface class IBookshelfRepository {
  /// 获取Bookshelf，可选是否强制刷新
  Future<BookshelfEntity> getBookshelf({bool forceRefresh = false});

  /// 创建新的Bookshelf
  Future<BookshelfEntity> createBookshelf(BookshelfEntity entity);

  /// 更新Bookshelf
  Future<BookshelfEntity> updateBookshelf(BookshelfEntity entity);

  /// 删除Bookshelf
  Future<void> deleteBookshelf(String id);
}
