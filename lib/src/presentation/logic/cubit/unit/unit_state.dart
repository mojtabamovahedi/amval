part of 'unit_cubit.dart';

@immutable
abstract class UnitState {}

class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {}

class UnitLoaded extends UnitState {
  final List<UnitResponse> unitResponse;
  UnitLoaded({required this.unitResponse});
}

class UnitFault extends UnitState {
  final String message;
  UnitFault({required this.message});
}
