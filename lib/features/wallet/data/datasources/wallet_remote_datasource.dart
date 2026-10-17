import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/wallet_transaction_model.dart';

abstract interface class const WalletRemoteDatasource() {
  Future<double> getBalance();
  Future<void> topupThroughInstapay({
    required String requestId,
    required String instapayUsername
  });
  Future<void> topupThroughVodafone({
    required String requestId,
    required String senderMobile
  });
  Future<List<WalletTransactionModel>> getWalletTransactions();
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
  Future<void> topupThroughInstapay({required String requestId, required String instapayUsername}) async{
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
  Future<void> topupThroughVodafone({required String requestId, required String senderMobile}) async{
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

  @override
  Future<List<WalletTransactionModel>> getWalletTransactions() async{
    try{
      final Response response = await _dio.get(ApiEndpoints.wallet);
      final List<WalletTransactionModel> walletTransactions = (response.data["data"] as List).map<WalletTransactionModel>(
        (json) => WalletTransactionModel.fromJson(json)
      ).toList();
      return walletTransactions;
    } on DioException catch(exception){
      ApiErrorHandler.handle(exception);
    }catch(e){
      throw const UnknownException();
    }
  }
}
