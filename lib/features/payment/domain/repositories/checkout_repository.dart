import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/checkout_entity.dart';
import '../entities/payment_method_entity.dart';

abstract interface class const CheckoutRepository() {
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();
  Future<Either<Failure, Unit>> checkout(CheckoutEntity checkout);
}
