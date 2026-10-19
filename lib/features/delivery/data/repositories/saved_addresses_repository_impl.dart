import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/delivery/domain/entities/address_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/repositories/saved_addresses_repository.dart';
import '../datasources/saved_addresses_remote_datasource.dart';

final class const SavedAddressesRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final SavedAddressesRemoteDatasource _remoteDatasource
}) implements SavedAddressesRepository {
  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<AddressEntity> addresses = await _remoteDatasource.getSavedAddresses();
        return Right(addresses);
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
  Future<Either<Failure, Unit>> setAsDefaultAddress(int id) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        await _remoteDatasource.setAsDefaultAddress(id);
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

  @override
  Future<Either<Failure, List<AddressEntity>>> deleteAddress(int id) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<AddressEntity> addresses = await _remoteDatasource.deleteAddress(id);
        return Right(addresses);
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