
import 'package:amval/src/data/model/assignment_response.dart';
import 'package:amval/src/data/repositories/assignment_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  APIassignment repository;
  AssignmentCubit({required this.repository}) : super(AssignmentInitial());
  
  void getAssignment(int id) async {
    emit(AssignmentLoading());
    try{
      List<AssignmentResponse> assignments = await repository.getAssignmentByInstrumentName(id);
      emit(AssignmentLoaded(assignments: assignments.reversed.toList()));
    }catch(e){
      emit(AssignmentFault(message: e.toString()));
    }
  }
  Future<void> refresh(int id) async {
    try{
      List<AssignmentResponse> assignments = await repository.getAssignmentByInstrumentName(id);
      emit(AssignmentLoaded(assignments: assignments.reversed.toList()));
    }catch(e){
      emit(AssignmentFault(message: e.toString()));
    }
  }
}
