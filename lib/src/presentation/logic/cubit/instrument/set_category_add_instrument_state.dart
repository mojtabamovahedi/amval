part of 'set_category_add_instrument_cubit.dart';

@immutable
abstract class SetCategoryAddInstrumentState {}

class SetCategoryAddInstrumentInitial extends SetCategoryAddInstrumentState {}

class SetCategoryAddInstrumentLoading extends SetCategoryAddInstrumentState {}

class SetCategoryAddInstrumentFault extends SetCategoryAddInstrumentState {
  final String message;

  SetCategoryAddInstrumentFault({required this.message});
}

class SetCategoryAddInstrumentLoaded extends SetCategoryAddInstrumentState {
  List<CategoryResponse> categories;
  CategoryResponse? category;

  SetCategoryAddInstrumentLoaded({required this.categories,required this.category});
}

class SetCategoryAddInstrumentSetCategory extends SetCategoryAddInstrumentState {
  final CategoryResponse category;

  SetCategoryAddInstrumentSetCategory({required this.category});
}
