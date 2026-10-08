import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/profile_entity.dart';

sealed class const EditProfileState();

final class const EditProfileInitialState() extends EditProfileState;

final class const EditProfileSetDataState(
  final ProfileEntity profile
) extends EditProfileState;

final class const EditProfileFailureState({
  required final ProfileEntity profile,
  required final Failure failure
}) extends EditProfileState;

final class const EditProfileSuccessState(
  final ProfileEntity profile
) extends EditProfileState;

final class const EditProfileUpdatingState(
  final ProfileEntity profile
) extends EditProfileState;