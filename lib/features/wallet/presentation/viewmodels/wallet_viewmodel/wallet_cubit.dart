import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/get_balance_usecase.dart';
import 'wallet_state.dart';

final class WalletCubit extends Cubit<WalletState>{
  final GetBalanceUsecase _getBalanceUsecase;

  WalletCubit(this._getBalanceUsecase): super(const WalletInitialState());

  void init() async{
    emit(const WalletLoadingState());

    final Either<Failure, double> result = await _getBalanceUsecase();

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(WalletGetFailureState(failure)),
      (double balance) => emit(WalletGetSuccessState(balance))
    );
  }
}
