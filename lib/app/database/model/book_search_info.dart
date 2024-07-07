part of 'models.dart';

@freezed
@collection
class BookSearchInfo with _$BookSearchInfo {
  const BookSearchInfo._();

  const factory BookSearchInfo({
    required int id,
    required int bookSourceId,
    required String searchUrl,
    required String method,
    required String charset,
    String? headers,
    String? body,
  }) = _BookSearchInfo;

  factory BookSearchInfo.fromJson(Map<String, dynamic> json) =>
      _$BookSearchInfoFromJson(json);
}
