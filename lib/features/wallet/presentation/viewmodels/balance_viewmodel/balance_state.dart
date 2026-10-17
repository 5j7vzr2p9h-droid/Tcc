import '../../../../../core/errors/failures.dart';

sealed class const BalanceState();

final class const BalanceInitialState() extends BalanceState;

final class const BalanceLoadingState() extends BalanceState;

final class const BalanceGetSuccessState(
  final double balance
) extends BalanceState;

final class const BalanceGetFailureState(
  final Failure failure
) extends BalanceState;
