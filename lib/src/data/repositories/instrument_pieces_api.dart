
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:dio/dio.dart';

import '../model/instrumentpieces_response.dart';

class APIInstrumentPieces{
  Future<List<InstrumentPiecesResponse>> getList(int instrument) async {
    List<InstrumentPiecesResponse> pieces = [];
    try{
      Dio dio = Dio();
      Response response = await dio.get(
          "$baseUrl/api/v1/instrumentpieces/?instruments=$instrument",
          options: Options(headers: {"Authorization" : "Bearer $ACCESS_TOKEN"}),
      );
      if (response.statusCode == 200){
        pieces = (response.data as List).map((data){
          return InstrumentPiecesResponse.fromJson(data);
        }).toList();
      }
      return pieces;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}