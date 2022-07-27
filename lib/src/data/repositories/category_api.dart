
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/config/storage/handle_error.dart';
import 'package:amval/src/data/model/category_response.dart';
import 'package:dio/dio.dart';

class APICategory{

  Future<List<CategoryResponse>> getAllCategories() async {
    List<CategoryResponse> categoriesResponse = [];
    Dio dio = Dio();
    try{
      final Response response = await dio.get(
        '$baseUrl/api/v1/categories/',
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      categoriesResponse = (response.data as List).map((data) {
        return CategoryResponse.fromJson(data);
      }).toList();
      return categoriesResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<List<CategoryResponse>> getCategories(int? id) async {
    List<CategoryResponse> categories = [];
    Dio dio = Dio();
    String path = "$baseUrl/api/v1/category/" ;

    if (id != null){
      path = path + "$id";
    }

    try{
      Response response = await dio.get(
          path,
          options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN'}),
      );
      categories = (response.data as List).map((data){
        return CategoryResponse.fromJson(data);
      }).toList();

      return categories;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<CreateCategoryResponse> createCategory(String name, int company, int? parent) async {
    late CreateCategoryResponse createCategoryResponse;
    Dio dio = Dio();
    try{
      Response response = await dio.post(
        '$baseUrl/api/v1/category/',
        data: {
          'name' : name,
          'company' : company,
          'parent' : parent,
        },
        options: Options(headers: {'Authorization' : 'Bearer $ACCESS_TOKEN', 'Content-Type':'application/x-www-form-urlencoded'}),
      );
      createCategoryResponse = CreateCategoryResponse.fromJson(response.data);
      return createCategoryResponse;
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future<void> editCategory(CategoryResponse category, String newName) async {
    Dio dio = Dio();
    try{
      await dio.put(
        "$baseUrl/api/v1/category/${category.id}",
        data: {
          'name' : newName,
          'company': category.company
        },
        options: Options(
            headers: {
              'Authorization' : 'Bearer $ACCESS_TOKEN',
              'Content-Type':'application/x-www-form-urlencoded'}
        ),
      );
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }

  Future deleteCategory(int id) async {
    Dio dio = Dio();
    try{
      await dio.delete(
        "$baseUrl/api/v1/category/$id",
        options: Options(
            headers: {
              'Authorization' : 'Bearer $ACCESS_TOKEN',
              }
        ),
      );
    }on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
  
  Future<List<CategoryResponse>> searchCategory(String name) async{
    List<CategoryResponse> categoriesResponse = [];
    Dio dio = Dio();
    try{
      Response response = await dio.get(
          "$baseUrl/api/v1/search/?name=$name",
          options: Options(
              headers: {
                'Authorization' : 'Bearer $ACCESS_TOKEN',
              }
          )
      );
      categoriesResponse = (response.data as List).map((data) {
        return CategoryResponse.fromJson(data);
      }).toList();
      return categoriesResponse;
    } on DioError catch(e){
      throw(HandleError(e).getMessage());
    }
  }
}