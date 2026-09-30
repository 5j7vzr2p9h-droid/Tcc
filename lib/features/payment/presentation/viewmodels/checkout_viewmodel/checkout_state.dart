import '../../../../../core/errors/failures.dart';

sealed class const CheckoutState();

final class const CheckoutIdleState() extends CheckoutState;

final class const CheckoutLoadingState() extends CheckoutState;

final class const CheckoutSuccessState() extends CheckoutState;

final class const CheckoutFailureState(
  final Failure failure
) extends CheckoutState;
