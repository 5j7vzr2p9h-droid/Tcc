import '../../../../core/errors/failures.dart';

sealed class const ProfileState();

final class const ProfileInitialState() extends ProfileState;

final class const ProfileLoadingState() extends ProfileState;

final class const ProfileGetSuccessState(
) extends ProfileState;

final class const ProfileGetFailureState(
  final Failure failure
) extends ProfileState;

final class const LogoutFailureState(
  final Failure failure
) extends ProfileState;