import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

final class const GetCartUsecase(
  final CartRepository _repository
){

  Future<Either<Failure, List<CartItemEntity>>> call()
  => _repository.getCart();
}
