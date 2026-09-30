import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_item_entity.dart';

abstract interface class const CartRepository() {
  Future<Either<Failure, List<CartItemEntity>>> getCart();
  Future<Either<Failure, List<CartItemEntity>>> addToCart(CartItemEntity item);
  Future<Either<Failure, List<CartItemEntity>>> updateQuantity(String key, int quantity);
  Future<Either<Failure, List<CartItemEntity>>> removeFromCart(String key);
  Future<Either<Failure, List<CartItemEntity>>> clearCart();
}
