part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {
  const CategoriesEvent();
}

final class CategoriesGetAllEvent extends CategoriesEvent {
  final int page;
  final int pageSize;

  const CategoriesGetAllEvent({required this.page, required this.pageSize});
}
