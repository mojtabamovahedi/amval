
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APISplash{

  Future getNewAccessToken() async {
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refresh");

    try{
      Response response = await dio.post(
        '$baseUrl/auth/login/refresh/',
        data: {
          'refresh': refreshToken,
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
      return response.data['refresh'];
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}