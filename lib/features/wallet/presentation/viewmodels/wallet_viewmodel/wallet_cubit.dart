import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/wallet_transaction_entity.dart';
import '../../../domain/usecases/get_balance_usecase.dart';
import '../../../domain/usecases/get_wallet_transactions.dart';
import 'wallet_state.dart';

final class WalletCubit extends Cubit<WalletState>{
  final GetBalanceUsecase _getBalanceUsecase;
  final GetWalletTransactionsUsecase _getWalletTransactionsUsecase;

  WalletCubit({
    required this._getBalanceUsecase,
    required this._getWalletTransactionsUsecase
  }): super(const WalletInitialState());

  void init() async{
    emit(const WalletLoadingState());

    final List<Either<Failure, dynamic>> results = await Future.wait<Either<Failure, dynamic>>([
      _getBalanceUsecase(),
      _getWalletTransactionsUsecase()
    ]);

    if(isClosed)
      return;

    final Either<Failure, double> balanceResult = results[0] as Either<Failure, double>;
    final Either<Failure, List<WalletTransactionEntity>> walletTransactionsResult = results[1] as Either<Failure, List<WalletTransactionEntity>>;

    balanceResult.fold<void>(
      (Failure failure) => emit(WalletGetFailureState(failure)),
      (double balance) => walletTransactionsResult.fold(
        (Failure failure) => emit(WalletGetFailureState(failure)),
        (List<WalletTransactionEntity> walletTransactions) => emit(
          WalletGetSuccessState(
            balance: balance,
            walletTransactions: walletTransactions
          )
        )
      )
    );
  }
}
