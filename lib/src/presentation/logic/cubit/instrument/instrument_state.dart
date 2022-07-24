part of 'instrument_cubit.dart';

@immutable
abstract class InstrumentState {}

class InstrumentInitial extends InstrumentState {}

class InstrumentLoading extends InstrumentState {}

class InstrumentLoaded extends InstrumentState {
  List<InstrumentResponse> instruments;

  InstrumentLoaded({required this.instruments});
}

class InstrumentFault extends InstrumentState {
  final String message;

  InstrumentFault({required this.message});
}
