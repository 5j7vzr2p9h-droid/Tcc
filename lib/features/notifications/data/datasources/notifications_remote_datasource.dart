import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/enums/notification_type.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/paginated_list_model.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../../core/utils/api_error_handler.dart';
import '../models/notification_model.dart';

abstract interface class const NotificationsRemoteDatasource() {
  Future<void> putInstallationId(String fid);
  Future<PaginatedListModel<NotificationModel>> getNotifications({
    required int pageIndex,
    required int pageSize,
    NotificationType? type
  });
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

  @override
  Future<PaginatedListModel<NotificationModel>> getNotifications({
    required int pageIndex,
    required int pageSize,
    NotificationType? type
  }) async{
    try{
      final Response response = await _dio.get(
        ApiEndpoints.notifications,
        queryParameters: <String, int>{
          "pageIndex": pageIndex,
          "pageSize": pageSize,
          "type": ?type?.index
        }
      );
      return PaginatedListModel<NotificationModel>.fromJson(
        response.data,
        NotificationModel.fromJson
      );
    }on DioException catch(e){
      ApiErrorHandler.handle(e);
    }catch(_){
      throw const UnknownException();
    }
  }
}
