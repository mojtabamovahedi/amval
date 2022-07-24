import 'package:bloc/bloc.dart';

class IsVisiblePasswordCubit extends Cubit<bool> {
  IsVisiblePasswordCubit() : super(true);

  void changeVisibility(bool input){
    emit(input);
  }
}
