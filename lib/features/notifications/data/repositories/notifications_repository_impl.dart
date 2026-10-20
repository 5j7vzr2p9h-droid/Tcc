import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/entities/paginated_list_entity.dart';
import '../../../../core/enums/notification_type.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/fcm_service.dart';
import '../datasources/notifications_remote_datasource.dart';

final class NotificationsRepositoryImpl({
  required final Prefs _prefs,
  required final NetworkInfo _networkInfo,
  required final FcmService _fcmService,
  required final NotificationsRemoteDatasource _remoteDatasource
}) implements NotificationsRepository{
  StreamSubscription<String>? _subscription;

  @override
  Future<Either<Failure, Unit>> disableNotifications() async{
    // TODO

    await _subscription?.cancel();
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> enableNotifications() async{
    if(_subscription == null){
      if(await _networkInfo.isDeviceConnected){
        try{
          final String fid = await _fcmService.registerAndGetId;
          await _remoteDatasource.putInstallationId(fid);

          _subscription = _fcmService.onRegistered.listen((String newFid) async{
            try {
              if (await _networkInfo.isDeviceConnected) 
                await _remoteDatasource.putInstallationId(fid);
            } catch (_){}
          });

          return const Right(unit);
        }on OfflineException{
          return const Left(OfflineFailure());
        }on ServerException catch(e){
          return Left(ServerFailure(e.message));
        }catch(_){
          return const Left(UnknownFailure());
        }
      }
      return const Left(OfflineFailure());
    }
    return const Right(unit);
  }

  @override
  Future<Either<Failure, PaginatedListEntity<NotificationEntity>>> getNotifications({
    required int pageIndex,
    required int pageSize,
    NotificationType? type
  }) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final PaginatedListEntity<NotificationEntity> notifications = await _remoteDatasource.getNotifications(
          pageIndex: pageIndex,
          pageSize: pageSize,
          type: type
        );
        return Right(notifications);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }
    return const Left(OfflineFailure());
  }

  @override
  void clearNotificatonsCounter() => _prefs.remove(CacheKeys.notificationsCount);

  @override
  int get notificationsCount => _prefs.getInt(CacheKeys.notificationsCount) ?? 0;

  @override
  void incrementNotificationsCounter()
  => _prefs.setInt(key: CacheKeys.notificationsCount, value: notificationsCount + 1);

  @override
  Stream<void> get listenToForegroundNotificationsAndIncrement
  => _fcmService.onForeground.map<void>((_) => incrementNotificationsCounter());

}