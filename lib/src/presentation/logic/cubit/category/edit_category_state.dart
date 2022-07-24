part of 'edit_category_cubit.dart';

@immutable
abstract class EditCategoryState {}

class EditCategoryInitial extends EditCategoryState {}
class EditCategoryLoading extends EditCategoryState {}
class EditCategoryEdited extends EditCategoryState {}
class EditCategoryFault extends EditCategoryState {
  String message;
  EditCategoryFault({required this.message});
}
