part of 'models.dart';

/// 阅读设置
/// [updateTime] 更新时间
/// [pageFlipType] 翻页类型
/// [fontSize] 字体大小
/// [fontHeight] 行高
/// [wordSpacing] 字间距
/// [letterSpacing] 行间距
/// [fontFamily] 字体
@freezed
@collection
class BookReadSetting with _$BookReadSetting {
  const factory BookReadSetting({
    required int id,
    required DateTime updateTime,
    required PageFlipType pageFlipType,
    double? fontSize,
    double? fontHeight,
    double? wordSpacing,
    double? letterSpacing,
    String? fontFamily,
  }) = _BookReadSetting;

  const BookReadSetting._();
}

enum PageFlipType {
  /// 左右滑动
  slideLeftOrRight(0),

  /// 上下滑动
  slideUpAndDown(1),
  ;

  const PageFlipType(this.value);

  final short value;
}
