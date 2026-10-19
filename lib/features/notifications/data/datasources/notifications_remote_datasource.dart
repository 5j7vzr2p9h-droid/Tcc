import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';

abstract interface class const NotificationsRemoteDatasource() {
  Future<void> putInstallationId(String fid);
}

final class const NotificationsRemoteDatasourceImpl(
  final Dio _dio
) implements NotificationsRemoteDatasource{

  @override
  Future<void> putInstallationId(String fid) async{
    try{
      await _dio.put(
        ApiEndpoints.registerFID,
        data: <String, String>{
          "installationId": fid,
          "platform": Platform.operatingSystem
        }
      );
      return;
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }
}