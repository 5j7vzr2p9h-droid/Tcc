import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/payment_method_entity.dart';
import '../../../domain/usecases/get_payment_methods_usecase.dart';
import 'payment_methods_state.dart';

final class PaymentMethodsCubit extends Cubit<PaymentMethodsState>{
  final GetPaymentMethodsUsecase _getPaymentMethodsUsecase;

  PaymentMethodsCubit(this._getPaymentMethodsUsecase): super(const PaymentMethodsInitialState());

  void init() async{
    emit(const PaymentMethodsLoadingState());

    final Either<Failure, List<PaymentMethodEntity>> result = await _getPaymentMethodsUsecase();

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(PaymentMethodsGetFailureState(failure)),
      (List<PaymentMethodEntity> methods) => emit(PaymentMethodsGetSuccessState(methods))
    );
  }
}
