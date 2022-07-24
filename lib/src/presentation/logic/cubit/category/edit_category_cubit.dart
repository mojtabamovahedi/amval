
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  APICategory repository;
  EditCategoryCubit({required this.repository}) : super(EditCategoryInitial());

  void editCategory(CategoryResponse category, String newName) async {
    emit(EditCategoryLoading());
    try{
      await repository.editCategory(category, newName);
      emit(EditCategoryEdited());
    }catch(e){
      emit(EditCategoryFault(message: e.toString()));
    }
  }
}
