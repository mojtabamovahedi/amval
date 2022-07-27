
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/staff_response.dart';
import 'package:dio/dio.dart';

class APIStaff {
  Future<int?> addStuff(String firstName, String lastName, double nationalID,
      String phoneNumber) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        "$baseUrl/api/v1/staff/",
        data: {
          "username": phoneNumber.toString(),
          "password": nationalID.toString(),
          "first_name": firstName,
          "last_name": lastName,
          "national_id": nationalID,
          "company_id": 1,
        },
        options: Options(
            headers: {
              "Content-Type": 'application/x-www-form-urlencoded',
              'Authorization' : 'Bearer $ACCESS_TOKEN'
        }),
      );
      return response.statusCode;
    }on DioError catch (e) {
      throw(HandleError(e).getMessage());
    }
  }
  
  Future<List<StaffResponse>> getList() async {
    List<StaffResponse> staffs = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
          "$baseUrl/api/v1/staff/",
        options: Options(
            headers: {
              'Authorization' : 'Bearer $ACCESS_TOKEN',
            }),
      );
      if (response.statusCode == 200){
        staffs = (response.data as List).map((data){
          return StaffResponse.fromJson(data);
        }).toList();
      }
      return staffs;
    }on DioError catch (e){
      throw(HandleError(e).getMessage());
    }
  }
  
  Future<StaffResponse> retrieveStaff(int id) async{
    StaffResponse staffResponse ;
    Dio dio = Dio();
    try{
      Response response = await dio.get(
          "$baseUrl/api/v1/staff/$id",
          options: Options(headers: {'Authorization' : "Bearer $ACCESS_TOKEN"}),
      );
      staffResponse = StaffResponse.fromJson(response.data);
      return staffResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<List<StaffResponse>> searchStaff(String nationalId) async {
    List<StaffResponse> staffs = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
        "$baseUrl/api/v1/staff/?national_id=$nationalId",
        options: Options(
            headers: {
              'Authorization' : 'Bearer $ACCESS_TOKEN',
            }),
      );
      if (response.statusCode == 200){
        staffs = (response.data as List).map((data){
          return StaffResponse.fromJson(data);
        }).toList();
      }
      return staffs;
    }on DioError catch (e){
      throw(HandleError(e).getMessage());
    }
  }
  
  Future<void> editStaff(FormData data, int id) async{
    Dio dio = Dio();
    try{
      await dio.put(
          "$baseUrl/api/v1/staff/$id",
          data: data,
        options: Options(
            headers: {
              'Authorization' : "Bearer $ACCESS_TOKEN",
              'Content-Type' : "application/x-www-form-urlencoded",
            })
      );
    }on DioError catch(e){
      throw('$e');
    }
  }
  
  Future<void> deleteStaff(int id)async {
    Dio dio = Dio();
    try{
      await dio.delete(
          "$baseUrl/api/v1/staff/$id",
          options: Options(
              headers: {
                'Authorization' : "Bearer $ACCESS_TOKEN",
              })
      );
    }on DioError catch(e){
      throw('$e');
    }
  }
}
