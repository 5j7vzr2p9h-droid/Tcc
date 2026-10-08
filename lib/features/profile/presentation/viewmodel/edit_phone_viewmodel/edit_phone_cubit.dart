import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/request_phone_update_usecase.dart';
import 'edit_phone_state.dart';

final class EditPhoneCubit extends Cubit<EditPhoneState>{
  final RequestPhoneUpdateUsecase _requestPhoneUpdateUsecase;

  EditPhoneCubit(this._requestPhoneUpdateUsecase): super(const EditPhoneInitialState());

  void requestPhoneUpdate(String newPhone) async {
    emit(const EditPhoneRequestingState());
    (await _requestPhoneUpdateUsecase(newPhone)).fold(
      (Failure failure) => emit(EditPhoneRequestFailureState(failure)),
      (Unit unit) => emit(const EditPhoneRequestSuccessState())
    );
  }
}