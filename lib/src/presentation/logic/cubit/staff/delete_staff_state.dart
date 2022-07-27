part of 'delete_staff_cubit.dart';

@immutable
abstract class DeleteStaffState {}

class DeleteStaffInitial extends DeleteStaffState {}
class DeleteStaffLoading extends DeleteStaffState {}
class DeleteStaffFault extends DeleteStaffState {
  String message;

  DeleteStaffFault({required this.message});
}
class DeleteStaffDeleted extends DeleteStaffState {}
