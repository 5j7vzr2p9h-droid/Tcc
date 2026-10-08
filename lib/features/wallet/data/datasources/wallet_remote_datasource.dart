import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';

abstract interface class const WalletRemoteDatasource() {
  Future<double> getBalance();
  Future<void> topupThrowInstapay({
    required String requestId,
    required String instapayUsername
  });
  Future<void> topupThrowVodafone({
    required String requestId,
    required String senderMobile
  });
}

final class const WalletRemoteDatasourceImpl(final Dio _dio) implements WalletRemoteDatasource{
  @override
  Future<double> getBalance() async{
    try{
      final Response response = await _dio.get(ApiEndpoints.wallet);
      return (response.data["balance"] as num).toDouble();
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<void> topupThrowInstapay({required String requestId, required String instapayUsername}) async{
    try{
      await _dio.post(
        ApiEndpoints.wallet,
        data: <String, String>{
          "requestId": requestId,
          "username": instapayUsername
        }
      );
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<void> topupThrowVodafone({required String requestId, required String senderMobile}) async{
    try{
      await _dio.post(
        ApiEndpoints.wallet,
        data: <String, String>{
          "requestId": requestId,
          "senderMobile": senderMobile
        }
      );
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
}
