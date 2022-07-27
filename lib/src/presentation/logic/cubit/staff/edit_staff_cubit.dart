import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'edit_staff_state.dart';

class EditStaffCubit extends Cubit<EditStaffState> {
  APIStaff repository;
  EditStaffCubit({required this.repository}) : super(EditStaffInitial());

  void editStaff(FormData data, int id) async {
    emit(EditStaffLoading());
    try{
      await repository.editStaff(data, id);
      emit(EditStaffSuccess());
    }catch(e){
      emit(EditStaffFault(message: e.toString()));
    }
  }
}
