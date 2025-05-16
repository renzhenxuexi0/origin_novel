import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/bookshelf_dto.dart';
import 'bookshelf_remote_data_source_abstract.dart';

part 'bookshelf_remote_data_source.g.dart';

/// 提供Bookshelf远程数据源的Provider
@riverpod
IBookshelfRemoteDataSource bookshelfRemoteDataSource(Ref ref) {
  return BookshelfRemoteDataSource();
}

/// 远程数据源实现，处理Bookshelf相关的API请求
class BookshelfRemoteDataSource implements IBookshelfRemoteDataSource {
  @override
  Future<BookshelfDto> getBookshelf() async {
    // TODO: Implement the API call to fetch Bookshelf
    throw UnimplementedError('getBookshelf not implemented');
  }

  @override
  Future<BookshelfDto> createBookshelf(BookshelfDto dto) async {
    // TODO: Implement the API call to create Bookshelf
    throw UnimplementedError('createBookshelf not implemented');
  }

  @override
  Future<BookshelfDto> updateBookshelf(BookshelfDto dto) async {
    // TODO: Implement the API call to update Bookshelf
    throw UnimplementedError('updateBookshelf not implemented');
  }

  @override
  Future<void> deleteBookshelf(String id) async {
    // TODO: Implement the API call to delete Bookshelf
    throw UnimplementedError('deleteBookshelf not implemented');
  }
}
