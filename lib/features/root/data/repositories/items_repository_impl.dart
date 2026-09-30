import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/root/domain/entities/item_entity.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_remote_datasource.dart';
import '../models/item_model.dart';

final class const ItemsRepositoryImpl({
  required final Prefs _prefs,
  required final NetworkInfo _networkInfo,
  required final ItemsRemoteDatasource _remoteDatasource
}) implements ItemsRepository{

  @override
  Future<Either<Failure, List<ItemModel>>> getCategoryProducts(int categoryId) async{
    if (await _networkInfo.isDeviceConnected) {
      try {
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<ItemModel> items = await _remoteDatasource.getCategoryProducts(
          branchId: branchId,
          categoryId: categoryId
        );
        return Right(items);
      } on ServerException catch(e) {
        return Left(ServerFailure(e.message));
      } on OfflineException {
        return const Left(OfflineFailure());
      } catch(_) {
        return const Left(UnknownFailure());
      }
    }
    else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getPopularProducts() async{
    if (await _networkInfo.isDeviceConnected) {
      try {
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<ItemModel> items = await _remoteDatasource.getPopularProducts(
          branchId: branchId,
        );
        return Right(items);
      } on ServerException catch(e) {
        return Left(ServerFailure(e.message));
      } on OfflineException {
        return const Left(OfflineFailure());
      } catch(_) {
        return const Left(UnknownFailure());
      }
    }
    else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> searchProducts(String query) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<ItemEntity> products = await _remoteDatasource.searchProducts(
          branchId: branchId,
          query: query
        );
        return Right(products);
      }on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }on OfflineFailure{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }
    else return const Left(OfflineFailure());
  }
}
