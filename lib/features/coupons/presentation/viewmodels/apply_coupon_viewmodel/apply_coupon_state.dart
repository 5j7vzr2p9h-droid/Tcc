import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/coupon_quote_entity.dart';

sealed class const ApplyCouponState();

final class const ApplyCouponIdleState() extends ApplyCouponState;

final class const ApplyCouponLoadingState() extends ApplyCouponState;

final class const ApplyCouponEmptyCartState() extends ApplyCouponState;

final class const ApplyCouponSuccessState(
  final CouponQuoteEntity quote
) extends ApplyCouponState;

final class const ApplyCouponFailureState(
  final Failure failure
) extends ApplyCouponState;
