import '../../domain/entities/bookshelf_entity.dart';

/// BookshelfProvider的状态
class BookshelfState {
  final BookshelfEntity? data;
  final bool isLoading;
  final String? errorMessage;

  const BookshelfState({this.data, this.isLoading = false, this.errorMessage});

  // 用于显示加载状态的工厂方法
  factory BookshelfState.loading() => const BookshelfState(isLoading: true);

  // 用于显示错误状态的工厂方法
  factory BookshelfState.error(String message) =>
      BookshelfState(errorMessage: message);

  // 创建状态副本的方法
  BookshelfState copyWith({
    BookshelfEntity? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BookshelfState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
