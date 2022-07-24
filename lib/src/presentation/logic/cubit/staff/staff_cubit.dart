
import 'package:amval/src/data/model/staff_response.dart';
import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  APIStaff repository;
  StaffCubit({required this.repository}) : super(StaffInitial());

  Future getList() async {
    emit(StaffLoading());
    try{
      List<StaffResponse> response = await repository.getList();
      emit(StaffLoaded(staffs: response));
    }catch(e){
      emit(StaffFault(message: e.toString()));
    }
  }
  
  Future refresh() async {
    try{
      List<StaffResponse> response = await repository.getList();
      emit(StaffLoaded(staffs: response));
    }catch(e){
      emit(StaffFault(message: e.toString()));
    }
  }

  void searchStaff(String nationalId) async {
    emit(StaffLoading());
    try{
      List<StaffResponse> response = await repository.searchStaff(nationalId);
      emit(StaffLoaded(staffs: response));
    }catch(e){
      emit(StaffFault(message: e.toString()));
    }
  }
}
