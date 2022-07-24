part of 'assignment_cubit.dart';

@immutable
abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}
class AssignmentLoading extends AssignmentState {}
class AssignmentLoaded extends AssignmentState {
  List<AssignmentResponse> assignments;

  AssignmentLoaded({required this.assignments});
}
class AssignmentFault extends AssignmentState {
  final String message;

  AssignmentFault({required this.message});
}
