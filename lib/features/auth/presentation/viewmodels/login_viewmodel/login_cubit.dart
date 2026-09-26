import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecase/login_usecase.dart';
import 'login_state.dart';

final class LoginCubit extends Cubit<LoginState>{
  final LoginUsecase _loginUsecase;

  LoginCubit(this._loginUsecase): super(const LoginInitialState());

  void login({
    required String phone
  }) async {
    emit(const LoginLoadingState());
    (await _loginUsecase(phone: phone)).fold(
      (Failure failure) => emit(LoginFailureState(failure)),
      (Unit unit) => emit(const LoginSuccessState())
    );
  }
}