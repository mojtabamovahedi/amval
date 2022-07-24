
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:amval/src/data/repositories/instrument_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'instrument_state.dart';

class InstrumentCubit extends Cubit<InstrumentState> {
  APIInstrument repository;
  InstrumentCubit({required this.repository}) : super(InstrumentInitial());

  Future getList() async {
    emit(InstrumentLoading());
    try {
      List<InstrumentResponse> response = await repository.getList();
      emit(InstrumentLoaded(instruments: response));
    } catch (e){
      emit(InstrumentFault(message: e.toString()));
    }
  }


  Future searchBySerialNumber(String serial) async {
    emit(InstrumentLoading());
    try{
      List<InstrumentResponse> response = await repository.searchBySerialNumber(serial);
      emit(InstrumentLoaded(instruments: response));
    }catch(e){
      emit(InstrumentFault(message: e.toString()));
    }
  }
}
