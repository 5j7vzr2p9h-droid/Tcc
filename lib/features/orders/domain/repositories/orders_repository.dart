import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/order_model.dart';

abstract interface class OrdersRepository {

  Future<Either<Failure, List<OrderModel>>> getCurrentOrders();
  Future<Either<Failure, List<OrderModel>>> getPreviousOrders();
}