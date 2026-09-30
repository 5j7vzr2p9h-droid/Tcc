import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class const WalletRepository() {
  Future<Either<Failure, double>> getBalance();
}
