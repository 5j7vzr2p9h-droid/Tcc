import '../../../../core/enums/wallet_transaction_type.dart';

class const WalletTransactionEntity({
  required final WalletTransactionType type,
  required final double amount,
  required final String description,
  required final DateTime date,
  required final bool isSuccessful
});
