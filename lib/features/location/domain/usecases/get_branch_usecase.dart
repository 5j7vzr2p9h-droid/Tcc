import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/branch_entity.dart';
import '../repositories/location_repository.dart';

final class const GetBranchUsecase(
  final LocationRepository _repository
){

  Future<Either<Failure, BranchEntity>> call ({
    required double lat,
    required double lng
  })
  => _repository.getBranch(lat: lat, lng: lng);
}