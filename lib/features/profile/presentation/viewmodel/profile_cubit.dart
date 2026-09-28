import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/domain/usecase/logout_usecase.dart';
import 'profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState>{
  final LogoutUsecase  _logoutUsecase;

  new(this._logoutUsecase): super(const ProfileInitialState());

  void init(){
    // =====================
    emit(const ProfileGetSuccessState());
  }

  void logout() async => (await _logoutUsecase()).fold<void>(
    (Failure failure) => emit(LogoutFailureState(failure)),
    (Unit unit) => emit(const LogoutSuccessState())
  );
}