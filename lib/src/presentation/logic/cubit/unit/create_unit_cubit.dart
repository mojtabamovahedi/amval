
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_unit_state.dart';

class CreateUnitCubit extends Cubit<CreateUnitState> {
  APIUnit repository;
  CreateUnitCubit({required this.repository}) : super(CreateUnitInitial());

  Future<void> pressedAddUnit(String name) async {
    emit(CreateUnitLoading());
    try{
      CreateUnitResponse createUnitResponse = await APIUnit().createUnit(name);
      emit(CreateUnitSuccess(createUnitResponse: createUnitResponse));
    }catch(e){
      emit(CreateUnitFailure(message: e.toString()));
    }
  }
}
