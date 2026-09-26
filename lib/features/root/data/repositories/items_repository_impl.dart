import 'package:dartz/dartz.dart';

import 'package:electronic_menu/core/errors/failures.dart';

import 'package:electronic_menu/features/root/domain/entities/item_entity.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_local_datasource.dart';
import '../datasources/items_remote_datasource.dart';
import '../models/item_model.dart';

final class const ItemsRepositoryImpl({
  required final Prefs _prefs,
  required final NetworkInfo _networkInfo,
  required final ItemsRemoteDatasource _remoteDatasource,
  required final ItemsLocalDatasource _localDatasource
}) implements ItemsRepository{

  @override
  Future<Either<Failure, List<ItemEntity>>> getCategoryProducts(int categoryId) async{
    if (await _networkInfo.isDeviceConnected) {
      try {
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<ItemModel> items = await _remoteDatasource.getCategoryProducts(
          branchId: branchId,
          categoryId: categoryId
        );
        _localDatasource.cacheCategoryProducts(categoryId: categoryId, items: items);
        return Right(items);
      } on ServerException catch(e) {
        return _getCachedCategoryProductsOrFailure(categoryId, ServerFailure(e.message));
      } on OfflineException {
        return _getCachedCategoryProductsOrFailure(categoryId, const OfflineFailure());
      } on UnknownException {
        return _getCachedCategoryProductsOrFailure(categoryId, const UnknownFailure());
      }
    }
    else return _getCachedCategoryProductsOrFailure(categoryId, const OfflineFailure());
  }

  Future<Either<Failure, List<ItemEntity>>> _getCachedCategoryProductsOrFailure(
    int categoryId,
    Failure defaultFailure
  ) async {
    try {
      final cachedItems = _localDatasource.getCachedCategoryProducts(categoryId);
      return Right(cachedItems);
    } catch (_) {
      return Left(defaultFailure);
    }
  }
}
