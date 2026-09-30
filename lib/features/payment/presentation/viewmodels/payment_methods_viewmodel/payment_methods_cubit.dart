import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../wallet/domain/usecases/get_balance_usecase.dart';
import '../../../domain/entities/payment_method_entity.dart';
import '../../../domain/usecases/get_payment_methods_usecase.dart';
import 'payment_methods_state.dart';

final class PaymentMethodsCubit extends Cubit<PaymentMethodsState>{
  final GetPaymentMethodsUsecase _getPaymentMethodsUsecase;
  final GetBalanceUsecase _getBalanceUsecase;

  PaymentMethodsCubit({
    required this._getPaymentMethodsUsecase,
    required this._getBalanceUsecase
  }): super(const PaymentMethodsInitialState());

  void init() async{
    emit(const PaymentMethodsLoadingState());

    final List<Either<Failure, dynamic>> results = await Future.wait(<Future<Either<Failure, dynamic>>>[
      _getPaymentMethodsUsecase(),
      _getBalanceUsecase()
    ]);

    if(isClosed)
      return;

    final Either<Failure, List<PaymentMethodEntity>> methodsResult = results[0] as Either<Failure, List<PaymentMethodEntity>>;
    final Either<Failure, double> balanceResult = results[1] as Either<Failure, double>;

    methodsResult.fold(
      (Failure failure) => emit(PaymentMethodsGetFailureState(failure)),
      (List<PaymentMethodEntity> methods) => balanceResult.fold(
        (Failure failure) => emit(PaymentMethodsGetFailureState(failure)),
        (double balance) => emit(PaymentMethodsGetSuccessState(
          methods: methods,
          balance: balance
        ))
      )
    );
  }
}
