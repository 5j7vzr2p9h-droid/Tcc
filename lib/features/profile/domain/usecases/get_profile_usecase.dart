import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

final class const GetProfileUsecase(final ProfileRepository _repository) {

  Future<Either<Failure, ProfileEntity>> call()
  => _repository.getProfile();
}