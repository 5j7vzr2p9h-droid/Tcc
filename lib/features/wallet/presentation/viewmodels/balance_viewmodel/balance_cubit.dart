import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/get_balance_usecase.dart';
import 'balance_state.dart';

final class BalanceCubit extends Cubit<BalanceState>{
  final GetBalanceUsecase _getBalanceUsecase;

  BalanceCubit(this._getBalanceUsecase): super(const BalanceInitialState());

  void init() async{
    emit(const BalanceLoadingState());

    final Either<Failure, double> result = await _getBalanceUsecase();

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(BalanceGetFailureState(failure)),
      (double balance) => emit(BalanceGetSuccessState(balance))
    );
  }
}
