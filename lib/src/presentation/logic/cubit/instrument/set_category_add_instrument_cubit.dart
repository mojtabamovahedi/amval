
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_category_add_instrument_state.dart';

class SetCategoryAddInstrumentCubit extends Cubit<SetCategoryAddInstrumentState> {
  APICategory repository;
  SetCategoryAddInstrumentCubit({required this.repository}) : super(SetCategoryAddInstrumentInitial());

  Future getCategory() async {
    List<CategoryResponse> categories = [];
    emit(SetCategoryAddInstrumentLoading());
    try{
      categories = await repository.getAllCategories();
      emit(SetCategoryAddInstrumentLoaded(categories: categories, category: categories.first));
    }catch (e){
      emit(SetCategoryAddInstrumentFault(message: e.toString()));
    }
  }

  Future reload() async {
    getCategory();
  }

  Future setCategory(List<CategoryResponse> categories, CategoryResponse category) async {
    emit(SetCategoryAddInstrumentSetCategory(category: category));
    emit(SetCategoryAddInstrumentLoaded(categories: categories, category: category));
  }

}
