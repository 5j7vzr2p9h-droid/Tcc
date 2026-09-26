import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecase/register_usecase.dart';
import 'register_state.dart';

final class RegisterCubit extends Cubit<RegisterState>{
  final RegisterUsecase _registerUsecase;

  RegisterCubit(this._registerUsecase): super(const RegisterInitialState());

  void register({
    required String name,
    required String phone,
    required String address
  }) async {
    emit(const RegisterLoadingState());
    (await _registerUsecase(
      name: name,
      phone: phone,
      address: address
    )).fold(
      (Failure failure) => emit(RegisterFailureState(failure)),
      (String message) => emit(RegisterSuccessState(message))
    );
  }
}