part of 'edit_staff_cubit.dart';

@immutable
abstract class EditStaffState {}

class EditStaffInitial extends EditStaffState {}
class EditStaffLoading extends EditStaffState {}
class EditStaffSuccess extends EditStaffState {}
class EditStaffFault extends EditStaffState {
  String message;

  EditStaffFault({required this.message});
}
