import '../repositories/auth_repository.dart';

final class const LogoutUsecase(final AuthRepository _repository) {

  void call() => _repository.logout();
}