import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  APICategory repository;
  CategoryCubit({required this.repository}) : super(CategoryInitial());

  
  Future<void> getAllList() async {
    emit(CategoryLoading());
    try{
      List<CategoryResponse> groupNames = await repository.getCategoriesList();
      emit(CategoryLoaded(categories: groupNames));
    }catch(e){
      emit(CategoryFault());
    }
  }

  Future<void> searchCategory(String name) async{
    emit(CategoryLoading());
    try{
      List<CategoryResponse> groupNames = await repository.searchCategory(name);
      emit(CategoryLoaded(categories: groupNames));
    }catch(e){
      emit(CategoryFault());
    }
  }
}
