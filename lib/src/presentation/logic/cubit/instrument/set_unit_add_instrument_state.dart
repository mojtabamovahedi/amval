part of 'set_unit_add_instrument_cubit.dart';

@immutable
abstract class SetUnitAddInstrumentState {}

class SetUnitAddInstrumentInitial extends SetUnitAddInstrumentState {}

class SetUnitAddInstrumentLoading extends SetUnitAddInstrumentState {}

class SetUnitAddInstrumentFault extends SetUnitAddInstrumentState {
  final String message;

  SetUnitAddInstrumentFault({required this.message});
}

class SetUnitAddInstrumentLoaded extends SetUnitAddInstrumentState {
  List<UnitResponse> units;
  UnitResponse? unit;

  SetUnitAddInstrumentLoaded({required this.units,required this.unit});
}

class SetUnitAddInstrumentSetUnit extends SetUnitAddInstrumentState {
  final UnitResponse unit;

  SetUnitAddInstrumentSetUnit({required this.unit});
}
