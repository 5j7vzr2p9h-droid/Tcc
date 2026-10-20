import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import 'profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState>{
  final GetProfileUsecase _getProfileUsecase;

  new({
    required this._getProfileUsecase,
  }): super(const ProfileInitialState());

  void init() async{
    emit(const ProfileLoadingState());
    
    final Either<Failure, ProfileEntity> result = await _getProfileUsecase();

    if(isClosed)
      return;

    result.fold<void>(
      (Failure failure) => emit(ProfileGetFailureState(failure)),
      (ProfileEntity profile) => emit(ProfileGetSuccessState(profile))
    );
  }

  void emitNewProfileData(ProfileEntity profile) => emit(ProfileEditSuccessState(profile));
}