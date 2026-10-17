import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/wallet_transaction_entity.dart';

sealed class const WalletState();

final class const WalletInitialState() extends WalletState;

final class const WalletLoadingState() extends WalletState;

final class const WalletGetSuccessState({
  required final double balance,
  required final List<WalletTransactionEntity> walletTransactions
}) extends WalletState;

final class const WalletGetFailureState(
  final Failure failure
) extends WalletState;
