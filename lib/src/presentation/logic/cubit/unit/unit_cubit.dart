
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  APIUnit repository;
  UnitCubit({required this.repository}) : super(UnitInitial());

  Future<void> getList() async {
    emit(UnitLoading());
    try{
      List<UnitResponse> unitList = await repository.getUnitList();
      emit(UnitLoaded(unitResponse: unitList));
    }catch(e){
      emit(UnitFault(message: '$e'));
    }
  }

  void searchUnit(String name) async {
    emit(UnitLoading());
    try{
      List<UnitResponse> unitList = await repository.searchUnit(name);
      emit(UnitLoaded(unitResponse: unitList));
    }catch(e){
      emit(UnitFault(message: '$e'));
    }
  }

}
