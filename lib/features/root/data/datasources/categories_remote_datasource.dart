import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/category_model.dart';

abstract interface class CategoriesRemoteDatasource {
  Future<List<CategoryModel>> getCategories(int branchId);
}

final class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource{
  final Dio _dio;

  const CategoriesRemoteDatasourceImpl(this._dio);


  @override
  Future<List<CategoryModel>> getCategories(int branchId) async{
    try{
      final Response response = await _dio.get(ApiEndpoints.categories, queryParameters: {
        "branchId": branchId
      });
      List<CategoryModel> categories = response.data.map<CategoryModel>((e) => CategoryModel.fromJson(e)).toList();
      return categories;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }
}