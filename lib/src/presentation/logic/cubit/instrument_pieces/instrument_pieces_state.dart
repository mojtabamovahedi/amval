part of 'instrument_pieces_cubit.dart';

@immutable
abstract class InstrumentPiecesState {}

class InstrumentPiecesInitial extends InstrumentPiecesState {}

class InstrumentPiecesLoading extends InstrumentPiecesState {}

class InstrumentPiecesLoaded extends InstrumentPiecesState {
  List<InstrumentPiecesResponse> InstrumentPieces = [];

  InstrumentPiecesLoaded({required this.InstrumentPieces});
}

class InstrumentPiecesFault extends InstrumentPiecesState {
  final String massage;
  InstrumentPiecesFault({required this.massage});
}
