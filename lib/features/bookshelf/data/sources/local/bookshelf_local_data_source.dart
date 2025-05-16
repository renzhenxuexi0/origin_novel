import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dto/bookshelf_dto.dart';
import 'bookshelf_local_data_source_abstract.dart';

part 'bookshelf_local_data_source.g.dart';

/// 提供Bookshelf本地数据源的Provider
@riverpod
IBookshelfLocalDataSource bookshelfLocalDataSource(Ref ref) {
  return BookshelfLocalDataSource();
}

/// 本地数据源实现，处理Bookshelf相关的本地存储操作
class BookshelfLocalDataSource implements IBookshelfLocalDataSource {
  @override
  Future<BookshelfDto?> getLocalBookshelf() async {
    // TODO: Implement the logic to retrieve Bookshelf from local storage
    throw UnimplementedError('getLocalBookshelf not implemented');
  }

  @override
  Future<void> saveLocalBookshelf(BookshelfDto dto) async {
    // TODO: Implement the logic to save Bookshelf to local storage
    throw UnimplementedError('saveLocalBookshelf not implemented');
  }

  @override
  Future<void> deleteLocalBookshelf() async {
    // TODO: Implement the logic to delete Bookshelf from local storage
  }

  @override
  Future<bool> hasLocalBookshelfCache() async {
    // TODO: Implement the logic to check if Bookshelf is cached locally
    throw UnimplementedError('hasLocalBookshelfCache not implemented');
  }
}
