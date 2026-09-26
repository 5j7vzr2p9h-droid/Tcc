import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String phone
  });
  Future<Either<Failure, String>> register({
    required String name,
    required String phone,
    required String address
  });
  Future<Either<Failure, Unit>> verifyPhone({
    required String phone,
    required String code
  });
  Future<Either<Failure, String>> resendOtp(String phone);
  Future<Either<Failure, Unit>> logout();
}