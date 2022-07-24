part of 'staff_cubit.dart';

@immutable
abstract class StaffState {}

class StaffInitial extends StaffState {}
class StaffLoading extends StaffState {}
class StaffLoaded extends StaffState {
  List<StaffResponse> staffs;

  StaffLoaded({required this.staffs});
}

class StaffFault extends StaffState {
  final String message;

  StaffFault({required this.message});
}
