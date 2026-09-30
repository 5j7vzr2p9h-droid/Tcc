import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item_entity.dart';

sealed class const CartState(
  final List<CartItemEntity> items
){
  bool get isEmpty => items.isEmpty;

  int get itemsCount => items.fold<int>(
    0,
    (int count, CartItemEntity item) => count + item.quantity
  );

  double get subtotal => items.fold<double>(
    0.0,
    (double total, CartItemEntity item) => total + item.totalPrice
  );
}

final class CartInitialState extends CartState{
  const new(): super(const <CartItemEntity>[]);
}

final class const CartLoadedState(super.items) extends CartState;

/// Keeps the last known [items] so the UI doesn't lose the cart when an operation fails.
final class const CartFailureState(
  super.items,
  final Failure failure
) extends CartState;
