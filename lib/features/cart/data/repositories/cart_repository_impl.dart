import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_item_model.dart';

final class const CartRepositoryImpl(
  final CartLocalDatasource _localDatasource
) implements CartRepository{

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCart()
  => _run(() async{});

  @override
  Future<Either<Failure, List<CartItemEntity>>> addToCart(CartItemEntity item)
  => _run(() async{
    final CartItemModel? existingItem = _localDatasource.getCartItem(item.key);
    await _localDatasource.saveCartItem(
      existingItem == null
        ? CartItemModel.fromEntity(item, addedAt: DateTime.now())
        : existingItem.copyWith(quantity: existingItem.quantity + item.quantity)
    );
  });

  @override
  Future<Either<Failure, List<CartItemEntity>>> updateQuantity(String key, int quantity)
  => _run(() async{
    final CartItemModel? existingItem = _localDatasource.getCartItem(key);
    if(existingItem != null)
      await _localDatasource.saveCartItem(existingItem.copyWith(quantity: quantity));
  });

  @override
  Future<Either<Failure, List<CartItemEntity>>> removeFromCart(String key)
  => _run(() => _localDatasource.deleteCartItem(key));

  @override
  Future<Either<Failure, List<CartItemEntity>>> clearCart()
  => _run(_localDatasource.clearCart);

  /// Runs [operation] then returns the whole cart, so callers always get the latest state.
  Future<Either<Failure, List<CartItemEntity>>> _run(Future<void> Function() operation) async{
    try{
      await operation();
      return Right(_localDatasource.getCartItems());
    }catch(_){
      return const Left(UnknownFailure());
    }
  }
}
