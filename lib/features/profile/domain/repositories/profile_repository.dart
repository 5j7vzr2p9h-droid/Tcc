import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String? name,
    required String? address,
    required String? imagePath
  });
  Future<Either<Failure, Unit>> requestPhoneUpdate(String newPhone);
}