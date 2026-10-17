import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction_entity.dart';

abstract interface class const WalletRepository() {
  Future<Either<Failure, double>> getBalance();
  Future<Either<Failure, Unit>> topupThroughInstapay(String instapayUsername);
  Future<Either<Failure, Unit>> topupThroughVodafone(String senderMobile);
  Future<Either<Failure, List<WalletTransactionEntity>>> getWalletTransactions();
}
