import '../../dto/bookshelf_dto.dart';

/// 抽象远程数据源接口，处理Bookshelf相关的远程操作
abstract interface class IBookshelfRemoteDataSource {
  /// 获取Bookshelf
  Future<BookshelfDto> getBookshelf();

  /// 创建新的Bookshelf
  Future<BookshelfDto> createBookshelf(BookshelfDto dto);

  /// 更新Bookshelf
  Future<BookshelfDto> updateBookshelf(BookshelfDto dto);

  /// 删除Bookshelf
  Future<void> deleteBookshelf(String id);
}
