import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookshelf_entity.freezed.dart';

@freezed
sealed class BookshelfEntity with _$BookshelfEntity {
  const factory BookshelfEntity({
    required String id,
    // TODO: Add more entity properties
  }) = _BookshelfEntity;
}
