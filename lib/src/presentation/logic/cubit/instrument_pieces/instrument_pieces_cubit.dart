
import 'package:amval/src/data/model/instrumentpieces_response.dart';
import 'package:amval/src/data/repositories/instrument_pieces_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'instrument_pieces_state.dart';

class InstrumentPiecesCubit extends Cubit<InstrumentPiecesState> {
  APIInstrumentPieces repository;
  InstrumentPiecesCubit({required this.repository}) : super(InstrumentPiecesInitial());

  void getList(int instrument) async {
    emit(InstrumentPiecesLoading());
    try{
      List<InstrumentPiecesResponse> pieces = await repository.getList(instrument);
      emit(InstrumentPiecesLoaded(InstrumentPieces: pieces));
    }catch(e){
      emit(InstrumentPiecesFault(massage: e.toString()));
    }
  }
}
