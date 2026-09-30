import 'package:dartz/dartz.dart';

import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/coupon_quote_entity.dart';
import '../../domain/repositories/coupons_repository.dart';
import '../datasources/coupons_remote_datasource.dart';

final class const CouponsRepositoryImpl({
  required final NetworkInfo _networkInfo,
  required final Prefs _prefs,
  required final CouponsRemoteDatasource _remoteDatasource
}) implements CouponsRepository{
  @override
  Future<Either<Failure, List<CouponEntity>>> getCoupons() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final List<CouponEntity> coupons = await _remoteDatasource.getCoupons(branchId);
        return Right(coupons);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, CouponQuoteEntity>> applyCoupon({
    required String code,
    required List<CartItemEntity> items
  }) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final int branchId = _prefs.getInt(CacheKeys.branchId)!;
        final CouponQuoteEntity quote = await _remoteDatasource.applyCoupon(
          branchId: branchId,
          code: code,
          items: items
        );
        return Right(quote);
      } on ServerException catch(exception){
        return Left(ServerFailure(exception.message));
      }on OfflineException{
        return const Left(OfflineFailure());
      }catch(_){
        return const Left(UnknownFailure());
      }
    }else return const Left(OfflineFailure());
  }
}
