import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

abstract final class ApiErrorHandler {
  static Never handle(DioException exception){
    switch(exception.type){
      case .badResponse:
        print("=======");
        print(exception);
        throw ServerException(exception.response?.data["message"]??'');
      case .connectionError || .connectionTimeout || .sendTimeout
        || .receiveTimeout || .transformTimeout:
        throw const OfflineException();
      default:
        throw const UnknownException();
    }
  }
}