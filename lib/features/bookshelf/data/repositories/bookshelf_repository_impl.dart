import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bookshelf_entity.dart';
import '../../domain/repositories/bookshelf_repository.dart';
import '../mappers/bookshelf_mapper.dart';
import '../sources/local/bookshelf_local_data_source.dart';
import '../sources/local/bookshelf_local_data_source_abstract.dart';
import '../sources/remote/bookshelf_remote_data_source.dart';
import '../sources/remote/bookshelf_remote_data_source_abstract.dart';

part 'bookshelf_repository_impl.g.dart';

/// 提供BookshelfRepository的Provider
@riverpod
IBookshelfRepository bookshelfRepository(Ref ref) {
  final remoteDataSource = ref.watch(bookshelfRemoteDataSourceProvider);
  final localDataSource = ref.watch(bookshelfLocalDataSourceProvider);
  return BookshelfRepositoryImpl(remoteDataSource, localDataSource);
}

/// BookshelfRepository的实现
class BookshelfRepositoryImpl implements IBookshelfRepository {
  final IBookshelfRemoteDataSource _remoteDataSource;
  final IBookshelfLocalDataSource _localDataSource;

  const BookshelfRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BookshelfEntity> getBookshelf({bool forceRefresh = false}) async {
    // 检查是否有本地缓存且不强制刷新
    if (!forceRefresh && await _localDataSource.hasLocalBookshelfCache()) {
      final localDto = await _localDataSource.getLocalBookshelf();
      if (localDto != null) {
        return BookshelfMapper.toEntity(localDto);
      }
    }

    // 从远程获取数据
    try {
      final remoteDto = await _remoteDataSource.getBookshelf();
      // 缓存到本地
      await _localDataSource.saveLocalBookshelf(remoteDto);
      return BookshelfMapper.toEntity(remoteDto);
    } catch (e) {
      // 如果远程获取失败，尝试从本地获取
      final localDto = await _localDataSource.getLocalBookshelf();
      if (localDto != null) {
        return BookshelfMapper.toEntity(localDto);
      }
      rethrow; // 如果本地也没有，则重新抛出异常
    }
  }

  @override
  Future<BookshelfEntity> createBookshelf(BookshelfEntity entity) async {
    final dto = BookshelfMapper.toDto(entity);
    final createdDto = await _remoteDataSource.createBookshelf(dto);
    await _localDataSource.saveLocalBookshelf(createdDto);
    return BookshelfMapper.toEntity(createdDto);
  }

  @override
  Future<BookshelfEntity> updateBookshelf(BookshelfEntity entity) async {
    final dto = BookshelfMapper.toDto(entity);
    final updatedDto = await _remoteDataSource.updateBookshelf(dto);
    await _localDataSource.saveLocalBookshelf(updatedDto);
    return BookshelfMapper.toEntity(updatedDto);
  }

  @override
  Future<void> deleteBookshelf(String id) async {
    await _remoteDataSource.deleteBookshelf(id);
    await _localDataSource.deleteLocalBookshelf();
  }
}
