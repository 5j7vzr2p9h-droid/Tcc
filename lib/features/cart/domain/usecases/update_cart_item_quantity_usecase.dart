import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

final class const UpdateCartItemQuantityUsecase(
  final CartRepository _repository
){

  Future<Either<Failure, List<CartItemEntity>>> call(String key, int quantity)
  => _repository.updateQuantity(key, quantity);
}
