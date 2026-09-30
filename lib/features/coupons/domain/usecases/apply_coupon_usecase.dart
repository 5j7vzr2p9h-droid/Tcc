import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../entities/coupon_quote_entity.dart';
import '../repositories/coupons_repository.dart';

final class const ApplyCouponUsecase(final CouponsRepository _repository) {

  Future<Either<Failure, CouponQuoteEntity>> call({
    required String code,
    required List<CartItemEntity> items
  })
  => _repository.applyCoupon(code: code, items: items);
}
