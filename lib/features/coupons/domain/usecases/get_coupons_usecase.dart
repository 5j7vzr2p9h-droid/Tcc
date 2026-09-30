import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/coupon_entity.dart';
import '../repositories/coupons_repository.dart';

final class const GetCouponsUsecase(final CouponsRepository _repository) {

  Future<Either<Failure, List<CouponEntity>>> call()
  => _repository.getCoupons();
}
