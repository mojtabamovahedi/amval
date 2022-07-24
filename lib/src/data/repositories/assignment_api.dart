
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/assignment_response.dart';
import 'package:dio/dio.dart';

class APIassignment{
  Future<List<AssignmentResponse>> getAssignmentByInstrumentName(int id) async {
    List<AssignmentResponse> assignmentResponse = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
        '$baseUrl/api/v1/Assignment/?instrument=$id',
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      if(response.statusCode == 200){
        assignmentResponse = (response.data as List).map((json){
          return AssignmentResponse.fromJson(json);
        }).toList();
      }
      return assignmentResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
  
  Future<void> create(FormData data)async{
    Dio dio = Dio();
    try{
      Response response = await dio.post(
          "$baseUrl/api/v1/Assignment/",
          data: data,
          options: Options(headers: {'Authorization':'Bearer $ACCESS_TOKEN'}),
      );
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}
