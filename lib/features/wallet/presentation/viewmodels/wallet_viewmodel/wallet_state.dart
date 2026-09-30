import '../../../../../core/errors/failures.dart';

sealed class const WalletState();

final class const WalletInitialState() extends WalletState;

final class const WalletLoadingState() extends WalletState;

final class const WalletGetSuccessState(
  final double balance
) extends WalletState;

final class const WalletGetFailureState(
  final Failure failure
) extends WalletState;
