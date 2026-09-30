import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../cart/domain/entities/cart_item_entity.dart';
import '../../../../cart/domain/usecases/get_cart_usecase.dart';
import '../../../domain/entities/coupon_quote_entity.dart';
import '../../../domain/usecases/apply_coupon_usecase.dart';
import 'apply_coupon_state.dart';

final class ApplyCouponCubit extends Cubit<ApplyCouponState>{
  final GetCartUsecase _getCartUsecase;
  final ApplyCouponUsecase _applyCouponUsecase;

  ApplyCouponCubit({
    required this._getCartUsecase,
    required this._applyCouponUsecase
  }): super(const ApplyCouponIdleState());

  void apply(String code) async{
    final String trimmedCode = code.trim();
    if(trimmedCode.isEmpty || state is ApplyCouponLoadingState) return;

    emit(const ApplyCouponLoadingState());

    // The coupon is quoted against the cart, so there must be something in it.
    final List<CartItemEntity>? items = (await _getCartUsecase()).fold(
      (Failure failure){
        emit(ApplyCouponFailureState(failure));
        return null;
      },
      (List<CartItemEntity> items) => items
    );

    if(items == null || isClosed) return;

    if(items.isEmpty) return emit(const ApplyCouponEmptyCartState());

    final Either<Failure, CouponQuoteEntity> result = await _applyCouponUsecase(
      code: trimmedCode,
      items: items
    );

    if(isClosed) return;

    result.fold(
      (Failure failure) => emit(ApplyCouponFailureState(failure)),
      (CouponQuoteEntity quote) => emit(ApplyCouponSuccessState(quote))
    );
  }
}
