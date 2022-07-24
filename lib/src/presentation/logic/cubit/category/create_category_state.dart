part of 'create_category_cubit.dart';

@immutable
abstract class CreateCategoryState {}

class CreateCategoryInitial extends CreateCategoryState {}
class CreateCategoryLoading extends CreateCategoryState {}
class CreateCategorySuccess extends CreateCategoryState {
  CreateCategoryResponse createCategoryResponse;
  final String message = 'زیرمجموعه با موفقیت ثبت شد';

  CreateCategorySuccess({required this.createCategoryResponse});
}
class CreateCategoryFailure extends CreateCategoryState {
  final String message ;

  CreateCategoryFailure({required this.message});
}
