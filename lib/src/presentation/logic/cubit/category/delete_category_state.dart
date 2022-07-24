part of 'delete_category_cubit.dart';

@immutable
abstract class DeleteCategoryState {}

class DeleteCategoryInitial extends DeleteCategoryState {}
class DeleteCategoryLoading extends DeleteCategoryState {}
class DeleteCategoryDeleted extends DeleteCategoryState {}
class DeleteCategoryFault extends DeleteCategoryState {
  String message;

  DeleteCategoryFault({required this.message});
}
