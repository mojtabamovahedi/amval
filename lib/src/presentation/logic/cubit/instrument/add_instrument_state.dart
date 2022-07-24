part of 'add_instrument_cubit.dart';

@immutable
abstract class AddInstrumentState {}

class AddInstrumentInitial extends AddInstrumentState {}
class AddInstrumentLoading extends AddInstrumentState {}

class AddInstrumentSuccess extends AddInstrumentState {
  final String message;
  AddInstrumentSuccess({required this.message});
}

class AddInstrumentFailure extends AddInstrumentState {
  final String message;
  AddInstrumentFailure({required this.message});
}
