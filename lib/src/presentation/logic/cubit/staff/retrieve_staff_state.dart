part of 'retrieve_staff_cubit.dart';

@immutable
abstract class RetrieveStaffState {}

class RetrieveStaffNoStaff extends RetrieveStaffState {}

class RetrieveStaffLoading extends RetrieveStaffState {}

class RetrieveStaffGetStaff extends RetrieveStaffState {
  StaffResponse staff;

  RetrieveStaffGetStaff({required this.staff});
}
class RetrieveStaffFaultStaff extends RetrieveStaffState {
  final String message;

  RetrieveStaffFaultStaff({required this.message});
}
