part of 'create_assignment_cubit.dart';

@immutable
abstract class CreateAssignmentState {}

class CreateAssignmentInitial extends CreateAssignmentState {}
class CreateAssignmentLoading extends CreateAssignmentState {}
class CreateAssignmentSuccess extends CreateAssignmentState {
  final String message = "با موفقیت ثبت شد";
}
class CreateAssignmentFault extends CreateAssignmentState {
  final String message;

  CreateAssignmentFault({required this.message});
}
