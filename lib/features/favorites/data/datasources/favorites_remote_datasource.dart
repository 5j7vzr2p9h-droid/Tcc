import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../../../root/data/models/item_model.dart';

abstract interface class FavoritesRemoteDatasource {
  Future<List<ItemModel>> getFavorites(int branchId);
  Future<void> toggleFavorite({
    required int branchId,
    required int productId,
    required bool newValue
  });
}

final class FavoritesRemoteDatasourceImpl(final Dio _dio) implements FavoritesRemoteDatasource{

  @override
  Future<List<ItemModel>> getFavorites(int branchId) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.favroites,
        queryParameters: <String, int>{
          "branchId": branchId
        }
      );
      final List<ItemModel> favorites = (response.data["data"] as List)
        .map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
      return favorites;
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<void> toggleFavorite({
    required int branchId,
    required int productId,
    required bool newValue
  }) async{
    try{
      await _dio.put(
        "${ApiEndpoints.favroites}/$productId",
        queryParameters: <String, int>{
          "branchId": branchId
        },
        data: <String, bool>{
          "isFavorite": newValue
        }
      );
      return;
    }on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
  
}