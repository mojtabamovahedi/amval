import 'package:bloc/bloc.dart';


class IsExpandedCubit extends Cubit<bool> {
  IsExpandedCubit() : super(false);

  void changeExpanded(bool input){
    emit(input);
  }
}
