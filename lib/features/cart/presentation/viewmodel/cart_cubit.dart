import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_item_quantity_usecase.dart';
import 'cart_state.dart';

final class CartCubit extends Cubit<CartState>{
  final GetCartUsecase _getCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final UpdateCartItemQuantityUsecase _updateCartItemQuantityUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;
  final ClearCartUsecase _clearCartUsecase;

  CartCubit({
    required this._getCartUsecase,
    required this._addToCartUsecase,
    required this._updateCartItemQuantityUsecase,
    required this._removeFromCartUsecase,
    required this._clearCartUsecase
  }): super(const CartInitialState());

  Future<void> init() => _emitResult(_getCartUsecase());

  Future<void> addToCart(CartItemEntity item) => _emitResult(_addToCartUsecase(item));

  Future<void> updateQuantity(String key, int quantity)
  => _emitResult(_updateCartItemQuantityUsecase(key, quantity));

  Future<void> removeFromCart(String key) => _emitResult(_removeFromCartUsecase(key));

  Future<void> clearCart() => _emitResult(_clearCartUsecase());

  Future<void> _emitResult(Future<Either<Failure, List<CartItemEntity>>> operation) async{
    final Either<Failure, List<CartItemEntity>> result = await operation;

    if(isClosed) return;

    result.fold(
      (Failure failure) => emit(CartFailureState(state.items, failure)),
      (List<CartItemEntity> items) => emit(CartLoadedState(items))
    );
  }
}
