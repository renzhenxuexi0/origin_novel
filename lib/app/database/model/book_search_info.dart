part of 'models.dart';

@freezed
@collection
class BookSearchInfo with _$BookSearchInfo {
  const BookSearchInfo._();

  const factory BookSearchInfo({
    required int id,
    required int bookSourceId,
    String? author,
    String? bookUrl,
    String? coverUrl,
    String? intro,
    String? name,
    String? wordCount,
    String? kind,
  }) = _BookSearchInfo;

  factory BookSearchInfo.fromJson(Map<String, dynamic> json) =>
      _$BookSearchInfoFromJson(json);
}
