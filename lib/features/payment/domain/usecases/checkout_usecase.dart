import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/checkout_entity.dart';
import '../repositories/checkout_repository.dart';

final class const CheckoutUsecase(final CheckoutRepository _repository) {

  Future<Either<Failure, Unit>> call(CheckoutEntity checkout)
  => _repository.checkout(checkout);
}
