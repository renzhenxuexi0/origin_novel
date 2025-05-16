import '../../domain/entities/bookshelf_entity.dart';
import '../dto/bookshelf_dto.dart';

/// 将BookshelfDto与BookshelfEntity相互转换的映射器
class BookshelfMapper {
  /// 将DTO转换为实体
  static BookshelfEntity toEntity(BookshelfDto dto) {
    return BookshelfEntity(
      id: dto.id,
      // TODO: Map other properties
    );
  }

  /// 将实体转换为DTO
  static BookshelfDto toDto(BookshelfEntity entity) {
    return BookshelfDto(
      id: entity.id,
      // TODO: Map other properties
    );
  }
}
