import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

final class const UpdateProfileUsecase(final ProfileRepository _repository) {

  Future<Either<Failure, ProfileEntity>> call({
    required String? name,
    required String? address,
    required String? imagePath
  })
  => _repository.updateProfile(name: name, address: address, imagePath: imagePath);
}