part of 'add_staff_cubit.dart';

@immutable
abstract class AddStaffState {}

class AddStaffInitial extends AddStaffState {}
class AddStaffLoading extends AddStaffState {}
class AddStaffSuccess extends AddStaffState {
  final String message;
  AddStaffSuccess({required this.message});
}
class AddStaffFailure extends AddStaffState {
  final String message;
  AddStaffFailure({required this.message});

}
