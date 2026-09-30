import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/wallet_repository.dart';

final class const GetBalanceUsecase(final WalletRepository _repository) {

  Future<Either<Failure, double>> call()
  => _repository.getBalance();
}
