import '../../../../../core/errors/failures.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitialState extends LoginState{
  
  const LoginInitialState();

}
final class LoginLoadingState extends LoginState{

  const LoginLoadingState();
}

final class LoginFailureState extends LoginState{
  final Failure failure;

  const LoginFailureState(this.failure);
}

final class LoginSuccessState extends LoginState{

  const LoginSuccessState();
}