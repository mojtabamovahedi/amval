import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/Login_response.dart';
import 'package:dio/dio.dart';

class APILogin{

  Future<LoginResponse> login (String username, String password) async {
    late LoginResponse loginResponse;
    try{
      Dio dio = Dio();
      final response = await dio.post(
        '$baseUrl/auth/login/',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
      if(response.statusCode ==200){
        loginResponse = LoginResponse.fromJson(response.data);
      }
      ACCESS_TOKEN = loginResponse.access!;
      REFRESH_TOKEN = loginResponse.refresh!;
      return loginResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}