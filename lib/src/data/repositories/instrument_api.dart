
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:dio/dio.dart';

class APIInstrument{

  Future<int?> create(FormData data) async {
    Dio dio = Dio();
    try{
      Response response = await dio.post(
        "$baseUrl/api/v1/instrument/",
        data: data,
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      return response.statusCode;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<List<InstrumentResponse>> getList() async {
    List<InstrumentResponse> instrumentResponse = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
        "$baseUrl/api/v1/instrument/",
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      if (response.statusCode == 200){
        instrumentResponse = (response.data as List).map((date) {
          return InstrumentResponse.fromJson(date);
        }).toList();
      }
      return instrumentResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<List<InstrumentResponse>> searchBySerialNumber(String serial) async {
    List<InstrumentResponse> instrumentResponse = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
        "$baseUrl/api/v1/instrument/?serial_code=$serial",
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      instrumentResponse = (response.data as List).map((date) {
        return InstrumentResponse.fromJson(date);
      }).toList();
      return instrumentResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}