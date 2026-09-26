import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

final class VerifyPhoneUsecase {
  final AuthRepository _repository;

  const VerifyPhoneUsecase(this._repository);

  Future<Either<Failure, Unit>> call({
    required String phone,
    required String code
  })
  => _repository.verifyPhone(phone: phone, code: code);
}