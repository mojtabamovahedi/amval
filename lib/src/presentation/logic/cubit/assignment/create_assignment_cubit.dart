import 'package:amval/src/data/repositories/assignment_api.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'create_assignment_state.dart';

class CreateAssignmentCubit extends Cubit<CreateAssignmentState> {
  APIassignment repository;
  CreateAssignmentCubit({required this.repository}) : super(CreateAssignmentInitial());

  void create(FormData data) async {
    emit(CreateAssignmentLoading());
    try{
      await repository.create(data);
      emit(CreateAssignmentSuccess());
    }catch(e){
      emit(CreateAssignmentFault(message: e.toString()));
    }
  }
}
