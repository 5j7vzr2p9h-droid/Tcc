import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class const WalletRepository() {
  Future<Either<Failure, double>> getBalance();
  Future<Either<Failure, Unit>> topupThrowInstapay(String instapayUsername);
  Future<Either<Failure, Unit>> topupThrowVodafone(String senderMobile);
}
