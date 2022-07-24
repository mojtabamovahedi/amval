
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_unit_state.dart';

class EditUnitCubit extends Cubit<EditUnitState> {
  APIUnit repository;
  EditUnitCubit({required this.repository}) : super(EditUnitInitial());

  void editUnit(UnitResponse unit, String newName) async {
    emit(EditUnitLoading());
    try{
      await repository.editUnit(unit, newName);
      emit(EditUnitEdited());
    }catch(e){
      emit(EditUnitFault());
    }
  }
}
