import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/profile_entity.dart';

sealed class const ProfileState();

final class const ProfileInitialState() extends ProfileState;

final class const ProfileLoadingState() extends ProfileState;

final class const ProfileGetSuccessState(
  final ProfileEntity profile
) extends ProfileState;

final class const ProfileGetFailureState(
  final Failure failure
) extends ProfileState;

final class const ProfileEditSuccessState(
  final ProfileEntity profile
) extends ProfileState;