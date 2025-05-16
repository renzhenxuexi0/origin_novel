import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookshelf_dto.freezed.dart';
part 'bookshelf_dto.g.dart';

@freezed
sealed class BookshelfDto with _$BookshelfDto {
  const factory BookshelfDto({
    required String id,
    // TODO: Add more DTO properties
  }) = _BookshelfDto;

  factory BookshelfDto.fromJson(Map<String, Object?> json) =>
      _$BookshelfDtoFromJson(json);
}
