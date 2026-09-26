import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

final class LoginUsecase {
  final AuthRepository _repository;

  const LoginUsecase(this._repository);

  Future<Either<Failure, Unit>> call({
    required String phone
  })
  => _repository.login(phone: phone);
}