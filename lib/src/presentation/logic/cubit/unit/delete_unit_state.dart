part of 'delete_unit_cubit.dart';

@immutable
abstract class DeleteUnitState {}

class DeleteUnitInitial extends DeleteUnitState {}
class DeleteUnitLoading extends DeleteUnitState {}
class DeleteUnitFault extends DeleteUnitState {
  String message;

  DeleteUnitFault({required this.message});
}
class DeleteUnitDeleted extends DeleteUnitState {}
