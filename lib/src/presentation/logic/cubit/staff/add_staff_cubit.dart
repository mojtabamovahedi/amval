import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_staff_state.dart';

class AddStaffCubit extends Cubit<AddStaffState> {
  APIStaff repository;
  AddStaffCubit({required this.repository}) : super(AddStaffInitial());

  void addStaff(String firstName, String lastName, double nationalID,
      String phoneNumber)async {
    emit(AddStaffLoading());
    try{
      await repository.addStuff(firstName, lastName, nationalID, phoneNumber);
      emit(AddStaffSuccess(message: "کارمند باموفقیت افزوده شد."));
    }catch(e){
      emit(AddStaffFailure(message: "خطا در اتصال..."));
    }
  }
}
