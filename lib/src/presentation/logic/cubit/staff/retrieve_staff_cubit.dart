
import 'package:amval/src/data/model/staff_response.dart';
import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'retrieve_staff_state.dart';

class RetrieveStaffCubit extends Cubit<RetrieveStaffState> {
  APIStaff repository;
  RetrieveStaffCubit({required this.repository}) : super(RetrieveStaffNoStaff());

  void getStaff(int id) async {
    emit(RetrieveStaffLoading());
    try{
      StaffResponse staffResponse = await repository.retrieveStaff(id);
      emit(RetrieveStaffGetStaff(staff: staffResponse));
    }catch(e){
      emit(RetrieveStaffFaultStaff(message: e.toString()));
    }
  }
}
