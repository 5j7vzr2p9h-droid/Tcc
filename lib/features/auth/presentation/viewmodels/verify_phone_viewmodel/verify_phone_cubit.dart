import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecase/verify_phone_usecase.dart';
import 'verify_phone_state.dart';

final class VerifyPhoneCubit extends Cubit<VerifyPhoneState>{
  final VerifyPhoneUsecase _verifyPhoneUsecase;

  VerifyPhoneCubit(this._verifyPhoneUsecase): super(const VerifyPhoneInitialState());

  void verifyPhone({
    required String phone,
    required String code,
  }) async {
    emit(const VerifyPhoneLoadingState());
    (await _verifyPhoneUsecase(
      phone: phone,
      code: code
    )).fold(
      (Failure failure) => emit(VerifyPhoneFailureState(failure)),
      (Unit unit) => emit(const VerifyPhoneSuccessState())
    );
  }
}