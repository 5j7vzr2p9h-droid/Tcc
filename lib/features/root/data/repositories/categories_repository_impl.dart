import 'package:dartz/dartz.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_datasource.dart';
import '../models/category_model.dart';

final class const CategoriesRepositoryImpl({
  required final Prefs _prefs,
  required final NetworkInfo _networkInfo,
  required final CategoriesRemoteDatasource _remoteDatasource
}) implements CategoriesRepository{

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async{
    if (await _networkInfo.isDeviceConnected) {
      try {
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<CategoryModel> categories = await _remoteDatasource.getCategories(branchId);
        return Right(categories);
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
}
