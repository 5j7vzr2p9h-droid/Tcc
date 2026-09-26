import '../../../../../core/errors/failures.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitialState extends RegisterState{
  
  const RegisterInitialState();

}
final class RegisterLoadingState extends RegisterState{

  const RegisterLoadingState();
}

final class RegisterFailureState extends RegisterState{
  final Failure failure;

  const RegisterFailureState(this.failure);
}

final class RegisterSuccessState extends RegisterState{
  final String successMessage;

  const RegisterSuccessState(this.successMessage);
}