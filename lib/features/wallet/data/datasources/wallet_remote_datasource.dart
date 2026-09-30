import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';

abstract interface class const WalletRemoteDatasource() {
  Future<double> getBalance();
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
}
