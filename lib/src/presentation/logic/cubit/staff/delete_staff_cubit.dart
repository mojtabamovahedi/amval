import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_staff_state.dart';

class DeleteStaffCubit extends Cubit<DeleteStaffState> {
  APIStaff repository;
  DeleteStaffCubit({required this.repository}) : super(DeleteStaffInitial());

  void deleteStaff(int id) async {
    emit(DeleteStaffLoading());
    try{
      await repository.deleteStaff(id);
      emit(DeleteStaffDeleted());
    }catch(e){
      emit(DeleteStaffFault(message: e.toString()));
    }
  }
}
