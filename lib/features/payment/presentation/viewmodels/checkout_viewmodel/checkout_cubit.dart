import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/checkout_entity.dart';
import '../../../domain/usecases/checkout_usecase.dart';
import 'checkout_state.dart';

final class CheckoutCubit extends Cubit<CheckoutState>{
  final CheckoutUsecase _checkoutUsecase;

  CheckoutCubit(this._checkoutUsecase): super(const CheckoutIdleState());

  void checkout(CheckoutEntity checkout) async{
    // Ignores taps while an order is already being sent.
    if(state is CheckoutLoadingState || checkout.items.isEmpty) return;

    emit(const CheckoutLoadingState());

    final Either<Failure, Unit> result = await _checkoutUsecase(checkout);

    if(isClosed) return;

    result.fold(
      (Failure failure) => emit(CheckoutFailureState(failure)),
      (Unit _) => emit(const CheckoutSuccessState())
    );
  }
}
