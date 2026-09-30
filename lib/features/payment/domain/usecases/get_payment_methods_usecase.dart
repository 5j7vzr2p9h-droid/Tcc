import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/payment_method_entity.dart';
import '../repositories/checkout_repository.dart';

final class const GetPaymentMethodsUsecase(final CheckoutRepository _repository) {

  Future<Either<Failure, List<PaymentMethodEntity>>> call()
  => _repository.getPaymentMethods();
}
