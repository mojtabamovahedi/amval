
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_category_state.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  APICategory repository;
  CreateCategoryCubit({required this.repository}) : super(CreateCategoryInitial());

  Future<void> createCategory(String newCategoryName, int? parent) async {
    emit(CreateCategoryLoading());
    try{
      CreateCategoryResponse createCategoryResponse = await repository.createCategory(newCategoryName, 1, parent);
      emit(CreateCategorySuccess(createCategoryResponse: createCategoryResponse));
    }catch(e){
      emit(CreateCategoryFailure(message: '$e'));
    }
  }
}
