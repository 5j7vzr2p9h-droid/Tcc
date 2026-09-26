import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

final class const ResendOtpUsecase(final AuthRepository _repository){

  Future<Either<Failure, String>> call(String phone)
  => _repository.resendOtp(phone);
}