part of 'models.dart';

@freezed
@collection
class BookInfo with _$BookInfo {
  const BookInfo._();

  const factory BookInfo({
    required int id,
    required int bookSourceId,
    required String name,
    String? author,
    String? cover,
  }) = _BookInfo;

  factory BookInfo.fromJson(Map<String, dynamic> json) =>
      _$BookInfoFromJson(json);
}
