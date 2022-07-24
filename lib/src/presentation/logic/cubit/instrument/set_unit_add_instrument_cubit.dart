
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_unit_add_instrument_state.dart';

class SetUnitAddInstrumentCubit extends Cubit<SetUnitAddInstrumentState> {
  APIUnit repository;
  SetUnitAddInstrumentCubit({required this.repository}) : super(SetUnitAddInstrumentInitial());

  Future getUnit() async {
    List<UnitResponse> units = [];
    emit(SetUnitAddInstrumentLoading());
    try{
      units = await repository.getUnitList();
      emit(SetUnitAddInstrumentLoaded(units: units, unit: units.first));
    }catch (e){
      emit(SetUnitAddInstrumentFault(message: e.toString() ));
    }
  }

  Future reload() async {
    getUnit();
  }

  Future setUnit(List<UnitResponse> units, UnitResponse unit) async {
    emit(SetUnitAddInstrumentSetUnit(unit: unit));
    emit(SetUnitAddInstrumentLoaded(units: units,unit: unit));
  }
}
