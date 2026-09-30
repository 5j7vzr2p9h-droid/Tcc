import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../entities/coupon_entity.dart';
import '../entities/coupon_quote_entity.dart';

abstract interface class CouponsRepository {
  Future<Either<Failure, List<CouponEntity>>> getCoupons();
  Future<Either<Failure, CouponQuoteEntity>> applyCoupon({
    required String code,
    required List<CartItemEntity> items
  });
}
