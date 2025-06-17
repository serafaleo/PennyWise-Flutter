part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesFailureState extends CategoriesState {
  final Failure failure;

  const CategoriesFailureState({required this.failure});
}

final class CategoriesGetAllSuccessState extends CategoriesState {
  final List<CategoryEntity> entities;

  const CategoriesGetAllSuccessState({required this.entities});
}
