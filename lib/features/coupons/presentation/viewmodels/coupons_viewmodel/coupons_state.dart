import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/coupon_entity.dart';

sealed class const CouponsState();

final class const CouponsInitialState() extends CouponsState;

final class const CouponsLoadingState() extends CouponsState;

final class const CouponsGetSuccessState({
  required final List<CouponEntity> activeCoupons,
  required final List<CouponEntity> expiredCoupons
}) extends CouponsState;

final class const CouponsGetFailureState(
  final Failure failure
) extends CouponsState;
