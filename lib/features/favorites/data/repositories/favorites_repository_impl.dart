import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/root/domain/entities/item_entity.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_datasource.dart';

final class const FavoritesRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final Prefs _prefs,
  required final FavoritesRemoteDatasource _remoteDatasource
  
}) implements FavoritesRepository{
  @override
  Future<Either<Failure, List<ItemEntity>>> getFavorites() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<ItemEntity> favorites = await _remoteDatasource.getFavorites(branchId);
        return Right(favorites);
      }on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(int id, bool newValue) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        await _remoteDatasource.toggleFavorite(
          branchId: branchId,
          productId: id,
          newValue: newValue
        );
        return const Right(unit);
      }on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }
  
}