import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/wallet_repository.dart';

final class const TopupThroughVodafoneUsecase(final WalletRepository _repository){

  Future<Either<Failure, Unit>> call(String senderMobile)
  => _repository.topupThroughVodafone(senderMobile);
}