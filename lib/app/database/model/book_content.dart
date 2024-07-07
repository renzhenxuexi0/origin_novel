part of 'models.dart';

// 每个章节的内容
@freezed
@collection
class BookChapterContent with _$BookChapterContent {
  const factory BookChapterContent({
    required int id,
    required DateTime updateTime,
    required int bookId,
    required int chapter,
    required String content,
    required List<String> pageContent,
  }) = _BookChapterContent;
}
