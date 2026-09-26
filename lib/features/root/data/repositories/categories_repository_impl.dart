import 'package:dartz/dartz.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_local_datasource.dart';
import '../datasources/categories_remote_datasource.dart';
import '../models/category_model.dart';

final class const CategoriesRepositoryImpl({
  required final Prefs _prefs,
  required final NetworkInfo _networkInfo,
  required final CategoriesRemoteDatasource _remoteDatasource,
  required final CategoriesLocalDatasource _localDatasource
}) implements CategoriesRepository{

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async{
    if (await _networkInfo.isDeviceConnected) {
      try {
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<CategoryModel> categories = await _remoteDatasource.getCategories(branchId);
        _localDatasource.cacheCategories(categories);
        return Right(categories);
      } on ServerException catch(e) {
        return _getCachedCategoriesOrFailure(ServerFailure(e.message));
      } on OfflineException {
        return _getCachedCategoriesOrFailure(const OfflineFailure());
      }
    }
    else return _getCachedCategoriesOrFailure(const OfflineFailure());
  }

  Future<Either<Failure, List<CategoryEntity>>> _getCachedCategoriesOrFailure(Failure defaultFailure) async {
    try {
      final cachedCategories = _localDatasource.getCachedCategories();
      return Right(cachedCategories);
    } catch (_) {
      return Left(defaultFailure);
    }
  } 
}