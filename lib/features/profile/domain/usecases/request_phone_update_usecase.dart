import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

final class const RequestPhoneUpdateUsecase(final ProfileRepository _repository){
  
  Future<Either<Failure, Unit>> call(String newPhone)
  => _repository.requestPhoneUpdate(newPhone);
}