import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/wallet_repository.dart';

final class const TopupThroughInstapayUsecase(final WalletRepository _repository){

  Future<Either<Failure, Unit>> call(String instapayUsername)
  => _repository.topupThroughInstapay(instapayUsername);
}