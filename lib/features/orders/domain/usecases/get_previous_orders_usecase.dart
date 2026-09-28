import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

final class const GetPreviousOrdersUsecase(final OrdersRepository _repository) {

  Future<Either<Failure, List<OrderEntity>>> call()
  => _repository.getPreviousOrders();
}