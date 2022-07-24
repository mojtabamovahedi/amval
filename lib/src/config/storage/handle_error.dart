import 'package:dio/dio.dart';

class HandleError{
  DioError error;

  HandleError(this.error);

  String getMessage(){
    if (error.response!.statusCode == 401){
      return "نام کاربری یا پسورد اشتباه است";
    }
    else if (error.response!.statusCode == 406){
      return "متاسفانه خطایی به وجود امده است";
    }
    else if (error.response!.statusCode == 406){
      return "فیلد مورد نظ شما وجود ندارد";
    }else{
      return error.message;
    }
  }
}