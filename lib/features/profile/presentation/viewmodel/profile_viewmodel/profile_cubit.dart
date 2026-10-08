import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../auth/domain/usecase/logout_usecase.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import 'profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState>{
  final GetProfileUsecase _getProfileUsecase;
  final LogoutUsecase  _logoutUsecase;

  new({
    required this._getProfileUsecase,
    required this._logoutUsecase
  }): super(const ProfileInitialState());

  late ProfileEntity _profile;

  void init() async{
    emit(const ProfileLoadingState());
    
    final Either<Failure, ProfileEntity> result = await _getProfileUsecase();

    if(isClosed)
      return;

    result.fold<void>(
      (Failure failure) => emit(ProfileGetFailureState(failure)),
      (ProfileEntity profile) => emit(ProfileGetSuccessState(_profile = profile))
    );
  }

  void logout() async => (await _logoutUsecase()).fold<void>(
    (Failure failure) => emit(LogoutFailureState(
      profile: _profile,
      failure: failure
    )),
    (Unit unit) => emit(const LogoutSuccessState())
  );

  void emitNewProfileData(ProfileEntity profile) => emit(ProfileEditSuccessState(profile));
}