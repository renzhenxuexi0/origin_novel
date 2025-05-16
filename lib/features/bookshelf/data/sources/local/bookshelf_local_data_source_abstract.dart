import '../../dto/bookshelf_dto.dart';

/// 抽象本地数据源接口，处理Bookshelf相关的本地存储操作
abstract interface class IBookshelfLocalDataSource {
  /// 获取本地存储的Bookshelf
  Future<BookshelfDto?> getLocalBookshelf();

  /// 保存Bookshelf到本地
  Future<void> saveLocalBookshelf(BookshelfDto dto);

  /// 从本地删除Bookshelf
  Future<void> deleteLocalBookshelf();

  /// 检查本地是否有缓存的Bookshelf
  Future<bool> hasLocalBookshelfCache();
}
