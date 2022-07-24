import 'package:amval/src/data/repositories/instrument_api.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'add_instrument_state.dart';

class AddInstrumentCubit extends Cubit<AddInstrumentState> {
  APIInstrument repository;
  AddInstrumentCubit({required this.repository}) : super(AddInstrumentInitial());

  Future<void> create(FormData data) async {
    emit(AddInstrumentLoading());
    try{
      await repository.create(data);
      emit(AddInstrumentSuccess(message: "با موفقیت ثبت شد"));
    }catch(e){
      emit(AddInstrumentFailure(message: e.toString()));
    }
  }
}
