
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/unit_response.dart';
import 'package:dio/dio.dart';

class APIUnit{

  Future<List<UnitResponse>> getUnitList() async {
    Dio dio = Dio();
    List<UnitResponse> unitResponse = [];
    try{
      Response response = await dio.get(
        "$baseUrl/api/v1/unit/",
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      if (response.statusCode == 200){
        unitResponse = (response.data as List).map((data){
          return UnitResponse.fromJson(data);
        }).toList();
      }
      return unitResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<CreateUnitResponse> createUnit(String name) async {
    Dio dio = Dio();
    late CreateUnitResponse createUnitResponse ;
    try{
      Response response = await dio.post(
        '$baseUrl/api/v1/unit/',
          options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
        data: {
          'name': name,
          'company': '1',
        }
      );
      if (response.statusCode == 201){
        createUnitResponse = CreateUnitResponse.fromJson(response.data);
      }
      return createUnitResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<List<UnitResponse>> searchUnit(String name) async {
    Dio dio = Dio();
    List<UnitResponse> unitResponse = [];
    try{
      Response response = await dio.get(
        "$baseUrl/api/v1/unit/?name=$name",
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      if (response.statusCode == 200){
        unitResponse = (response.data as List).map((data){
          return UnitResponse.fromJson(data);
        }).toList();
      }
      return unitResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<void> deleteUnit(int id) async {
    Dio dio = Dio();
    try{
      await dio.delete(
          "$baseUrl/api/v1/unit/$id",
          options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<void> editUnit(UnitResponse unit, String newName) async {
    Dio dio = Dio();
    try{
      await dio.put(
        "$baseUrl/api/v1/unit/${unit.id!.toInt()}",
        data: {
          "name":newName,
          "company" : unit.company
        },
        options: Options(
            headers: {
              'Authorization' : 'Bearer $ACCESS_TOKEN',
              'Content-Type' : 'application/x-www-form-urlencoded'
            }
        ),
      );
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}