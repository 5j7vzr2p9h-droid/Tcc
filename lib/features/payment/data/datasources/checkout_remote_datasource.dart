import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/checkout_model.dart';
import '../models/payment_method_model.dart';

abstract interface class const CheckoutRemoteDatasource() {
  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<void> checkout({
    required String requestId,
    required CheckoutModel checkout
  });
}

final class const CheckoutRemoteDatasourceImpl(final Dio _dio) implements CheckoutRemoteDatasource{
  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.paymentMethods,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": null // So as not to get 403 (Forbidden from backend)
          }
        )
      );
      final List<PaymentMethodModel> methods = (response.data["data"] as List)
        .map<PaymentMethodModel>((json) => PaymentMethodModel.fromJson(json)).toList();
      return methods;
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<void> checkout({
    required String requestId,
    required CheckoutModel checkout
  }) async{
    try{
      await _dio.post(
        ApiEndpoints.checkout,
        data: <String, dynamic>{
          "requestId": requestId,
          ...checkout.toJson()
        }
      );
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
}
