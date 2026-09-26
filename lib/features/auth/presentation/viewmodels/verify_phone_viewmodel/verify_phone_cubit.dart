import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecase/resend_otp_usecase.dart';
import '../../../domain/usecase/verify_phone_usecase.dart';
import 'verify_phone_state.dart';

final class VerifyPhoneCubit extends Cubit<VerifyPhoneState>{
  final VerifyPhoneUsecase _verifyPhoneUsecase;
  final ResendOtpUsecase _resendOtpUsecase;

  VerifyPhoneCubit({
    required this._verifyPhoneUsecase,
    required this._resendOtpUsecase
  }): super(const VerifyPhoneInitialState());

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

  void resendOtp(String phone) async
  => (await _resendOtpUsecase(phone)).fold(
    (Failure failure) => emit(ResendOtpFailureState(failure)),
    (String message) => emit(ResendOtpSuccessState(message))
  );
}