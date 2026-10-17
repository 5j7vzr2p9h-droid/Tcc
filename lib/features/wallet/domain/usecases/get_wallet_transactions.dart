import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction_entity.dart';
import '../repositories/wallet_repository.dart';

final class const GetWalletTransactionsUsecase(final WalletRepository _repository) {

  Future<Either<Failure, List<WalletTransactionEntity>>> call()
  => _repository.getWalletTransactions();
}
