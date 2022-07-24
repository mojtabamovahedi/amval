part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFault extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryResponse> categories;
  CategoryLoaded({required this.categories});
}
