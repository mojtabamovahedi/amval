part of 'edit_unit_cubit.dart';

@immutable
abstract class EditUnitState {}

class EditUnitInitial extends EditUnitState {}
class EditUnitLoading extends EditUnitState {}
class EditUnitEdited extends EditUnitState {}
class EditUnitFault extends EditUnitState {}
