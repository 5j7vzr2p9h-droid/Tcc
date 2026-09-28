import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/item_model.dart';

abstract interface class ItemsRemoteDatasource {
  Future<List<ItemModel>> getCategoryProducts({
    required int branchId,
    required int categoryId
  });

  Future<List<ItemModel>> getPopularProducts({
    required int branchId
  });

  Future<List<ItemModel>> searchProducts({
    required int branchId,
    required String query
  });
}

final class ItemsRemoteDatasourceImpl implements ItemsRemoteDatasource{
  final Dio _dio;

  const ItemsRemoteDatasourceImpl(this._dio);

  @override
  Future<List<ItemModel>> getCategoryProducts({
    required int branchId,
    required int categoryId
  }) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.item,
        queryParameters: <String, dynamic>{
          "branchId": branchId,
          "categoryId": categoryId
        }
      );
      final List<ItemModel> items = (response.data["data"] as List)
        .map<ItemModel>((e) => ItemModel.fromJson(e)).toList();
      return items;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<List<ItemModel>> getPopularProducts({required int branchId}) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.item,
        queryParameters: <String, dynamic>{
          "BranchId": branchId,
          "Popular": true
        }
      );
      final List<ItemModel> items = (response.data["data"] as List)
        .map<ItemModel>((e) => ItemModel.fromJson(e)).toList();
      return items;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<List<ItemModel>> searchProducts({
    required int branchId,
    required String query
  }) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.item,
        queryParameters: <String, dynamic>{
          "BranchId": branchId,
          "Search": query
        }
      );
      final List<ItemModel> items = (response.data["data"] as List)
        .map<ItemModel>((e) => ItemModel.fromJson(e)).toList();
      return items;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }
}
