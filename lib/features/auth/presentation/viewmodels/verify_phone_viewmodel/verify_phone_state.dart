import '../../../../../core/errors/failures.dart';

sealed class VerifyPhoneState {
  const VerifyPhoneState();
}

final class VerifyPhoneInitialState extends VerifyPhoneState{
  
  const VerifyPhoneInitialState();

}
final class VerifyPhoneLoadingState extends VerifyPhoneState{

  const VerifyPhoneLoadingState();
}

final class VerifyPhoneFailureState extends VerifyPhoneState{
  final Failure failure;

  const VerifyPhoneFailureState(this.failure);
}

final class VerifyPhoneSuccessState extends VerifyPhoneState{
  const VerifyPhoneSuccessState();
}