import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/fcm_service.dart';
import '../datasources/notifications_remote_datasource.dart';

final class NotificationsRepositoryImpl({
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
}