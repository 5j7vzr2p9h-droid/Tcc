import '../../../../../core/errors/failures.dart';

sealed class const EditPhoneState();

final class const EditPhoneInitialState() extends EditPhoneState;

final class const EditPhoneRequestingState() extends EditPhoneState;

final class const EditPhoneRequestFailureState(final Failure failure) extends EditPhoneState;

final class const EditPhoneRequestSuccessState() extends EditPhoneState;