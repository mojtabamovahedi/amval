import 'package:amval/src/config/storage/constants.dart';
import 'package:bloc/bloc.dart';


class SetCaptureCubit extends Cubit<bool> {
  SetCaptureCubit() : super(false);

  void setCapture(String location){
    capturePath = location;
    emit(true);
  }

  void removeCapture(){
    capturePath = "";
    emit(false);
  }
}
