import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

final class RegisterUsecase {
  final AuthRepository _repository;

  const RegisterUsecase(this._repository);

  Future<Either<Failure, String>> call({
    required String name,
    required String phone,
    required String address
  }) => _repository.register(name: name, phone: phone, address: address);
}