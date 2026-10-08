import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/update_profile_usecase.dart';
import 'edit_profile_state.dart';

final class EditProfileCubit extends Cubit<EditProfileState>{
  final UpdateProfileUsecase _updateProfileUsecase;

  EditProfileCubit(this._updateProfileUsecase): super(const EditProfileInitialState());

  late ProfileEntity _profile;

  void init(ProfileEntity profile) => emit(EditProfileSetDataState(_profile = profile));

  void updateProfile({
    required String? name,
    required String? address,
    required String? imagePath
  }) async{
    emit(EditProfileUpdatingState(_profile));

    final Either<Failure, ProfileEntity> result = await _updateProfileUsecase(
      name: name,
      address: address,
      imagePath: imagePath
    );

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(
        EditProfileFailureState(
          profile: _profile,
          failure: failure
        )
      ),
      (ProfileEntity profile) => emit(EditProfileSuccessState(_profile = profile))
    );
  }
}