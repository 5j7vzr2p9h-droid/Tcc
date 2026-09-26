import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

final class const LogoutUsecase(final AuthRepository _repository) {

  Future<Either<Failure, Unit>> call() => _repository.logout();
}