part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesFailure extends GetCategoriesState {
  final String errMessage;

  GetCategoriesFailure({required this.errMessage});
}

final class GetCategoriesSucecess extends GetCategoriesState {
  final List<CategoryEntity> categories;

  GetCategoriesSucecess({required this.categories});
}
