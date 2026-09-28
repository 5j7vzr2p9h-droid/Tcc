import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/order_model.dart';

abstract interface class const OrdersRemoteDatasource() {
  Future<List<OrderModel>> getCurrentOrders();
  Future<List<OrderModel>> getPreviousOrders();
}

final class const OrdersRemoteDatasourceImpl(final Dio _dio) implements OrdersRemoteDatasource{
  @override
  Future<List<OrderModel>> getCurrentOrders() async {
    try{
      final Response response = await _dio.get(ApiEndpoints.currentOrders);
      final List<OrderModel> orders = (response.data["data"] as List)
        .map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
      return orders;
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<List<OrderModel>> getPreviousOrders() async{
    try{
      final Response response = await _dio.get(ApiEndpoints.previousOrders);
      final List<OrderModel> orders = (response.data["data"] as List)
        .map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
      return orders;
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      print("================> $e");
      throw const UnknownException();
    }
  }
}