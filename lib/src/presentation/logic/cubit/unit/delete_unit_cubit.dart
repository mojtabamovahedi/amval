import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_unit_state.dart';

class DeleteUnitCubit extends Cubit<DeleteUnitState> {
  APIUnit repository;
  DeleteUnitCubit({required this.repository}) : super(DeleteUnitInitial());

  void deleteUnit(int id) async {
    emit(DeleteUnitLoading());
    try{
      await repository.deleteUnit(id);
      emit(DeleteUnitDeleted());
    }catch(e){
      emit(DeleteUnitFault(message: e.toString()));
    }
  }
}
