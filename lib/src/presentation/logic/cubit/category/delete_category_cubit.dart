
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  APICategory repository;
  DeleteCategoryCubit({required this.repository}) : super(DeleteCategoryInitial());

  void deleteCategory(int id) async {
    emit(DeleteCategoryLoading());
    try{
      await repository.deleteCategory(id);
      emit(DeleteCategoryDeleted());
    }catch(e){
      emit(DeleteCategoryFault(message: e.toString()));
    }
  }


}
