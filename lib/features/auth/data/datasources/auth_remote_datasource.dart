import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electronic_menu/core/errors/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';

abstract interface class AuthRemoteDatasource{
  Future<Unit> login({required String phone});
  Future<String> register({
    required String name,
    required String phone,
    required String address
  });
  Future<String> verifyPhone({
    required String phone,
    required String code
  });
  void logout();
}

final class AuthRemoteDatasourceImpl implements AuthRemoteDatasource{
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  const AuthRemoteDatasourceImpl({
    required this._dio,
    required this._secureStorage
  });

  @override
  Future<Unit> login({required String phone}) async{
    try{
      await _dio.post(
        ApiEndpoints.login,
        data: <String, String>{"phone": phone},
      );
      return unit;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<String> register({required String name, required String phone, required String address}) async{
    try{
      final Response response =  await _dio.post(
        ApiEndpoints.register,
        data: <String, String>{
          "name": name,
          "phone": phone,
          "address": address
        }
      );
      return response.data["message"];
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  Future<String> verifyPhone({required String phone, required String code}) async{
    try{
      final Response response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: <String, String>{"phone": phone, "code": code}
      );
      final String token = response.data["token"];
      _secureStorage.write(key: "token", value: token);
      // _dio.options.headers["token"]
      return token;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(e){
      throw const UnknownException();
    }
  }

  @override
  void logout(){
    _dio.post(
      ApiEndpoints.logout,
    // ignore: body_might_complete_normally_catch_error
    ).catchError((e){});
    _secureStorage.delete(key: "token");
  }
}