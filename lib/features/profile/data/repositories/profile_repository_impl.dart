import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/profile/domain/entities/profile_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

final class const ProfileRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final ProfileRemoteDatasource _remoteDatasource
}) implements ProfileRepository{


  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final ProfileEntity profile = await _remoteDatasource.getProfile();
        return Right(profile);
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
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String? name,
    required String? address,
    required String? imagePath
  }) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final ProfileEntity profile = await _remoteDatasource.updateProfile(
          name: name,
          address: address,
          imagePath: imagePath
        );
        return Right(profile);
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
  Future<Either<Failure, Unit>> requestPhoneUpdate(String newPhone) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        await _remoteDatasource.requestPhoneUpdate(newPhone);
        return const Right(unit);
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
}